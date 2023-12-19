module Main exposing (main)

import Browser
import Character exposing (Character)
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Misc exposing (..)
import Time


type alias Model =
    { party : List Character
    , enemies : List Character
    }


type Msg
    = Tick Time.Posix


initialModel : Model
initialModel =
    { party = []
    , enemies = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( model, Cmd.none )


bar : Color -> Maybe String -> Int -> Int -> Html Msg
bar barColor txt value max =
    if max == 0 then
        void

    else
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
                    , backgroundImage (linearGradient (stop (rgba 0 0 0 0)) (stop (rgba 0 0 0 0.5)) [])
                    ]
                ]
                [ text (txt |> Maybe.withDefault (String.fromInt value ++ "/" ++ String.fromInt max))
                ]
            ]


healthBar : Character -> Html Msg
healthBar character =
    bar (rgb 200 20 20) Nothing character.health character.maxHealth


manaBar : Character -> Html Msg
manaBar character =
    bar (rgb 20 50 200) Nothing character.mana character.maxMana


staminaBar : Character -> Html Msg
staminaBar character =
    bar (rgb 20 200 20) Nothing character.stamina character.maxStamina


actionBar : Character -> Html Msg
actionBar character =
    case character.action of
        Ready ->
            bar (rgb 255 200 20) (Just "Ready") 1 1

        Preparing ability i ->
            bar (rgb 255 200 20) (Just ability.name) i ability.time

        Cooldown ability i ->
            bar (rgb 100 100 100) (Just ability.name) (ability.time - i) ability.time


characterView : Character -> Html Msg
characterView character =
    div
        [ css
            [ backgroundColor (rgb 90 90 90)
            , padding (px 5)
            , margin (px 5)
            , borderRadius (px 10)
            ]
        ]
        [ div [ css [ margin (px 5) ] ] [ text character.name ]
        , healthBar character
        , manaBar character
        , staminaBar character
        , actionBar character
        ]


view : Model -> Html Msg
view model =
    div
        [ css
            [ displayFlex
            , color (rgb 255 255 255)
            , textShadow4 (px 1) (px 1) (px 1) (rgb 0 0 0)
            , lineHeight (Css.em 1)
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
