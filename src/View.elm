module View exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Events exposing (onInput)
import Models exposing (Model)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
  div []
    [ textarea [ onInput Msgs.UpdateUserInput ] [ text model.userInput ]
    ]
