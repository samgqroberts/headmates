module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (..)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

init : ( Model, Cmd Msg )
init =
  (
    { userInput = ""
    , headmates =
        [ { predictor = Markov { orderRange = (1, 10), tokenizationType = Character }, prediction = NoPrediction }
        , { predictor = Markov { orderRange = (1, 10), tokenizationType = Word }, prediction = NoPrediction }
        ]
    }
  , Cmd.none
  )

-- Main

main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
