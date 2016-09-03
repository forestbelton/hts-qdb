{-# LANGUAGE OverloadedStrings #-}
module QDB.Server.Quote (quoteAPI) where

import Control.Monad.IO.Class
import Data.Time.Clock
import Servant

import QDB.API.Quote
import QDB.Model.Quote
import QDB.Types

dummyQuote :: IO Quote
dummyQuote = do
    time <- getCurrentTime
    return $ Quote (ID 0) time 0 0 ""

getQuote :: Server GetQuote
getQuote id = liftIO dummyQuote

getQuotes :: Server GetQuotes
getQuotes sortBy = return []

addQuote :: Server AddQuote
addQuote = liftIO dummyQuote

editQuote :: Server EditQuote
editQuote id action = liftIO dummyQuote

quoteAPI :: Server QuoteAPI
quoteAPI = getQuote
    :<|> getQuotes
    :<|> addQuote
    :<|> editQuote
