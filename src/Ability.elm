module Ability exposing (..)

import Css exposing (..)
import DamageType exposing (DamageType(..))
import Effect exposing (Effect(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Misc exposing (void)


type alias Ability =
    { name : String
    , description : Maybe String
    , target : Target
    , cost : Cost
    , time : Int
    , damage : Maybe ( DamageType, Int )
    , effects : List ( Effect, Int )
    }


type Target
    = Self
    | Ally
    | Enemy
    | AllAllies
    | AllEnemies


type Cost
    = Mana Int
    | Stamina Int


view : Ability -> Html msg
view ability =
    div []
        [ div [] [ text ability.name ]
        , case ability.description of
            Nothing ->
                void

            Just description ->
                div [] [ text description ]
        , case ability.damage of
            Nothing ->
                void

            Just ( damageType, damage ) ->
                div [] [ text (String.fromInt damage), text " ", DamageType.view damageType ]
        ]


attack : String -> Cost -> Int -> DamageType -> Int -> Ability
attack name cost time damageType damage =
    { name = "Attack: " ++ name
    , description = Nothing
    , target = Enemy
    , cost = cost
    , time = time
    , damage = Just ( damageType, damage )
    , effects = []
    }


dagger : Ability
dagger =
    attack "Dagger" (Stamina 5) 15 (BestOf Piercing Slashing) 7


longSword : Ability
longSword =
    attack "Long Sword" (Stamina 10) 30 (BestOf Piercing Slashing) 10


mace : Ability
mace =
    attack "Mace" (Stamina 10) 30 Blunt 12


axe : Ability
axe =
    attack "Axe" (Stamina 10) 30 Slashing 12


greatsword : Ability
greatsword =
    attack "Greatsword" (Stamina 15) 50 (BestOf Piercing Slashing) 20


spear : Ability
spear =
    attack "Spear" (Stamina 15) 50 Piercing 24


maul : Ability
maul =
    attack "Maul" (Stamina 15) 50 Blunt 24


halberd : Ability
halberd =
    attack "Halberd" (Stamina 15) 50 (BestOf Piercing Blunt) 20


bow : Ability
bow =
    attack "Bow" (Stamina 15) 30 Piercing 14


crossbow : Ability
crossbow =
    attack "Crossbow" (Stamina 15) 50 Piercing 20


musket : Ability
musket =
    attack "Musket" (Stamina 15) 100 Piercing 35


fireStaff : Ability
fireStaff =
    attack "Fire Staff" (Stamina 30) 30 Fire 12


iceStaff : Ability
iceStaff =
    attack "Ice Staff" (Stamina 30) 30 Ice 12


lightningStaff : Ability
lightningStaff =
    attack "Lightning Staff" (Stamina 30) 30 Lightning 12


claws : Ability
claws =
    attack "Claws" (Stamina 15) 15 Slashing 7


bite : Ability
bite =
    attack "Bite" (Stamina 15) 30 Piercing 12


heal : Ability
heal =
    { name = "Heal"
    , description = Nothing
    , target = Ally
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


fireball : Ability
fireball =
    { name = "Fireball"
    , description = Nothing
    , target = Enemy
    , cost = Mana 10
    , time = 1
    , damage = Just ( Fire, 10 )
    , effects = []
    }


icebolt : Ability
icebolt =
    { name = "Icebolt"
    , description = Nothing
    , target = Enemy
    , cost = Mana 10
    , time = 1
    , damage = Just ( Ice, 10 )
    , effects = []
    }


lightningStorm : Ability
lightningStorm =
    { name = "Lightning Storm"
    , description = Nothing
    , target = AllEnemies
    , cost = Mana 10
    , time = 1
    , damage = Just ( Lightning, 10 )
    , effects = []
    }


shieldBash : Ability
shieldBash =
    { name = "Shield Bash"
    , description = Nothing
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Blunt, 10 )
    , effects = [ ( Stunned, 20 ) ]
    }


holyShield : Ability
holyShield =
    { name = "Holy Shield"
    , description = Nothing
    , target = Ally
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


invisibility : Ability
invisibility =
    { name = "Invisibility"
    , description = Nothing
    , target = Self
    , cost = Mana 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


engage : Ability
engage =
    { name = "Engage"
    , description = Nothing
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Nothing
    , effects = []
    }


backstab : Ability
backstab =
    { name = "Backstab"
    , description = Nothing
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Piercing, 10 )
    , effects = []
    }


legSweep : Ability
legSweep =
    { name = "Leg Sweep"
    , description = Nothing
    , target = Enemy
    , cost = Stamina 10
    , time = 1
    , damage = Just ( Blunt, 10 )
    , effects = []
    }


warCry : Ability
warCry =
    { name = "War Cry"
    , description = Nothing
    , target = AllEnemies
    , cost = Stamina 10
    , time = 1
    , damage = Nothing
    , effects = []
    }
