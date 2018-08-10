module View exposing (..)

import Html exposing (Html, div, text, textarea, pre, span)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (autofocus, readonly, value)
import Models exposing (Model, Predictor(..), Prediction(..))
import Msgs exposing (Msg)
import SharedStyles exposing (..)

{ id, class } =
    homepageNamespace

view : Model -> Html Msg
view model =
  div [ id AppContainer ]
    [ div [ id UserInputContainer ]
      [ textarea [ id UserInput, onInput Msgs.UpdateUserInput, autofocus True, value model.userInput ] []
      ]
    , div [ id HeadmatesContainer ] (
      List.map (\h -> viewHeadmate model.userInput h) model.headmates
    )]

viewHeadmate : String -> Models.Headmate -> Html Msg
viewHeadmate userInput headmate =
  div [ class [ Headmate ] ]
    [ renderHeadmateText userInput headmate.prediction
    , renderHeadmateConfig headmate.predictor
    ]

renderHeadmateText : String -> Prediction -> Html Msg
renderHeadmateText userInput prediction =
  pre [ class [ HeadmateText ], onClick (Msgs.UpdateUserInput (userInput ++ predictionToString prediction))]
    [ span [ class [ HeadmateUserCopy ] ] [ text (if (String.isEmpty userInput) then " " else userInput) ]
    , span [ class [ HeadmateNext ] ] [ text (predictionToString prediction) ]
    ]

renderHeadmateConfig : Predictor -> Html Msg
renderHeadmateConfig predictor =
  div [ class [ HeadmateConfig ] ]
    [ case predictor of
        Markov markovConfig ->
          text <| String.concat
            [ "orderRange: "
            , toString markovConfig.orderRange
            , ", tokenizationType: "
            , toString markovConfig.tokenizationType
            ]
    ]

predictionToString : Prediction -> String
predictionToString prediction =
  case prediction of
    Prediction value -> value
    NoPrediction -> ""
