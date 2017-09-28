module View exposing (..)

import Html exposing (Html, div, text, textarea, pre, span)
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
        [ headmate model.userInput model.headmateNext1
        , headmate model.userInput model.headmateNext2
        , headmate model.userInput model.headmateNext3
        ]
    ]

headmate : String -> String -> Html Msg
headmate userInput next =
  pre [ class [ Headmate ] ]
    [ span [ class [ HeadmateUserCopy ] ] [ text userInput ]
    , span [ class [ HeadmateNext ] ] [ text next ]
    ]
