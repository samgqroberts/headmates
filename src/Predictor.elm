module Predictor exposing (..)

import Random exposing (Seed)
import Models exposing (Predictor(..), Prediction)
import Markov as MarkovFns

predict : Seed -> String -> Predictor -> Prediction
predict seed input predictor =
  case predictor of
     Markov config ->
       MarkovFns.predict seed input config
