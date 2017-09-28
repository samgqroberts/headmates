module SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = NavLink


type CssIds
  = AppContainer
  | UserInput

homepageNamespace =
    withNamespace "homepage"
