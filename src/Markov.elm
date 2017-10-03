module Markov exposing (..)

import List
import Dict
import Random exposing (Seed)
import Array

import Models exposing (Markov)

predict : Seed -> String -> String
predict seed input =
  List.range 1 10
    |> List.sortBy negate
    |> List.filterMap (inputIntoPrediction seed input)
    |> List.foldr always ""

inputIntoPrediction : Seed -> String -> Int -> Maybe String
inputIntoPrediction seed input order =
    order
        |> buildMarkov input
        |> predictSingle seed input order

predictSingle : Seed -> String -> Int -> Markov -> Maybe String
predictSingle seed input order markov =
  case Dict.get (String.right order input) markov  of
    Nothing -> Nothing
    Just dict ->
      let
        values = Dict.toList dict
          |> List.map (\(gram, count) -> ((List.range 0 (count - 1)) |> List.map (\_ -> gram)))
          |> List.concat
        lastItem = List.length values - 1
        generator = Random.int 0 lastItem
        randomIndex = Tuple.first (Random.step generator seed)
      in
        Array.fromList values
          |> Array.get randomIndex

buildMarkov : String -> Int -> Markov
buildMarkov sourceText order =
  buildMarkovFn sourceText order Dict.empty

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
