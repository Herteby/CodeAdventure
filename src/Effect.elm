module Effect exposing (..)

import Css exposing (color, rgb)
import DamageType exposing (DamageType(..))
import Defenses exposing (Defenses)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Misc exposing (..)


type Effect
    = Shield Int
    | FortifiedDefense Defenses
    | ReducedDefense Defenses
    | FortifiedPhysicalDamage Int
    | FortifiedMagicalDamage Int
    | ReducedPhysicalDamage Int
    | ReducedMagicalDamage Int
    | FortifiedSpeed Int
    | ReducedSpeed Int
    | Stunned
    | Invisible
    | Healing Int
    | Bleeding Int
    | MindControlled


type EffectKind
    = Buff
    | Debuff


type alias EffectInfo =
    { name : String
    , kind : EffectKind
    , description : List (Html Never)
    }


info : Effect -> EffectInfo
info effect =
    case effect of
        Shield chance ->
            { name = "Shield"
            , kind = Buff
            , description = [ text <| String.fromInt chance ++ "% chance to block any physical attack" ]
            }

        FortifiedDefense defense ->
            { name = "Fortified Defense"
            , kind = Buff
            , description =
                [ ( DamageType.view Piercing, defense.piercing )
                , ( DamageType.view Slashing, defense.slashing )
                , ( DamageType.view Blunt, defense.blunt )
                , ( DamageType.view Fire, defense.fire )
                , ( DamageType.view Ice, defense.ice )
                , ( DamageType.view Lightning, defense.lightning )
                , ( DamageType.view Poison, defense.poison )
                ]
                    |> List.filter (\( _, value ) -> value > 0)
                    |> List.map (\( damageType, value ) -> div [] [ text <| "+" ++ String.fromInt value, text " ", damageType ])
            }

        ReducedDefense defense ->
            { name = "Reduced Defense"
            , kind = Debuff
            , description =
                [ ( DamageType.view Piercing, defense.piercing )
                , ( DamageType.view Slashing, defense.slashing )
                , ( DamageType.view Blunt, defense.blunt )
                , ( DamageType.view Fire, defense.fire )
                , ( DamageType.view Ice, defense.ice )
                , ( DamageType.view Lightning, defense.lightning )
                , ( DamageType.view Poison, defense.poison )
                ]
                    |> List.filter (\( _, value ) -> value > 0)
                    |> List.map (\( damageType, value ) -> div [] [ text <| "-" ++ String.fromInt value, text " ", damageType ])
            }

        FortifiedPhysicalDamage amount ->
            { name = "Fortified Physical Damage"
            , kind = Buff
            , description = [ text <| "+" ++ String.fromInt amount ++ " physical damage" ]
            }

        FortifiedMagicalDamage amount ->
            { name = "Fortified Magical Damage"
            , kind = Buff
            , description = [ text <| "+" ++ String.fromInt amount ++ " magical damage" ]
            }

        ReducedPhysicalDamage amount ->
            { name = "Reduced Physical Damage"
            , kind = Debuff
            , description = [ text <| "-" ++ String.fromInt amount ++ " physical damage" ]
            }

        ReducedMagicalDamage amount ->
            { name = "Reduced Magical Damage"
            , kind = Debuff
            , description = [ text <| "-" ++ String.fromInt amount ++ " magical damage" ]
            }

        FortifiedSpeed amount ->
            { name = "Fortified Speed"
            , kind = Buff
            , description = [ text <| "+" ++ String.fromInt amount ++ "% speed" ]
            }

        ReducedSpeed amount ->
            { name = "Reduced Speed"
            , kind = Debuff
            , description = [ text <| "-" ++ String.fromInt amount ++ "% speed" ]
            }

        Stunned ->
            { name = "Stunned"
            , kind = Debuff
            , description = [ text <| "Unable to act" ]
            }

        Invisible ->
            { name = "Invisible"
            , kind = Buff
            , description = [ text <| "Invisible" ]
            }

        Healing amount ->
            { name = "Healing"
            , kind = Buff
            , description = [ text <| "+" ++ String.fromInt amount ++ " health / second" ]
            }

        Bleeding amount ->
            { name = "Bleeding"
            , kind = Debuff
            , description = [ text <| "-" ++ String.fromInt amount ++ " health / second" ]
            }

        MindControlled ->
            { name = "Mind Controlled"
            , kind = Debuff
            , description = [ text <| "Mind Controlled" ]
            }


view : EffectInfo -> Html msg
view effect =
    let
        c =
            case effect.kind of
                Buff ->
                    rgb 0 255 0

                Debuff ->
                    rgb 255 0 0
    in
    box 5
        []
        [ div [ css [ color c ] ] [ text effect.name ]
        , div [] effect.description
        ]
        |> Html.map never
