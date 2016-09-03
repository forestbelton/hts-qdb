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

withConnection :: MonadIO m => (Connection -> IO a) -> m a
withConnection f = liftIO $ do
    conn <- connect connectInfo
    x <- f conn
    close conn
    return x

getQuote :: Server GetQuote
getQuote id = liftIO dummyQuote

getQuotes :: Server GetQuotes
getQuotes sortBy = return []

addQuote :: Server AddQuote
addQuote (AddQuoteRequest content) = withConnection $
    \conn -> createQuote conn content

editQuote :: Server EditQuote
editQuote id action = liftIO dummyQuote

quoteAPI :: Server QuoteAPI
quoteAPI = getQuote
    :<|> getQuotes
    :<|> addQuote
    :<|> editQuote
