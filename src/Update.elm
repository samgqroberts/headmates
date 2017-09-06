module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case Debug.log "action" msg of
    UpdateUserInput new ->
      ( { model | userInput = new }, Cmd.none )
