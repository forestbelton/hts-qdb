{-# LANGUAGE TypeOperators #-}
module QDB.API where

import Servant

import QDB.API.Quote
import QDB.API.Vote
import QDB.Server.Quote
import QDB.Server.Vote

type API = QuoteAPI :<|> VoteAPI

qdbServer :: Server API
qdbServer = quoteAPI
    :<|> voteAPI

qdbAPI :: Proxy API
qdbAPI = Proxy
