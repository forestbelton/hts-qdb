module QDB.Server.Vote (voteAPI) where

import Control.Monad.IO.Class
import Data.Time.Clock
import Servant

import QDB.API.Vote
import QDB.Model.Quote
import QDB.Model.Vote
import QDB.Types

addVote :: Server AddVote
addVote id ty = liftIO dummyQuote

voteAPI :: Server VoteAPI
voteAPI = addVote
