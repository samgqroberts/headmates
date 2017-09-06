module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

init : ( Model, Cmd Msg )
init =
  ( "Headmates", Cmd.none )

-- Main

main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
