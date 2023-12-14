module Main exposing (main)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Time


type alias Model =
    { party : List Character
    , enemies : List Character
    }


type alias Character =
    { name : String
    , stats : Stats
    , health : Int
    , maxHealth : Int
    , armor : Int
    , maxEnergy : Int
    , energy : Int
    , energyRegen : Int
    , effects : List Effect
    , casting : Maybe ( Ability, Int )
    }


type alias Stats =
    { strength : Int
    , dexterity : Int
    , constitution : Int
    , intelligence : Int
    , willpower : Int
    }


type Effect
    = Regeneration
    | Shield
    | Burn
    | Freeze
    | Bleed
    | Poison
    | Stun


type alias EffectRecord =
    { name : String
    , description : String
    }


initialModel : Model
initialModel =
    { party =
        [ initCharacter "Fighter"
        , initCharacter "Wizard"
        , initCharacter "Cleric"
        , initCharacter "Rogue"
        ]
    , enemies = []
    }


initCharacter : String -> Character
initCharacter name =
    { name = name
    , stats = { strength = 10, dexterity = 10, constitution = 10, intelligence = 10, willpower = 10, luck = 10 }
    , health = 100
    , maxHealth = 100
    , armor = 10
    , maxEnergy = 100
    , energy = 100
    , energyRegen = 5
    , effects = []
    , casting = Nothing
    }


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( model, Cmd.none )


bar : Color -> Int -> Int -> Html Msg
bar barColor value max =
    div
        [ css
            [ width (px 100)
            , height (px 20)
            , position relative
            , backgroundColor (rgb 0 0 0)
            , borderRadius (px 5)
            , overflow hidden
            ]
        ]
        [ div
            [ css
                [ width (px (toFloat (100 * value // max)))
                , height (px 20)
                , backgroundColor barColor
                ]
            ]
            []
        , div
            [ css
                [ width (px 100)
                , height (px 20)
                , position absolute
                , textAlign center
                , lineHeight (px 20)
                , top (px 0)
                ]
            ]
            [ text (String.fromInt value ++ "/" ++ String.fromInt max)
            ]
        ]


healthBar : Character -> Html Msg
healthBar character =
    bar (rgb 200 20 20) character.health character.maxHealth


energyBar : Character -> Html Msg
energyBar character =
    bar (rgb 20 50 200) character.energy character.maxEnergy


castingBar : Character -> Html Msg
castingBar character =
    bar (rgb 255 200 20) character.energy character.maxEnergy


characterView : Character -> Html Msg
characterView character =
    div
        []
        [ text character.name
        , healthBar character
        , energyBar character
        , castingBar character
        ]


view : Model -> Html Msg
view model =
    div
        [ css
            [ displayFlex
            , color (rgb 255 255 255)
            , textShadow4 (px 1) (px 1) (px 1) (rgb 0 0 0)
            ]
        ]
        [ div
            [ css [ displayFlex, flexDirection column ] ]
            (List.map characterView model.party)
        , div
            [ css [ displayFlex, flexDirection column ] ]
            (List.map characterView model.enemies)
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view >> toUnstyled
        , update = update
        , subscriptions = \_ -> Time.every 100 Tick
        }
