module QDB.Server.Vote (voteAPI) where

import Control.Monad.IO.Class
import Data.Time.Clock
import Servant

import QDB.API.Vote
import QDB.Model.Quote
import QDB.Model.Vote
import QDB.Database
import QDB.Types

addVote :: Server AddVote
addVote id ty addr = withConnection $
    \conn -> do
        quote' <- liftIO $ addVoteToQuote conn id ty addr
        case quote' of
            Nothing    -> throwError err400
            Just quote -> return quote

voteAPI :: Server VoteAPI
voteAPI = addVote
