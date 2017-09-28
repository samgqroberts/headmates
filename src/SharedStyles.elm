module SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = Headmate


type CssIds
  = AppContainer
  | UserInputContainer
  | UserInput
  | HeadmatesContainer

homepageNamespace =
    withNamespace "homepage"
