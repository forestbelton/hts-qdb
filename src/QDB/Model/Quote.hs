{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module QDB.Model.Quote where

import Data.Aeson.Types
import Data.Char
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
    }
    deriving (Eq, Show, Generic)

instance ToJSON Quote

instance FromRow Quote where
    fromRow = Quote
        <$> (ID <$> field)
        <*> field
        <*> field
        <*> (read <$> field)

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
    where q = "SELECT id, createdDate, content, state FROM quotes WHERE id = ?"

findQuotes :: Connection -> SortBy -> IO [Quote]
findQuotes conn crit = query_ conn q
    where q = "SELECT id, createdDate, content, state FROM quotes WHERE state = 'Approved' ORDER BY " `mappend` orderBy
          orderBy = case crit of
              Newest -> "createdDate DESC"
              Top    -> undefined -- TODO
              Random -> "RANDOM()"

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
    return $ Quote (ID id) createdDate content Pending

dummyQuote :: IO Quote
dummyQuote = do
    time <- getCurrentTime
    return $ Quote (ID 0) time "" Pending
