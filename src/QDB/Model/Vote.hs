{-# LANGUAGE DeriveGeneric #-}
module QDB.Model.Vote where

import Data.Aeson.Types
import Data.Time.Clock
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField
import GHC.Generics
import Web.HttpApiData

import QDB.Model.Quote
import QDB.Types

data VoteType
    = Upvote
    | Downvote
    deriving (Eq, Show, Read, Generic)

instance ToJSON VoteType

instance FromHttpApiData VoteType where
    parseUrlPiece = readUrlPiece

instance FromField VoteType where
    fromField f mbs = conversionMap go (fromField f mbs :: Conversion String)
        where go = fmap read

data Vote = Vote
    { id      :: ID Vote
    , quoteId :: ID Quote
    , ty      :: VoteType
    }
    deriving (Eq, Show, Generic)

instance ToJSON Vote

instance FromRow Vote where
    fromRow = Vote
        <$> (ID <$> field)
        <*> (ID <$> field)
        <*> field
