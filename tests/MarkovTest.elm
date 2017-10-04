module MarkovTest exposing (..)

import Markov exposing (buildMarkovFn)
import Expect exposing (Expectation)
import Test exposing (..)
import Dict
import Models exposing (MarkovDict)

markovTest : String -> Int -> MarkovDict -> Expectation
markovTest sourceText order expected =
  Expect.equal (buildMarkovFn sourceText order Dict.empty) expected

suite : Test
suite =
  describe "Building Markov Chains"
    [ describe "Order 2"
      [ test "case 1" <|
          \_ ->
            let
              expected = Dict.empty
                |> Dict.insert "aa" (
                  Dict.empty
                    |> Dict.insert "aa" 2
                )
            in
              markovTest "aaaa" 2 expected
      , test "case 2" <|
          \_ ->
            let
              expected = Dict.empty
                |> Dict.insert "ab" (
                  Dict.empty
                    |> Dict.insert "bb" 2
                )
                |> Dict.insert "bb" (
                  Dict.empty
                    |> Dict.insert "ba" 1
                )
                |> Dict.insert "ba" (
                  Dict.empty
                    |> Dict.insert "ab" 1
                )
            in
              markovTest "abbabb" 2 expected
      ]
    , describe "Order 3"
      [ test "case 1" <|
          \_ ->
            let
              expected = Dict.empty
                |> Dict.insert "aaa" (
                  Dict.empty
                    |> Dict.insert "aaa" 1
                )
            in
              markovTest "aaaa" 3 expected
      , test "case 2" <|
          \_ ->
            let
              expected = Dict.empty
                |> Dict.insert "abb" (
                  Dict.empty
                    |> Dict.insert "bba" 1
                )
                |> Dict.insert "bba" (
                  Dict.empty
                    |> Dict.insert "bab" 1
                )
                |> Dict.insert "bab" (
                  Dict.empty
                    |> Dict.insert "abb" 1
                )
            in
              markovTest "abbabb" 3 expected
      , test "case 3" <|
          \_ ->
            let
              expected = Dict.empty
                |> Dict.insert "abb" (
                  Dict.empty
                    |> Dict.insert "bba" 2
                    |> Dict.insert "bbb" 1
                )
                |> Dict.insert "bba" (
                  Dict.empty
                    |> Dict.insert "bab" 1
                    |> Dict.insert "baa" 1
                )
                |> Dict.insert "bab" (
                  Dict.empty
                    |> Dict.insert "abb" 1
                )
                |> Dict.insert "bbb" (
                  Dict.empty
                    |> Dict.insert "bba" 1
                )
                |> Dict.insert "baa" (
                  Dict.empty
                    |> Dict.insert "aab" 1
                )
                |> Dict.insert "aab" (
                  Dict.empty
                    |> Dict.insert "abb" 1
                )
            in
              markovTest "abbabbbaabba" 3 expected
      ]
    ]
