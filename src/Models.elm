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

-- how to define a "gram"?
type TokenizationType
  = Character
  | Word

-- what's needed to make a Markov based prediction
type alias MarkovConfig =
  { orderRange : (Int, Int)
  , tokenizationType : TokenizationType
  }
-- what's needed to build a single Markov prediction dictionary
type alias SingleMarkovConfig =
  { order : Int
  , tokenizationType : TokenizationType
  }
type alias MarkovDict = Dict (List String) (Dict (List String) Int)

-- something capable of predicting the next phrase of text
type Predictor
  = Markov MarkovConfig

-- the result of applying a Predictor on source text
type Prediction
  = Prediction String
  | NoPrediction
