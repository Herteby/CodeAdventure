module Ability exposing (..)

import Effect
import Html.Styled exposing (..)
import Types exposing (..)


abilities : List Ability
abilities =
    [ attack
    , heal
    , fireball
    , icebolt
    , lightningStorm
    , shieldBash
    , holyShield
    , invisibility
    , engage
    , backstab
    , legSweep
    , warCry
    ]


attack : Ability
attack =
    { name = "Attack"
    , description = "Basic weapon attack"
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


heal : Ability
heal =
    { name = "Heal"
    , description = "Heal an ally"
    , target = Ally
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


fireball : Ability
fireball =
    { name = "Fireball"
    , description = "A ball of fire"
    , target = Enemy
    , cost = Mana 10
    , time = 1
    , damage = Just ( Fire, 10 )
    , effects = []
    }


icebolt : Ability
icebolt =
    { name = "Icebolt"
    , description = "A bolt of ice"
    , target = Enemy
    , cost = Mana 10
    , time = 1
    , damage = Just ( Ice, 10 )
    , effects = []
    }


lightningStorm : Ability
lightningStorm =
    { name = "Lightning Storm"
    , description = "A storm of lightning"
    , target = AllEnemies
    , cost = Mana 10
    , time = 1
    , damage = Just ( Lightning, 10 )
    , effects = []
    }


shieldBash : Ability
shieldBash =
    { name = "Shield Bash"
    , description = "Bash an enemy with your shield"
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Blunt, 10 )
    , effects = [ Effect.stunned (Seconds 20) ]
    }


holyShield : Ability
holyShield =
    { name = "Holy Shield"
    , description = "A shield of holy light"
    , target = Ally
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


invisibility : Ability
invisibility =
    { name = "Invisibility"
    , description = "Become invisible"
    , target = Self
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


engage : Ability
engage =
    { name = "Engage"
    , description = "Engage an enemy"
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


backstab : Ability
backstab =
    { name = "Backstab"
    , description = "Stab an enemy in the back"
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Piercing, 10 )
    , effects = []
    }


legSweep : Ability
legSweep =
    { name = "Leg Sweep"
    , description = "Sweep an enemy's legs"
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Blunt, 10 )
    , effects = []
    }


warCry : Ability
warCry =
    { name = "War Cry"
    , description = "A cry of war"
    , target = AllEnemies
    , cost = Stamina 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


info : Ability -> Html msg
info ability =
    div []
        [ div [] [ text ability.name ]
        , div [] []
        , div [] [ text ability.description ]
        ]
