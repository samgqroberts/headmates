module HomepageCss exposing (css)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
-- import Css.Display exposing (flex)
import SharedStyles exposing (..)
import StyleConstants exposing (..)

css =
    (stylesheet << namespace homepageNamespace.name)
        [ id AppContainer
            [ position absolute
            , left (px 0)
            , right (px 0)
            , top (px 0)
            , bottom (px 0)
            , padding (px 30)
            , displayFlex
            , justifyContent spaceAround
            , backgroundColor greyscale1
            ]
        , id UserInput
            [ padding (px 16)
            , paddingLeft (px 24)
            , paddingRight (px 24)
            , flexGrow (Css.num 1)
            , color greyscale9
            , verticalAlign middle
            , resize none
            ]
        ]
