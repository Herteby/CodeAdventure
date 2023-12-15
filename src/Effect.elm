module Effect exposing (..)

import Html.Styled exposing (..)
import Misc
import Types exposing (..)


type alias Effect =
    { name : String
    , kind : EffectKind
    , description : String
    , duration : Duration
    }


view : Effect -> Html msg
view effect =
    div []
        [ div [] [ text effect.name ]
        , div [] [ text effect.description ]
        , div []
            [ case effect.duration of
                Permanent ->
                    text ""

                Seconds duration ->
                    Misc.viewTime duration
            ]
        ]


shield : Int -> Duration -> Effect
shield chance duration =
    { name = "Shield"
    , kind = Buff
    , description = String.fromInt chance ++ "% chance to block any attack"
    , duration = duration
    }


defenseAll : Int -> Duration -> Effect
defenseAll amount duration =
    { name = "Defense"
    , kind = Buff
    , description = "+" ++ String.fromInt amount ++ " defense against all damage"
    , duration = duration
    }


defensePhysical : Int -> Duration -> Effect
defensePhysical amount duration =
    { name = "Defense"
    , kind = Buff
    , description = "+" ++ String.fromInt amount ++ " defense against physical damage"
    , duration = duration
    }


defenseMagical : Int -> Duration -> Effect
defenseMagical amount duration =
    { name = "Defense"
    , kind = Buff
    , description = "+" ++ String.fromInt amount ++ " defense against magical damage"
    , duration = duration
    }


stunned : Duration -> Effect
stunned duration =
    { name = "Stunned"
    , kind = Debuff
    , description = "Unable to act"
    , duration = duration
    }
