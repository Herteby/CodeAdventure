module Ability exposing (..)

import Html.Styled exposing (..)
import Types exposing (Ability, DamageType(..))


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
    , energyCost = 0
    , time = 1
    , damage = Nothing
    , effects = []
    }


heal : Ability
heal =
    { name = "Heal"
    , description = "Heal an ally"
    , energyCost = 5
    , time = 1
    , damage = Nothing
    , effects = []
    }


fireball : Ability
fireball =
    { name = "Fireball"
    , description = "A ball of fire"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Fire, max = 10, min = 5 }
    , effects = []
    }


icebolt : Ability
icebolt =
    { name = "Icebolt"
    , description = "A bolt of ice"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Ice, max = 10, min = 5 }
    , effects = []
    }


lightningStorm : Ability
lightningStorm =
    { name = "Lightning Storm"
    , description = "A storm of lightning"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Lightning, max = 10, min = 5 }
    , effects = []
    }


shieldBash : Ability
shieldBash =
    { name = "Shield Bash"
    , description = "Bash an enemy with your shield"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Blunt, max = 10, min = 5 }
    , effects = []
    }


holyShield : Ability
holyShield =
    { name = "Holy Shield"
    , description = "A shield of holy light"
    , energyCost = 5
    , time = 1
    , damage = Nothing
    , effects = []
    }


invisibility : Ability
invisibility =
    { name = "Invisibility"
    , description = "Become invisible"
    , energyCost = 5
    , time = 1
    , damage = Nothing
    , effects = []
    }


engage : Ability
engage =
    { name = "Engage"
    , description = "Engage an enemy"
    , energyCost = 5
    , time = 1
    , damage = Nothing
    , effects = []
    }


backstab : Ability
backstab =
    { name = "Backstab"
    , description = "Stab an enemy in the back"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Piercing, max = 10, min = 5 }
    , effects = []
    }


legSweep : Ability
legSweep =
    { name = "Leg Sweep"
    , description = "Sweep an enemy's legs"
    , energyCost = 5
    , time = 1
    , damage = Just { damageType = Blunt, max = 10, min = 5 }
    , effects = []
    }


warCry : Ability
warCry =
    { name = "War Cry"
    , description = "A cry of war"
    , energyCost = 5
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
