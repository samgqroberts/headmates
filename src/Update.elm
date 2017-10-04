module Update exposing (..)

import Random exposing (Seed)

import Msgs exposing (Msg(..))
import Models exposing (..)
import Predictor exposing (predict)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case Debug.log "action" msg of
    UpdateUserInput newInput ->
      ( { model | userInput = newInput }, Random.generate UpdatePredictions (Random.int Random.minInt Random.maxInt) )
    UpdatePredictions seedInt ->
      let
        seed = Random.initialSeed seedInt
      in
        ( { model | headmates = (List.map (\h -> updateHeadmatePrediction seed model.userInput h) model.headmates) }, Cmd.none )

updateHeadmatePrediction : Seed -> String -> Headmate -> Headmate
updateHeadmatePrediction seed input headmate =
  { headmate | prediction = (predict seed input headmate.predictor)}
