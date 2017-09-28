module View exposing (..)

import Html exposing (Html, div, text, textarea)
import Html.Events exposing (onInput)
import Html.Attributes exposing (autofocus)
import Models exposing (Model)
import Msgs exposing (Msg)
import SharedStyles exposing (..)

{ id } =
    homepageNamespace

view : Model -> Html Msg
view model =
  div [ id AppContainer ]
    [ textarea [ id UserInput, onInput Msgs.UpdateUserInput, autofocus True ] [ text model.userInput ]
    ]
