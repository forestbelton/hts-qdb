{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module QDB.Model.Quote where

import Data.Aeson.Types
import Data.Char
import qualified Data.Foldable as F
import Data.Maybe
import Data.Monoid
import qualified Data.Text as T
import Data.Time.Clock
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import GHC.Generics
import Web.HttpApiData

import QDB.Types

data QuoteState
    = Pending
    | Approved
    | Rejected
    deriving (Eq, Show, Read, Generic)

instance ToJSON QuoteState

data Quote = Quote
    { id          :: ID Quote
    , createdDate :: UTCTime
    , content     :: T.Text
    , state       :: QuoteState
    , upvotes     :: Int
    , downvotes   :: Int
    }
    deriving (Eq, Show, Generic)

instance ToJSON Quote

instance FromRow Quote where
    fromRow = Quote
        <$> (ID <$> field)
        <*> field
        <*> field
        <*> (read <$> field)
        <*> field
        <*> field

data SortBy
    = Newest
    | Top
    | Random
    deriving (Eq, Show, Read)

instance FromHttpApiData SortBy where
    parseUrlPiece = readUrlPiece

data QuoteAction
    = Approve
    | Reject
    deriving (Eq, Show, Read)

instance FromHttpApiData QuoteAction where
    parseUrlPiece = readUrlPiece

fromAction :: QuoteAction -> QuoteState
fromAction Approve = Approved
fromAction Reject  = Rejected

findQuote :: Connection -> ID Quote -> IO (Maybe Quote)
findQuote conn (ID quoteId) = listToMaybe <$> query conn q (Only quoteId)
    where q = F.fold [ "SELECT id, createdDate, content, state, COALESCE(upvotes, 0) AS upvotes, COALESCE(downvotes, 0) AS downvotes FROM"
                     , " (SELECT id, createdDate, content, state FROM quotes WHERE id = ?) e1"
                     , " LEFT JOIN LATERAL ("
                     , "     SELECT SUM(CASE WHEN type = 'Upvote' THEN 1 ELSE 0 END) AS upvotes,"
                     , "            SUM(CASE WHEN type = 'Downvote' THEN 1 ELSE 0 END) AS downvotes"
                     , "     FROM votes WHERE quoteId = e1.id) e2 ON TRUE"
                     ]

orderBy :: SortBy -> Query
orderBy Newest = "createdDate DESC"
orderBy Top    = "(COALESCE(upvotes, 0) - COALESCE(downvotes, 0)) DESC"
orderBy Random = "RANDOM()"

findQuotes :: Connection -> SortBy -> IO [Quote]
findQuotes conn crit = query_ conn q
    where q = F.fold [ "SELECT id, createdDate, content, state, COALESCE(upvotes, 0) AS upvotes, COALESCE(downvotes, 0) AS downvotes FROM"
                     , " (SELECT id, createdDate, content, state FROM quotes WHERE state = 'Approved') e1"
                     , " LEFT JOIN LATERAL ("
                     , "     SELECT SUM(CASE WHEN type = 'Upvote' THEN 1 ELSE 0 END) AS upvotes,"
                     , "            SUM(CASE WHEN type = 'Downvote' THEN 1 ELSE 0 END) AS downvotes"
                     , "     FROM votes WHERE quoteId = e1.id) e2 ON TRUE"
                     , " ORDER BY "
                     , orderBy crit
                     ]

finalizeQuote :: Connection -> ID Quote -> QuoteAction -> IO (Maybe Quote)
finalizeQuote conn id act = do
    quote' <- findQuote conn id
    case quote' of
        Nothing    -> return Nothing
        Just quote -> case state quote of
            Pending -> do
                updateQuoteState conn id act
                return $ Just $ quote { state = fromAction act }
            _       -> return Nothing

updateQuoteState :: Connection -> ID Quote -> QuoteAction -> IO ()
updateQuoteState conn (ID quoteId) act = do
    execute conn q (show (fromAction act) :: String, quoteId :: Integer)
    return ()
  where q = "UPDATE quotes SET state = ? WHERE id = ?"

createQuote :: Connection -> T.Text -> IO Quote
createQuote conn content = do
    [(id, createdDate)] :: [(Integer, UTCTime)] <- query conn "INSERT INTO quotes (content) VALUES (?) RETURNING id, createdDate" (Only content)
    return $ Quote (ID id) createdDate content Pending 0 0
