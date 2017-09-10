module SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = NavLink


type CssIds
    = UserInput

homepageNamespace =
    withNamespace "homepage"
