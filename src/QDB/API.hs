module QDB.API (qdbServer) where

import Servant

import QDB.API.Quote
import QDB.Server.Quote

type API = QuoteAPI

qdbServer :: Server API
qdbServer = quoteAPI
