{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module QDB.API.Vote where

import Servant.API

import QDB.Model.Quote
import QDB.Model.Vote
import QDB.Types

type AddVote = "quotes" :> Capture "id" (ID Quote) :> "vote" :> Capture "type" VoteType :> Put '[JSON] Quote

type VoteAPI = AddVote
