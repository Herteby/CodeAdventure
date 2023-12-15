module Item exposing (..)

import Effect
import Html.Styled exposing (..)
import Misc
import Types exposing (..)


type alias WeaponTemplate =
    { time : Int
    , damageType : DamageType
    , hands : Hands
    , classes : List Class
    , name : String
    , material : Material
    }


type alias ArmorTemplate =
    { name : String
    , defense : Defense
    , classes : List Class
    , material : Material
    }


type Material
    = Metal
    | Wood
    | Magic
    | Leather
    | ChainMail


type alias Item =
    { name : String
    , quality : Quality
    , value : Int
    , kind : ItemKind
    , effects : List Effect
    , classes : List Class
    }


className : Class -> String
className c =
    case c of
        Warrior ->
            "Warrior"

        Rogue ->
            "Rogue"

        Cleric ->
            "Cleric"

        Wizard ->
            "Wizard"


view : Item -> Html msg
view item =
    div []
        [ div [] [ text item.name ]
        , div []
            [ case item.kind of
                Weapon time hands ( damageType, damage ) ->
                    div []
                        [ div []
                            [ text <|
                                case hands of
                                    OneHanded ->
                                        "One-handed"

                                    TwoHanded ->
                                        "Two-handed"
                            ]
                        , div [] [ Misc.viewTime time ]
                        , div [] [ text ("1-" ++ String.fromInt damage ++ " " ++ damageName damageType) ]
                        ]

                Shield ->
                    text "Shield"

                Armor armor ->
                    viewDefense armor
            , div [] [ text (String.fromInt item.value) ]
            , div [] (List.map Effect.view item.effects)
            , div [] (item.classes |> List.map className |> List.map text)
            ]
        ]


viewDefense : Defense -> Html msg
viewDefense armor =
    div []
        [ div [] [ text "Piercing: ", text (String.fromInt armor.piercing) ]
        , div [] [ text "Slashing: ", text (String.fromInt armor.slashing) ]
        , div [] [ text "Blunt: ", text (String.fromInt armor.blunt) ]
        , div [] [ text "Fire: ", text (String.fromInt armor.fire) ]
        , div [] [ text "Ice: ", text (String.fromInt armor.ice) ]
        , div [] [ text "Lightning: ", text (String.fromInt armor.lightning) ]
        , div [] [ text "Poison: ", text (String.fromInt armor.poison) ]
        ]


modValue : Quality -> Int -> Int
modValue q base =
    case q of
        Common ->
            base

        Fine ->
            base * 5

        Rare ->
            base * 25

        Legendary ->
            base * 125


mod : Quality -> Float
mod q =
    case q of
        Common ->
            1

        Fine ->
            1.2

        Rare ->
            1.5

        Legendary ->
            2


weaponKind : Int -> DamageType -> Hands -> Quality -> ItemKind
weaponKind time damageType hands q =
    let
        multiplier =
            case ( hands, damageType ) of
                ( OneHanded, BestOf _ _ ) ->
                    0.8

                ( TwoHanded, BestOf _ _ ) ->
                    1.5 * 0.8

                ( OneHanded, _ ) ->
                    1

                ( TwoHanded, _ ) ->
                    1.5
    in
    Weapon time hands ( damageType, round (toFloat time * multiplier * mod q) )


craftWeapon : WeaponTemplate -> Quality -> Item
craftWeapon template q =
    { name = prefix template.material q template.name
    , quality = q
    , value = modValue q 100
    , kind = weaponKind template.time template.damageType template.hands q
    , effects = []
    , classes = template.classes
    }


shield : Quality -> Item
shield q =
    let
        a =
            case q of
                Common ->
                    1

                Fine ->
                    2

                Rare ->
                    3

                Legendary ->
                    4
    in
    { name = prefix Metal q "Shield"
    , quality = q
    , value = modValue q 100
    , kind = Shield
    , effects = [ Effect.shield 33 Permanent, Effect.defenseAll a Permanent ]
    , classes = [ Warrior, Cleric ]
    }


longsword : WeaponTemplate
longsword =
    { time = 10
    , damageType = BestOf Slashing Piercing
    , hands = OneHanded
    , classes = [ Warrior, Rogue ]
    , name = "Longsword"
    , material = Metal
    }


dagger : WeaponTemplate
dagger =
    { time = 5
    , damageType = BestOf Slashing Piercing
    , hands = OneHanded
    , classes = [ Warrior, Rogue ]
    , name = "Dagger"
    , material = Metal
    }


bow : WeaponTemplate
bow =
    { time = 10
    , damageType = Piercing
    , hands = TwoHanded
    , classes = [ Warrior, Rogue ]
    , name = "Bow"
    , material = Wood
    }


crossbow : WeaponTemplate
crossbow =
    { time = 15
    , damageType = Piercing
    , hands = TwoHanded
    , classes = [ Warrior, Rogue, Cleric ]
    , name = "Crossbow"
    , material = Wood
    }


mace : WeaponTemplate
mace =
    { time = 12
    , damageType = Blunt
    , hands = OneHanded
    , classes = [ Warrior, Cleric ]
    , name = "Mace"
    , material = Metal
    }


