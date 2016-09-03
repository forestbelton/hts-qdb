{-# LANGUAGE DeriveGeneric #-}
module QDB.Model.Vote where

import Data.Aeson.Types
import Data.Time.Clock
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

data Vote = Vote
    { id    :: ID Vote
    , quote :: Quote
    , ty    :: VoteType
    }
    deriving (Eq, Show, Generic)

instance ToJSON Vote
