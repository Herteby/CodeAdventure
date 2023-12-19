module DamageType exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


type DamageType
    = Piercing
    | Slashing
    | Blunt
    | Fire
    | Ice
    | Lightning
    | Poison
    | BestOf DamageType DamageType


view : DamageType -> Html msg
view damageType =
    case damageType of
        Piercing ->
            span [ css [ color (rgb 100 100 100) ] ] [ text "Piercing" ]

        Slashing ->
            span [ css [ color (rgb 100 100 100) ] ] [ text "Slashing" ]

        Blunt ->
            span [ css [ color (rgb 100 100 100) ] ] [ text "Blunt" ]

        Fire ->
            span [ css [ color (rgb 255 77 0) ] ] [ text "Fire" ]

        Ice ->
            span [ css [ color (rgb 0 196 255) ] ] [ text "Ice" ]

        Lightning ->
            span [ css [ color (rgb 255 255 0) ] ] [ text "Lightning" ]

        Poison ->
            span [ css [ color (rgb 12 166 0) ] ] [ text "Poison" ]

        BestOf a b ->
            span [ css [ color (rgb 100 100 100) ] ] [ view a, text " / ", view b ]
