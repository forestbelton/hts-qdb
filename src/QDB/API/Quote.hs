{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
module QDB.API.Quote where

import Data.Aeson.Types
import qualified Data.Text as T
import GHC.Generics
import Servant.API

import QDB.Model.Quote
import QDB.Types

type GetQuote  = "quotes" :> Capture "id" (ID Quote) :> Get '[JSON] Quote
type GetQuotes = "quotes" :> Capture "sortBy" SortBy :> Get '[JSON] [Quote]
type AddQuote  = "quotes" :> ReqBody '[JSON] AddQuoteRequest :> Post '[JSON] Quote
type EditQuote = "quotes" :> Capture "id" (ID Quote) :> Capture "action" QuoteAction :> Put '[JSON] Quote

data AddQuoteRequest = AddQuoteRequest
    { content :: T.Text
    }
    deriving (Show, Eq, Generic)

instance FromJSON AddQuoteRequest

type QuoteAPI = GetQuote
    :<|> GetQuotes
    :<|> AddQuote
    :<|> EditQuote
