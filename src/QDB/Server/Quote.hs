module QDB.Server.Quote (quoteAPI) where

import Control.Monad.IO.Class
import Data.Time.Clock
import Database.PostgreSQL.Simple
import Servant

import QDB.API.Quote
import QDB.Model.Quote
import QDB.Types
import QDB.Database

getQuote :: ID Quote -> Handler Quote
getQuote id = withConnection $
    \conn -> do
        mq <- liftIO $ findQuote conn id
        checkFound mq

checkFound :: Maybe a -> Handler a
checkFound = maybe (throwError err404) return

getQuotes :: Server GetQuotes
getQuotes sortBy = withConnection $
    \conn -> liftIO $ findQuotes conn sortBy

addQuote :: Server AddQuote
addQuote (AddQuoteRequest content) = withConnection $
    \conn -> liftIO $ createQuote conn content

editQuote :: Server EditQuote
editQuote id action = withConnection $
    \conn -> do
        quote' <- liftIO $ finalizeQuote conn id action
        case quote' of
            Nothing    -> throwError err400
            Just quote -> return quote

quoteAPI :: Server QuoteAPI
quoteAPI = getQuote
    :<|> getQuotes
    :<|> addQuote
    :<|> editQuote
