module Main exposing (..)

import Browser exposing (Document, document)
import Models exposing (..)
import Msgs exposing (Msg)
import Subscriptions exposing (subscriptions)
import Tuple exposing (first)
import Update exposing (update)
import View exposing (view)


init : flags -> ( Model, Cmd Msg )
init flags =
    ( { userInput = ""
      , headmates =
            [ { predictor = Markov { orderRange = ( 1, 10 ), tokenizationType = Character }, prediction = NoPrediction }
            , { predictor = Markov { orderRange = ( 1, 10 ), tokenizationType = Word }, prediction = NoPrediction }
            ]
      }
    , Cmd.none
    )


doc : Model -> Document Msg
doc model =
    Document "Headmates" [ view model ]



-- Main


main : Program () Model Msg
main =
    document
        { init = init
        , view = doc
        , update = update
        , subscriptions = subscriptions
        }
