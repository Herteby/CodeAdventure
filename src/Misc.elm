module Misc exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)


viewTime : Int -> Html msg
viewTime time =
    text <| String.fromFloat (toFloat time / 10) ++ "s"


void : Html msg
void =
    text ""


box : Float -> List (Attribute msg) -> List (Html msg) -> Html msg
box spacing attrs children =
    div
        ([ css [ displayFlex, flexDirection column ] ] ++ attrs)
        (case children of
            x :: xs ->
                x :: List.map (\child -> Html.Styled.div [ css [ marginTop (px spacing) ] ] [ child ]) xs

            _ ->
                []
        )


line : Float -> List (Attribute msg) -> List (Html msg) -> Html msg
line spacing attrs children =
    div
        ([ css [ displayFlex, flexDirection column ] ] ++ attrs)
        (case children of
            x :: xs ->
                x :: List.map (\child -> Html.Styled.div [ css [ marginLeft (px spacing) ] ] [ child ]) xs

            _ ->
                []
        )
