{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module QDB.Model.Vote where

import Data.List
import Data.Aeson.Types
import Data.Time.Clock
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField
import GHC.Generics
import Network.Socket
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

-- TODO: Make total
showSockAddr :: SockAddr -> String
showSockAddr (SockAddrInet _ addr) = intercalate "." $ map show [a,b,c,d]
    where (a,b,c,d) = hostAddressToTuple addr

addVoteToQuote :: Connection -> ID Quote -> VoteType -> SockAddr -> IO (Maybe Quote)
addVoteToQuote conn qid@(ID quoteId) ty addr = do
    execute conn q (quoteId, showSockAddr addr, show ty)
    findQuote conn qid
  where q = "INSERT INTO votes (quoteId, ipAddress, type) VALUES (?, ?, ?)"
