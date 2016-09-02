{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module QDB.API.Quote where

import Servant.API

import QDB.Model.Quote
import QDB.Types

type GetQuote  = "quotes" :> Capture "id" (ID Quote) :> Get '[JSON] Quote
type GetQuotes = "quotes" :> Capture "sortBy" SortBy :> Get '[JSON] [Quote]
type AddQuote  = "quotes" :> "new" :> Post '[JSON] Quote
type EditQuote = "quotes" :> Capture "id" (ID Quote) :> Capture "action" QuoteAction :> Put '[JSON] Quote

type QuoteAPI = GetQuote
    :<|> GetQuotes
    :<|> AddQuote
    :<|> EditQuote
