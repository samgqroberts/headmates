module Markov exposing (..)

import List
import Dict exposing (Dict)
import Random exposing (Seed)
import Array exposing (Array)

import Models exposing (MarkovDict, MarkovConfig, SingleMarkovConfig, Prediction(..), TokenizationType(..))

-- convert a source text input into a prediction for the following phrase
-- do so for each order in the config's order range
-- return the Prediction of the highest order that has a Prediction
-- TODO test the prediction logic
predict : Seed -> String -> MarkovConfig -> Prediction
predict seed input config =
  List.range (Tuple.first config.orderRange) (Tuple.second config.orderRange)
    |> List.sortBy negate
    |> List.map (\order -> { order = order, tokenizationType = config.tokenizationType })
    |> List.filterMap (inputIntoPrediction seed input)
    |> List.map Prediction
    |> List.foldr always NoPrediction

-- convert a source text input into a prediction for the following phrase
-- by building a MarkovDict
inputIntoPrediction : Seed -> String -> SingleMarkovConfig -> Maybe String
inputIntoPrediction seed input config =
  let
    (tokens, markovDict) = buildMarkov input config
  in
    predictSingle seed tokens config markovDict
      |> Maybe.map (
        case config.tokenizationType of
          Character -> String.concat
          Word -> \list -> " " ++ (String.join " " list)
      )

-- use a MarkovDict to predict the next k-gram of given order
predictSingle : Seed -> Array String -> SingleMarkovConfig -> MarkovDict -> Maybe (List String)
predictSingle seed tokens config markov =
  case Dict.get (Array.toList <| Array.slice -config.order (Array.length tokens) tokens) markov of
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

-- produce a tuple of (tokens, built markov dict with k-gram statistics of given source text)
-- can use the produced dict to predict probabilities of proceeding k-grams
buildMarkov : String -> SingleMarkovConfig -> (Array String, MarkovDict)
buildMarkov sourceText config =
  let
    tokens = tokenize sourceText config.tokenizationType
  in
    (tokens, buildMarkovFn config.order tokens Dict.empty)

tokenize : String -> TokenizationType ->  Array String
tokenize sourceText tokenizationType =
  case tokenizationType of
    Character ->
      String.toList sourceText
        |> List.map String.fromChar
        |> Array.fromList
    Word ->
      String.words sourceText
        |> Array.fromList

-- recursive function for building a MarkovDict
buildMarkovFn : Int -> Array String -> MarkovDict -> MarkovDict
buildMarkovFn order tokens currentMarkov =
  if (Array.length tokens < order * 2) then
    currentMarkov
  else
    buildMarkovFn
      order
      (Array.slice 1 (Array.length tokens) tokens)
      (addOneToKeyOfKey
        (Array.toList <| Array.slice 0 order tokens)
        (Array.toList <| Array.slice (order) (order * 2) tokens)
        currentMarkov)

{-
  helper functions dealing with building / mutating a MarkovDict
-}

addOneToKeyOfKey : (List String) -> (List String) -> MarkovDict -> MarkovDict
addOneToKeyOfKey firstKey secondKey currentMarkov =
  Dict.update firstKey (addOneToKey secondKey) currentMarkov

addOneToKey : (List String) -> Maybe (Dict (List String) Int) -> Maybe (Dict (List String) Int)
addOneToKey key maybeDict =
  case maybeDict of
    Just dict -> Just (Dict.update key addOne dict)
    Nothing -> Just (Dict.insert key 1 Dict.empty)

addOne : Maybe Int -> Maybe Int
addOne maybe =
  case maybe of
    Just value -> Just <| value + 1
    Nothing -> Just 1

{-
  end helper functions
-}
