module SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = Headmate
    | HeadmateText
    | HeadmateConfig


type CssIds
  = AppContainer
  | UserInputContainer
  | UserInput
  | HeadmatesContainer
  | HeadmateUserCopy
  | HeadmateNext

homepageNamespace =
    withNamespace "homepage"
