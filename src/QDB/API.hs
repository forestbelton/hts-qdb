{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
module QDB.API where

import Servant

import QDB.API.Quote
import QDB.API.Vote
import QDB.Server.Quote
import QDB.Server.Vote

adminUser = "admin"
adminPass = "BqJvyGUqJsf9P06UJAeb"

type API = QuoteAPI :<|> VoteAPI

qdbServer :: Server API
qdbServer = quoteAPI
    :<|> voteAPI

qdbAPI :: Proxy API
qdbAPI = Proxy

authCheck :: BasicAuthCheck ()
authCheck = BasicAuthCheck check
    where check (BasicAuthData user pass) = if user == adminUser && pass == adminPass
                                                then return $ Authorized ()
                                                else return Unauthorized

basicAuthContext :: Context (BasicAuthCheck () ': '[])
basicAuthContext = authCheck :. EmptyContext
