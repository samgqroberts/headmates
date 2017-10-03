module Update exposing (..)

import Random exposing (Seed)

import Msgs exposing (Msg(..))
import Models exposing (Model, Markov)
import Markov exposing (predict, buildMarkov)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case Debug.log "action" msg of
    UpdateUserInput newInput ->
      ( { model | userInput = newInput }, Random.generate UpdatePredictions (Random.int Random.minInt Random.maxInt) )
    UpdatePredictions seedInt ->
      let
        seed = Random.initialSeed seedInt
        newMarkov = buildMarkov model.userInput 2
        nextSuggestion = predict seed model.userInput
      in
        ( { model | markov = newMarkov, suggestion = nextSuggestion }, Cmd.none )
