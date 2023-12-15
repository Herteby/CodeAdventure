module Types exposing (..)

import Time


type alias Model =
    { party : List Character
    , enemies : List Character
    }


type alias Character =
    { id : Int
    , name : String
    , class : Class
    , race : Race
    , level : Int
    , abilities : List Ability
    , rightHand : Item
    , leftHand : Item
    , body : Item
    , defense : Defense
    , maxHealth : Int
    , maxMana : Int
    , maxStamina : Int
    , health : Int
    , mana : Int
    , stamina : Int
    , effects : List Effect
    , state : State
    }


type State
    = Ready
    | Preparing Ability Int
    | Cooldown Ability Int


type Class
    = Warrior
    | Rogue
    | Wizard
    | Cleric


type Race
    = Humanoid
    | Undead
    | Demon
    | Beast
    | Dragon
    | Elemental
    | Construct


type alias Item =
    { name : String
    , quality : Quality
    , value : Int
    , kind : ItemKind
    , effects : List Effect
    , classes : List Class
    }


type Quality
    = Common
    | Fine
    | Rare
    | Legendary


type ItemKind
    = Weapon Int Hands ( DamageType, Int )
    | Armor Defense
    | Shield


type Hands
    = OneHanded
    | TwoHanded


type alias Effect =
    { name : String
    , kind : EffectKind
    , description : String
    , duration : Duration
    }


type Duration
    = Permanent
    | Seconds Int


type EffectKind
    = Buff
    | Debuff


type Msg
    = Tick Time.Posix


type alias Ability =
    { name : String
    , description : String
    , target : Target
    , cost : Cost
    , time : Int
    , damage : Maybe ( DamageType, Int )
    , effects : List Effect
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


type alias Defense =
    { fire : Int
    , ice : Int
    , lightning : Int
    , poison : Int
    , piercing : Int
    , slashing : Int
    , blunt : Int
    }


type DamageType
    = Fire
    | Ice
    | Lightning
    | Poison
    | Piercing
    | Slashing
    | Blunt
    | BestOf DamageType DamageType
