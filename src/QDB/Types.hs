{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module QDB.Types where

import qualified Data.Text as T
import Data.Aeson.Types
import Data.Text
import Data.Time.Clock
import Text.Read
import GHC.Generics
import Web.HttpApiData

data ID a = ID Integer
    deriving (Show, Eq, Generic)

instance ToJSON (ID a)

instance FromHttpApiData (ID a) where
    parseUrlPiece = fmap ID . readUrlPiece

readUrlPiece :: Read a => T.Text -> Either T.Text a
readUrlPiece t = case readMaybe $ T.unpack $ T.toLower t of
    Nothing -> Left $ T.append "invalid option: " t
    Just a  -> Right a

