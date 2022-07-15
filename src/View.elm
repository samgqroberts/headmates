module View exposing (..)

import Html exposing (Html, div, pre, span, text, textarea)
import Html.Attributes exposing (autofocus, readonly, style, value)
import Html.Events exposing (onClick, onInput)
import Models exposing (Model, Prediction(..), Predictor(..), TokenizationType(..))
import Msgs exposing (Msg)
import String exposing (fromInt)
import Tuple exposing (first, second)


view : Model -> Html Msg
view model =
    div
        [ style "position" "absolute"
        , style "left" "0"
        , style "right" "0"
        , style "top" "0"
        , style "bottom" "0"
        , style "display" "flex"
        , style "background-color" "rgb(251,251,251)"
        ]
        [ div [ style "flex" "1", style "padding" "30px", style "display" "flex" ]
            [ textarea
                [ style "padding" "16px"
                , style "padding-left" "24px"
                , style "padding-right" "24px"
                , style "flex-grow" "1"
                , style "color" "rgb(10,10,10)"
                , style "resize" "none"
                , style "border" "1px solid rgb(169,169,169)"
                , onInput Msgs.UpdateUserInput
                , autofocus True
                , value model.userInput
                ]
                []
            ]
        , div
            [ style "flex" "1"
            , style "overflow" "hidden"
            , style "padding" "30px"
            , style "display" "flex"
            , style "flex-direction" "column"
            , style "justify-content" "space-between"
            ]
            (List.map (\h -> viewHeadmate model.userInput h) model.headmates)
        ]


viewHeadmate : String -> Models.Headmate -> Html Msg
viewHeadmate userInput headmate =
    div []
        [ renderHeadmateText userInput headmate.prediction
        , renderHeadmateConfig headmate.predictor
        ]


renderHeadmateText : String -> Prediction -> Html Msg
renderHeadmateText userInput prediction =
    pre
        [ style "padding" "1em 24px"
        , style "margin" "0"
        , style "border" "1px solid rgb(169,169,169)"
        , style "white-space" "pre-wrap"
        , style "word-break" "break-all"
        , style "user-select" "none"
        , onClick (Msgs.UpdateUserInput (userInput ++ predictionToString prediction))
        ]
        [ span []
            [ text
                (if String.isEmpty userInput then
                    " "

                 else
                    userInput
                )
            ]
        , span [ style "color" "rgb(28,70,237)" ] [ text (predictionToString prediction) ]
        ]


renderHeadmateConfig : Predictor -> Html Msg
renderHeadmateConfig predictor =
    div
        [ style "padding" "1em 24px"
        , style "margin" "0"
        , style "border" "1px solid rgb(169,169,169)"
        , style "white-space" "pre-wrap"
        , style "word-break" "break-all"
        , style "user-select" "none"
        ]
        [ case predictor of
            Markov markovConfig ->
                text <|
                    String.concat
                        [ "orderRange: ("
                        , fromInt <| first markovConfig.orderRange
                        , ", "
                        , fromInt <| second markovConfig.orderRange
                        , ")"
                        , ", tokenizationType: "
                        , tokenizationTypeToString markovConfig.tokenizationType
                        ]
        ]


tokenizationTypeToString : TokenizationType -> String
tokenizationTypeToString tokenizationType =
    case tokenizationType of
        Character ->
            "Character"

        Word ->
            "Word"


predictionToString : Prediction -> String
predictionToString prediction =
    case prediction of
        Prediction value ->
            value

        NoPrediction ->
            ""
