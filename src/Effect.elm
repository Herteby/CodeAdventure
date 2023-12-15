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


armor : Int -> Duration -> Effect
armor amount duration =
    { name = "Armor"
    , kind = Buff
    , description = "+" ++ String.fromInt amount ++ " armor against all damage"
    , duration = duration
    }
