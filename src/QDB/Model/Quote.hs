{-# LANGUAGE DeriveGeneric #-}
module QDB.Model.Quote (Quote(..), SortBy(..), QuoteAction(..)) where

import Data.Aeson.Types
import Data.Text
import Data.Time.Clock
import GHC.Generics

import QDB.Types (ID)

data Quote = Quote
    { id          :: ID Quote
    , createdDate :: UTCTime
    , upvotes     :: Integer
    , downvotes   :: Integer
    , content     :: Text
    }
    deriving (Show, Eq, Generic)

instance ToJSON Quote

data SortBy
    = Newest
    | Top
    | Random

data QuoteAction
    = Approve
    | Deny
    | Upvote
    | Downvote
