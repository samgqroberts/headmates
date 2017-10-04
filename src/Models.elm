module Models exposing (..)

import Dict exposing (Dict)

type alias Model =
  { userInput : String
  , headmates: List Headmate
  }

type alias Headmate =
  { predictor : Predictor
  , prediction : Prediction
  }

type alias MarkovConfig =
  { orderRange : (Int, Int)
  }
type alias MarkovDict = Dict String (Dict String Int)

type Predictor
  = Markov MarkovConfig

type Prediction
  = Prediction String
  | NoPrediction
