module MarkovTest exposing (..)

import Markov exposing (buildMarkov)
import Expect exposing (Expectation)
import Test exposing (..)
import Dict exposing (empty, insert)
import Models exposing (MarkovDict, SingleMarkovConfig, TokenizationType(..))

markovTest : String -> SingleMarkovConfig -> MarkovDict -> Expectation
markovTest sourceText config expected =
  Expect.equal (Tuple.second <| buildMarkov sourceText config) expected

characterMarkovTest : String -> Int -> MarkovDict -> Expectation
characterMarkovTest sourceText order expected =
  markovTest sourceText { order = order, tokenizationType = Character } expected

wordMarkovTest : String -> Int -> MarkovDict -> Expectation
wordMarkovTest sourceText order expected =
  markovTest sourceText { order = order, tokenizationType = Word } expected

dictWith  : comparable -> a -> Dict.Dict comparable a
dictWith  k1 v1                         = empty |> insert k1 v1
dictWith2 : comparable -> a -> comparable -> a -> Dict.Dict comparable a
dictWith2 k1 v1 k2 v2                   = empty |> insert k1 v1 |> insert k2 v2
dictWith3 : comparable -> a -> comparable -> a -> comparable -> a -> Dict.Dict comparable a
dictWith3 k1 v1 k2 v2 k3 v3             = empty |> insert k1 v1 |> insert k2 v2 |> insert k3 v3
dictWith4 : comparable -> a -> comparable -> a -> comparable -> a -> comparable -> a -> Dict.Dict comparable a
dictWith4 k1 v1 k2 v2 k3 v3 k4 v4       = empty |> insert k1 v1 |> insert k2 v2 |> insert k3 v3 |> insert k4 v4
dictWith5 : comparable -> a -> comparable -> a -> comparable -> a -> comparable -> a -> comparable -> a -> Dict.Dict comparable a
dictWith5 k1 v1 k2 v2 k3 v3 k4 v4 k5 v5 = empty |> insert k1 v1 |> insert k2 v2 |> insert k3 v3 |> insert k4 v4 |> insert k5 v5

suite : Test
suite =
  describe "Building Markov Chains with Character tokenization"
    [ describe "with Character tokenization"
      [ describe "Order 2"
        [ test "case 1" <|
            \_ ->
              let
                expected = dictWith
                  ["a", "a"] (dictWith
                    ["a", "a"] 1
                  )
              in
                characterMarkovTest "aaaa" 2 expected
        , test "case 2" <|
            \_ ->
              let
                expected = dictWith3
                  ["a", "b"] (dictWith
                    ["b", "a"] 1
                  )
                  ["b", "b"] (dictWith
                    ["a", "b"] 1
                  )
                  ["b", "a"] (dictWith
                    ["b", "b"] 1
                  )
              in
                characterMarkovTest "abbabb" 2 expected
        ]
      , describe "Order 3"
        [ test "case 1" <|
            \_ ->
              let
                expected = empty
              in
                characterMarkovTest "aaaa" 3 expected
        , test "case 2" <|
            \_ ->
              let
                expected = dictWith
                  ["a", "b", "b"] (dictWith
                    ["a", "b", "b"] 1
                  )
              in
                characterMarkovTest "abbabb" 3 expected
        , test "case 3" <|
            \_ ->
              let
                expected = dictWith5
                  ["a", "b", "b"] (dictWith2
                    ["a", "b", "b"] 1
                    ["b", "a", "a"] 1
                  )
                  ["b", "b", "a"] (dictWith2
                    ["b", "b", "b"] 1
                    ["a", "b", "b"] 1
                  )
                  ["b", "a", "b"] (dictWith
                    ["b", "b", "a"] 1
                  )
                  ["b", "b", "b"] (dictWith
                    ["a", "a", "b"] 1
                  )
                  ["b", "a", "a"] (dictWith
                    ["b", "b", "a"] 1
                  )
              in
                characterMarkovTest "abbabbbaabba" 3 expected
        ]
      ]
    , describe "with Word tokenization"
      [ describe "Order 2"
        [ test "case 1 - no whitespace" <|
          \_ ->
            let
              expected = empty
            in
              wordMarkovTest "aaaa" 2 expected
        , test "case 2 - whitespace but still empty dict" <|
          \_ ->
            let
              expected = empty
            in
              wordMarkovTest "aa bb cc" 2 expected
        , test "case 3 - with repeats" <|
          \_ ->
            let
              expected = dictWith3
                ["aa", "bb"] (dictWith2
                  ["aa", "bb"] 1
                  ["cc", "aa"] 2
                )
                ["bb", "cc"] (dictWith
                  ["aa", "bb"] 2
                )
                ["cc", "aa"] (dictWith2
                  ["bb", "aa"] 1
                  ["bb", "cc"] 1
                )
            in
              wordMarkovTest "aa bb cc aa bb cc aa bb aa bb" 2 expected
        ]
      , describe "Order 3"
        [ test "case 1" <|
          \_ ->
            let
              expected = dictWith3
                ["aa", "bb", "cc"] (dictWith2
                  ["aa", "bb", "cc"] 1
                  ["aa", "bb", "aa"] 1
                )
                ["bb", "cc", "aa"] (dictWith2
                  ["bb", "cc", "aa"] 1
                  ["bb", "aa", "bb"] 1
                )
                ["cc", "aa", "bb"] (dictWith
                  ["cc", "aa", "bb"] 1
                )
            in
              wordMarkovTest "aa bb cc aa bb cc aa bb aa bb" 3 expected
        ]
      ]
    ]
