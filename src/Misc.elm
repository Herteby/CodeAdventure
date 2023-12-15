module Misc exposing (..)

import Html.Styled exposing (..)


viewTime : Int -> Html msg
viewTime time =
    text <| String.fromFloat (toFloat time / 10) ++ "s"
