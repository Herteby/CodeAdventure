module Character exposing (..)

import Ability exposing (Ability)
import Defenses exposing (Defenses)
import Effect exposing (EffectKind)
import Passive exposing (Passive)


type alias Character =
    { id : Int
    , name : String
    , class : Class
    , abilities : List Ability
    , passives : List Passive
    , defense : Defenses
    , maxHealth : Int
    , maxMana : Int
    , maxStamina : Int
    , health : Int
    , mana : Int
    , stamina : Int
    , effects : List ( EffectKind, Int )
    , action : Action
    }


type Action
    = Ready
    | Preparing Ability Int
    | Cooldown Ability Int


type Class
    = Warrior
    | Rogue
    | Wizard
    | Cleric
    | Undead
    | Beast
    | Dragon
    | Demon
    | Elemental
    | Construct
