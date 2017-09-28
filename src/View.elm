module View exposing (..)

import Html exposing (Html, div, text, textarea, pre)
import Html.Events exposing (onInput)
import Html.Attributes exposing (autofocus, readonly)
import Models exposing (Model)
import Msgs exposing (Msg)
import SharedStyles exposing (..)

{ id, class } =
    homepageNamespace

view : Model -> Html Msg
view model =
  div [ id AppContainer ]
    [ div [ id UserInputContainer ]
        [ textarea [ id UserInput, onInput Msgs.UpdateUserInput, autofocus True ] [ text model.userInput ]
        ]
    , div [ id HeadmatesContainer ]
        [ pre [ class [ Headmate ] ] [ text model.userInput]
        , pre [ class [ Headmate ] ] [ text model.userInput]
        , pre [ class [ Headmate ] ] [ text model.userInput]
        ]
    ]
