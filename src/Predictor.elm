module Predictor exposing (..)

import Markov as MarkovFns
import Models exposing (Prediction, Predictor(..))
import Random exposing (Seed)


predict : Seed -> String -> Predictor -> Prediction
predict seed input predictor =
    case predictor of
        Markov config ->
            MarkovFns.predict seed input config
