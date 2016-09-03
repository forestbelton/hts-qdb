module QDB.Server.Quote (quoteAPI) where

import Control.Monad.IO.Class
import Data.Time.Clock
import Database.PostgreSQL.Simple
import Servant

import QDB.API.Quote
import QDB.Model.Quote
import QDB.Types

connectInfo :: ConnectInfo
connectInfo = defaultConnectInfo
    { connectHost = "localhost"
    , connectPort = 5432
    , connectUser = "ujboldoppi4v4ge7kyfc"
    , connectPassword = "p1pFM5Cruo9GGFhu3EZt"
    , connectDatabase = "qdb"
    }

withConnection :: MonadIO m => (Connection -> m a) -> m a
withConnection f = do
    conn <- liftIO $ connect connectInfo
    x <- f conn
    liftIO $ close conn
    return x

getQuote :: ID Quote -> Handler Quote
getQuote id = withConnection $
    \conn -> do
        mq <- liftIO $ findQuote conn id
        checkFound mq

checkFound :: Maybe a -> Handler a
checkFound = maybe (throwError err404) return

getQuotes :: Server GetQuotes
getQuotes sortBy = return []

addQuote :: Server AddQuote
addQuote (AddQuoteRequest content) = withConnection $
    \conn -> liftIO $ createQuote conn content

editQuote :: Server EditQuote
editQuote id action = liftIO dummyQuote

quoteAPI :: Server QuoteAPI
quoteAPI = getQuote
    :<|> getQuotes
    :<|> addQuote
    :<|> editQuote
