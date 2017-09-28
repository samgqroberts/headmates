module Models exposing (..)

import Dict exposing (Dict)

type alias Model =
  { userInput : String
  , markov : Markov
  , headmateNext1 : String
  , headmateNext2 : String
  , headmateNext3 : String
  }

type alias Markov = Dict String (Dict String Int)
