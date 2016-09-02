{-# LANGUAGE DeriveGeneric #-}
module QDB.Types where

import Data.Aeson.Types
import Data.Text
import Data.Time.Clock
import GHC.Generics

data ID a = ID Integer
    deriving (Show, Eq, Generic)

instance ToJSON (ID a)


