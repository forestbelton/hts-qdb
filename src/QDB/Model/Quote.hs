{-# LANGUAGE DeriveGeneric #-}
module QDB.Model.Quote (Quote(..), SortBy(..), QuoteAction(..)) where

import Data.Aeson.Types
import Data.Char
import qualified Data.Text as T
import Data.Time.Clock
import GHC.Generics
import Web.HttpApiData

import QDB.Types

data Quote = Quote
    { id          :: ID Quote
    , createdDate :: UTCTime
    , upvotes     :: Integer
    , downvotes   :: Integer
    , content     :: T.Text
    }
    deriving (Show, Eq, Generic)

instance ToJSON Quote

data SortBy
    = Newest
    | Top
    | Random
    deriving (Read)

instance FromHttpApiData SortBy where
    parseUrlPiece = readUrlPiece

data QuoteAction
    = Approve
    | Deny
    | Upvote
    | Downvote
    deriving (Read)

instance FromHttpApiData QuoteAction where
    parseUrlPiece = readUrlPiece
