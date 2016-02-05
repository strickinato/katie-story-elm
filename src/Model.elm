module Model where

type alias Model =
  { x : Int
  , y : Int
  , boundX : Int
  , boundY : Int
  , color: String
  , scrollLevel : Int
  }

model : Model
model =
    { x = 300
    , y = 300
    , boundX = 0
    , boundY = 0
    , color = "black"
    , scrollLevel = 0
    }
