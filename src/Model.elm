module Model where

type alias Model =
    { x : Int
    , y : Int
    , boundX : Int
    , boundY : Int
    , color: String
    , scrollLevel : Int
    , drops : List Drop
    }

type alias Drop =
  { coords : (Int, Int)
  , src : String
  }

model : Model
model =
    { x = 300
    , y = 300
    , boundX = 0
    , boundY = 0
    , color = "black"
    , scrollLevel = 0
    , drops = initDrops
    }

initDrops : List Drop
initDrops =
    [ { coords = (10, 10), src = "little.png" }]