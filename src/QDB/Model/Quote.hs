{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module QDB.Model.Quote where

import Data.Aeson.Types
import Data.Char
import qualified Data.Text as T
import Data.Time.Clock
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

dummyQuote :: IO Quote
dummyQuote = do
    time <- getCurrentTime
    return $ Quote (ID 0) time ""
