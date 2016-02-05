module Model where

type alias Model =
  { x : Int
  , y : Int
  , boundX : Int
  , boundY : Int
  , color: String
  }

model : Model
model =
    { x = 300
    , y = 300
    , boundX = 0
    , boundY = 0
    , color = "white"
    }
