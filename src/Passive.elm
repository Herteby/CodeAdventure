module Passive exposing (..)

import Effect exposing (Effect(..))


type alias Passive =
    { name : String
    , effects : List Effect
    }


leatherArmor : Passive
leatherArmor =
    { name = "Leather Armor"
    , effects =
        [ FortifiedDefense
            { piercing = 3
            , slashing = 3
            , blunt = 1
            , fire = 3
            , ice = 3
            , lightning = 6
            , poison = 0
            }
        ]
    }


gambeson : Passive
gambeson =
    { name = "Gambeson"
    , effects =
        [ FortifiedDefense
            { piercing = 4
            , slashing = 4
            , blunt = 2
            , fire = 0
            , ice = 3
            , lightning = 4
            , poison = 0
            }
        ]
    }


buttedChainMail : Passive
buttedChainMail =
    { name = "Butted Chain Mail"
    , effects =
        [ FortifiedDefense
            { piercing = 3
            , slashing = 6
            , blunt = 1
            , fire = 3
            , ice = 2
            , lightning = 0
            , poison = 0
            }
        , ReducedSpeed 10
        ]
    }


rivetedChainMail : Passive
rivetedChainMail =
    { name = "Riveted Chain Mail"
    , effects =
        [ FortifiedDefense
            { piercing = 5
            , slashing = 6
            , blunt = 1
            , fire = 3
            , ice = 2
            , lightning = 0
            , poison = 0
            }
        , ReducedSpeed 10
        ]
    }


scaleArmor : Passive
scaleArmor =
    { name = "Scale Armor"
    , effects =
        [ FortifiedDefense
            { piercing = 3
            , slashing = 6
            , blunt = 4
            , fire = 6
            , ice = 3
            , lightning = 0
            , poison = 0
            }
        , ReducedSpeed 20
        ]
    }


plateArmor : Passive
plateArmor =
    { name = "Plate Armor"
    , effects =
        [ FortifiedDefense
            { piercing = 4
            , slashing = 8
            , blunt = 6
            , fire = 6
            , ice = 3
            , lightning = 0
            , poison = 0
            }
        , ReducedSpeed 30
        ]
    }


robe : Passive
robe =
    { name = "Robe"
    , effects =
        [ FortifiedDefense
            { piercing = 1
            , slashing = 1
            , blunt = 0
            , fire = 0
            , ice = 3
            , lightning = 3
            , poison = 0
            }
        ]
    }


shield : Passive
shield =
    { name = "Shield"
    , effects = [ Shield 50, ReducedSpeed 20 ]
    }