greatsword : WeaponTemplate
greatsword =
    { time = 15
    , damageType = Slashing
    , hands = TwoHanded
    , classes = [ Warrior ]
    , name = "Greatsword"
    , material = Metal
    }


greatAxe : WeaponTemplate
greatAxe =
    { time = 17
    , damageType = BestOf Slashing Blunt
    , hands = TwoHanded
    , classes = [ Warrior ]
    , name = "Great Axe"
    , material = Metal
    }


halberd : WeaponTemplate
halberd =
    { time = 17
    , damageType = BestOf Slashing Piercing
    , hands = TwoHanded
    , classes = [ Warrior ]
    , name = "Halberd"
    , material = Wood
    }


pistol : WeaponTemplate
pistol =
    { time = 20
    , damageType = Piercing
    , hands = OneHanded
    , classes = [ Warrior, Cleric, Rogue, Wizard ]
    , name = "Pistol"
    , material = Wood
    }


musket : WeaponTemplate
musket =
    { time = 30
    , damageType = Piercing
    , hands = TwoHanded
    , classes = [ Warrior, Cleric, Rogue, Wizard ]
    , name = "Musket"
    , material = Wood
    }


staff : DamageType -> WeaponTemplate
staff damageType =
    { time = 15
    , damageType = damageType
    , hands = TwoHanded
    , classes = [ Wizard ]
    , name = damageName damageType ++ " Staff"
    , material = Metal
    }


craftArmor : ArmorTemplate -> Quality -> Item
craftArmor template q =
    { name = prefix template.material q template.name
    , quality = q
    , value = modValue q 100
    , kind = Armor (modDefense (mod q) template.defense)
    , effects = []
    , classes = template.classes
    }


modDefense : Float -> Defense -> Defense
modDefense m d =
    { fire = round (toFloat d.fire * m)
    , ice = round (toFloat d.ice * m)
    , lightning = round (toFloat d.lightning * m)
    , poison = round (toFloat d.poison * m)
    , piercing = round (toFloat d.piercing * m)
    , slashing = round (toFloat d.slashing * m)
    , blunt = round (toFloat d.blunt * m)
    }


baseDefense : Int -> Defense
baseDefense v =
    { fire = v
    , ice = v
    , lightning = v
    , poison = v
    , piercing = v
    , slashing = v
    , blunt = v
    }


robe : ArmorTemplate
robe =
    { name = "Robe"
    , defense = baseDefense 0
    , classes = [ Wizard ]
    , material = Magic
    }


leatherArmor : ArmorTemplate
leatherArmor =
    { name = "Armor"
    , defense = baseDefense 2 |> (\a -> { a | slashing = 6, blunt = 2 })
    , classes = [ Warrior, Rogue, Cleric ]
    , material = Leather
    }


chainMail : ArmorTemplate
chainMail =
    { name = "Chain Mail"
    , defense = baseDefense 5 |> (\a -> { a | piercing = 7, slashing = 9, blunt = 3, lightning = 2 })
    , classes = [ Warrior, Cleric ]
    , material = ChainMail
    }


plateArmor : ArmorTemplate
plateArmor =
    { name = "Plate Armor"
    , defense = baseDefense 10 |> (\a -> { a | piercing = 7, slashing = 11, blunt = 8, lightning = 2 })
    , classes = [ Warrior, Rogue ]
    , material = Metal
    }


damageName : DamageType -> String
damageName damageType =
    case damageType of
        Fire ->
            "Fire"

        Ice ->
            "Ice"

        Lightning ->
            "Lightning"

        Poison ->
            "Poison"

        Piercing ->
            "Piercing"

        Slashing ->
            "Slashing"

        Blunt ->
            "Bludgeoning"

        BestOf a b ->
            damageName a ++ " or " ++ damageName b


prefix : Material -> Quality -> String -> String
prefix material q s =
    case material of
        Metal ->
            case q of
                Common ->
                    "Bronze " ++ s

                Fine ->
                    "Steel " ++ s

                Rare ->
                    "Mithril " ++ s

                Legendary ->
                    "Adamantite " ++ s

        Wood ->
            case q of
                Common ->
                    "" ++ s

                Fine ->
                    "Well-crafted " ++ s

                Rare ->
                    "Masterwork " ++ s

                Legendary ->
                    "Ebony " ++ s

        Magic ->
            case q of
                Common ->
                    "Apprentice's " ++ s

                Fine ->
                    "Elder's " ++ s

                Rare ->
                    "Sorcerer's " ++ s

                Legendary ->
                    "Archmage's " ++ s

        Leather ->
            case q of
                Common ->
                    "Leather " ++ s

                Fine ->
                    "Thick hide " ++ s

                Rare ->
                    "Superior hide " ++ s

                Legendary ->
                    "Dragonscale " ++ s

        ChainMail ->
            case q of
                Common ->
                    "Butted " ++ s

                Fine ->
                    "Riveted " ++ s

                Rare ->
                    "Mithril " ++ s

                Legendary ->
                    "Adamantite " ++ s
