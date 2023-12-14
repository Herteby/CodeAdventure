module Ability exposing (..)

import Html.Styled exposing (..)


type alias Ability =
    { name : String
    , description : String
    , target : Target
    , energyCost : Int
    , speed : Int
    }


type Damage
    = Fire
    | Ice
    | Lightning
    | Piercing
    | Slashing
    | Bludgeoning


type Target
    = Self
    | Enemy Stat
    | Ally
    | AllAllies
    | AllEnemies Stat


type Stat
    = Strength
    | Dexterity
    | Constitution
    | Intelligence
    | Willpower


type Abilityz
    = Attack
    | Heal
    | Fireball
    | Icebolt
    | LightningStorm
    | Backstab
    | ShieldBash
    | Regenerate
    | HolyShield
    | Invisibility


attack : Ability
attack =
    { name = "Attack"
    , description = "Basic weapon attack"
    , target = Enemy Dexterity
    , energyCost = 0
    , speed = 1
    }


heal : Ability
heal =
    { name = "Heal"
    , description = "Heal an ally"
    , target = Ally
    , energyCost = 5
    , speed = 1
    }


fireball : Ability
fireball =
    { name = "Fireball"
    , description = "A ball of fire"
    , target = Enemy Dexterity
    , energyCost = 5
    , speed = 1
    }


icebolt : Ability
icebolt =
    { name = "Icebolt"
    , description = "A bolt of ice"
    , target = Enemy Dexterity
    , energyCost = 5
    , speed = 1
    }


lightningStorm : Ability
lightningStorm =
    { name = "Lightning Storm"
    , description = "A storm of lightning"
    , target = AllEnemies Dexterity
    , energyCost = 5
    , speed = 1
    }


shieldBash : Ability
shieldBash =
    { name = "Shield Bash"
    , description = "Bash an enemy with your shield"
    , target = Enemy Dexterity
    , energyCost = 5
    , speed = 1
    }


holyShield : Ability
holyShield =
    { name = "Holy Shield"
    , description = "A shield of holy light"
    , target = Ally
    , energyCost = 5
    , speed = 1
    }


invisibility : Ability
invisibility =
    { name = "Invisibility"
    , description = "Become invisible"
    , target = Self
    , energyCost = 5
    , speed = 1
    }


info : Ability -> Html msg
info ability =
    div []
        [ div [] [ text ability.name ]
        , div []
            [ text <|
                case ability.target of
                    Self ->
                        "Self"

                    Enemy ->
                        "Enemy"

                    Ally ->
                        "Ally"

                    AllAllies ->
                        "All Allies"

                    AllEnemies ->
                        "All Enemies"
            ]
        , div [] [ text ability.description ]
        ]
