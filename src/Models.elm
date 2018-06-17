module Models exposing (..)

import Dict exposing (Dict)

-- overall state
type alias Model =
  { userInput : String
  , headmates: List Headmate
  }

-- description of a particular headmate
type alias Headmate =
  { predictor : Predictor
  , prediction : Prediction
  }

-- what's needed to make a Markov based prediction
type alias MarkovConfig =
  { orderRange : (Int, Int)
  }
type alias MarkovDict = Dict String (Dict String Int)

-- something capable of predicting the next phrase of text
type Predictor
  = Markov MarkovConfig

-- the result of applying a Predictor on source text
type Prediction
  = Prediction String
  | NoPrediction
