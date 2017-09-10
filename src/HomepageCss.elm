module HomepageCss exposing (css)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import SharedStyles exposing (..)


css =
  (stylesheet << namespace homepageNamespace.name)
    [ id UserInput
      [ display inlineBlock
      , marginLeft (px 150)
      , marginRight (px 80)
      , verticalAlign middle
      ]
    ]
