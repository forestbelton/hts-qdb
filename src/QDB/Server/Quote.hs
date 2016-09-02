{-# LANGUAGE OverloadedStrings #-}
module QDB.Server.Quote (quoteAPI) where

import Servant

import QDB.API.Quote
import QDB.Model.Quote
import QDB.Types

dummyQuote :: Quote
dummyQuote = Quote (ID 0) undefined 0 0 ""

getQuote :: Server GetQuote
getQuote id = return dummyQuote

getQuotes :: Server GetQuotes
getQuotes sortBy = return []

addQuote :: Server AddQuote
addQuote = return dummyQuote

editQuote :: Server EditQuote
editQuote id action = return dummyQuote

quoteAPI :: Server QuoteAPI
quoteAPI = getQuote
    :<|> getQuotes
    :<|> addQuote
    :<|> editQuote
