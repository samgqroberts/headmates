module View exposing (..)

import Html exposing (Html, div, text, textarea, pre, span)
import Html.Events exposing (onInput)
import Html.Attributes exposing (autofocus, readonly)
import Models exposing (Model, Prediction(..))
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
    , div [ id HeadmatesContainer ] (List.map (\h -> viewHeadmate model.userInput h) model.headmates)
    ]

viewHeadmate : String -> Models.Headmate -> Html Msg
viewHeadmate userInput headmate =
  pre [ class [ Headmate ] ]
    [ span [ class [ HeadmateUserCopy ] ] [ text userInput ]
    , span [ class [ HeadmateNext ] ] [ text (viewPrediction headmate.prediction) ]
    ]

viewPrediction : Prediction -> String
viewPrediction prediction =
  case prediction of
    Prediction value -> value
    NoPrediction -> ""
