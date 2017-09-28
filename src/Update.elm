module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Markov)
import Dict
import String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case Debug.log "action" msg of
    UpdateUserInput new ->
      let
        newMarkov = buildMarkov new
      in
        ( { model | userInput = new, markov = newMarkov }, Cmd.none )

buildMarkov : String -> Markov
buildMarkov sourceText =
  buildMarkovFn sourceText 2 Dict.empty

buildMarkovFn : String -> Int -> Markov -> Markov
buildMarkovFn sourceText order currentMarkov =
  if (String.length sourceText) < order + 1 then
    currentMarkov
  else
    let
      kgram1 = String.slice 0 order sourceText
      kgram2 = String.slice 1 (order + 1) sourceText
      nextSourceText = String.dropLeft 1 sourceText
      nextMarkov = addOneToKeyOfKey kgram1 kgram2 currentMarkov
    in
      buildMarkovFn nextSourceText order nextMarkov

addOneToKeyOfKey : String -> String -> Markov -> Markov
addOneToKeyOfKey firstKey secondKey currentMarkov =
  Dict.update firstKey (addOneToKey secondKey) currentMarkov

addOneToKey : String -> Maybe (Dict.Dict String Int) -> Maybe (Dict.Dict String Int)
addOneToKey key maybeDict =
  case maybeDict of
    Just dict -> Just (Dict.update key addOne dict)
    Nothing -> Just (Dict.insert key 1 Dict.empty)

addOne : Maybe Int -> Maybe Int
addOne maybe =
  case maybe of
    Just value -> Just <| value + 1
    Nothing -> Just 1
