module Main where

import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Servant

import QDB.API

port :: Int
port = 8080

middleware :: Application -> Application
middleware = staticPolicy (addBase "client/static") . logStdout

main :: IO ()
main = do
    putStrLn $ "Now listening on port " ++ show port ++ "..."
    run port $ middleware $ serveWithContext qdbAPI basicAuthContext qdbServer
