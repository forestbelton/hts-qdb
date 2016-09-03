module QDB.Database where

import Control.Monad.IO.Class
import Database.PostgreSQL.Simple

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
