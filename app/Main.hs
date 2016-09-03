module Main where

import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Servant

import QDB.API

port :: Int
port = 8080

main :: IO ()
main = do
    putStrLn $ "Now listening on port " ++ show port ++ "..."
    run port $ logStdout $ serve qdbAPI qdbServer
