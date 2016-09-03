{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module QDB.Model.Quote where

import Data.Aeson.Types
import Data.Char
import Data.Maybe
import qualified Data.Text as T
import Data.Time.Clock
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import GHC.Generics
import Web.HttpApiData

import QDB.Types

data Quote = Quote
    { id          :: ID Quote
    , createdDate :: UTCTime
    , content     :: T.Text
    }
    deriving (Eq, Show, Generic)

instance ToJSON Quote

instance FromRow Quote where
    fromRow = Quote
        <$> (ID <$> field)
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
    | Deny
    deriving (Eq, Show, Read)

instance FromHttpApiData QuoteAction where
    parseUrlPiece = readUrlPiece

findQuote :: Connection -> ID Quote -> IO (Maybe Quote)
findQuote conn (ID quoteId) = listToMaybe <$> query conn q (Only quoteId)
    where q = "SELECT id, createdDate, content FROM quotes WHERE id = ?"

createQuote :: Connection -> T.Text -> IO Quote
createQuote conn content = do
    [(id, createdDate)] :: [(Integer, UTCTime)] <- query conn "INSERT INTO quotes (content) VALUES (?) RETURNING id, createdDate" (Only content)
    return $ Quote (ID id) createdDate content

dummyQuote :: IO Quote
dummyQuote = do
    time <- getCurrentTime
    return $ Quote (ID 0) time ""
