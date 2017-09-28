module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Dict

init : ( Model, Cmd Msg )
init =
  (
    { userInput = ""
    , markov = Dict.empty
    , headmateNext1 = "next 1"
    , headmateNext2 = "next 2"
    , headmateNext3 = "next 3"
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
