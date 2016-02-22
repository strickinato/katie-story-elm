module Model where

type alias Model =
    { x : Int
    , y : Int
    , boundX : Int
    , boundY : Int
    , storyHeight : Int
    , scrollLevel : Int
    , drops : List Drop
    , scrollStatus : ScrollStatus
    , top : Int
    }

type alias Drop =
  { x : Int
  , y : Int
  , dropType : DropType
  , sequence : Float
  }

type ScrollStatus
    = Scrolling
    | Top
    | Bottom

type DropType
    = Big
    | Small

model : Model
model =
    { x = 300
    , y = 300
    , boundX = 0
    , boundY = 0
    , storyHeight = 0
    , scrollLevel = 0
    , drops = initDrops
    , scrollStatus = Scrolling
    , top = 0
    }


initDrops : List Drop
initDrops =
    [ { x = -12, y = -20, dropType= Small, sequence = 0.1 }
    , { x = -30, y = -15, dropType= Small, sequence = 0.12 }
    , { x = -20, y = -11, dropType= Small, sequence = 0.15 }
    , { x = -10, y = -2, dropType= Small, sequence = 0.11 }
    , { x = -27, y = -8, dropType= Small, sequence = 0.17 }
    , { x = -24, y = 5, dropType= Small, sequence = 0.24 }
    , { x = -30, y = 10, dropType= Big, sequence = 0.3 }
    , { x = 0, y = 11, dropType= Small, sequence = 0.35 }
    , { x = 5, y = 27, dropType= Small, sequence = 0.23 }
    , { x = 7, y = 28, dropType= Small, sequence = 0.36 }
    , { x = 6, y = 29, dropType= Small, sequence = 0.4 }
    , { x = 8, y = 32, dropType= Small, sequence = 0.42 }
    , { x = 4, y = 31, dropType= Big, sequence = 0.44 }
    , { x = 3, y = 30, dropType= Small, sequence = 0.45 }
    , { x = 5, y = 34, dropType= Small, sequence = 0.46 }
    , { x = 2, y = 33, dropType= Small, sequence = 0.49 }
    , { x = 0, y = 35, dropType= Small, sequence = 0.5 }
    , { x = 1, y = 36, dropType= Big, sequence = 0.51 }
    , { x = 0, y = 37, dropType= Big, sequence = 0.53 }
    , { x = 1, y = 40, dropType= Small, sequence = 0.54 }
    , { x = -1, y = 38, dropType= Small, sequence = 0.54 }
    , { x = 2, y = 39, dropType= Small, sequence = 0.55 }
    , { x = 1, y = 42, dropType= Small, sequence = 0.55 }
    , { x = 0, y = 41, dropType= Small, sequence = 0.56 }
    , { x = -1, y = 44, dropType= Small, sequence = 0.56 }
    , { x = -2, y = 47, dropType= Small, sequence = 0.57 }
    , { x = -1, y = 43, dropType= Small, sequence = 0.59 }
    , { x = 2, y = 45, dropType= Small, sequence = 0.61 }
    , { x = -4, y = 48, dropType= Small, sequence = 0.61 }
    , { x = -1, y = 49, dropType= Small, sequence = 0.61 }
    , { x = -11, y = 49, dropType= Small, sequence = 0.61 }
    , { x = -3, y = 46, dropType= Big, sequence = 0.62 }
    , { x = -6, y = 49, dropType= Big, sequence = 0.63 }
    , { x = 1, y = 49, dropType= Small, sequence = 0.64 }
    , { x = 4, y = 49, dropType= Small, sequence = 0.64 }
    , { x = 8, y = 49, dropType= Small, sequence = 0.65 }
    , { x = -5, y = 48, dropType= Small, sequence = 0.66 }
    , { x = -18, y = 48, dropType= Small, sequence = 0.66 }
    , { x = 3, y = 47, dropType= Small, sequence = 0.66 }
    , { x = 15, y = 49, dropType= Small, sequence = 0.67 }
    , { x = -15, y = 49, dropType= Small, sequence = 0.67 }
    , { x = -12, y = 49, dropType= Small, sequence = 0.67 }
    , { x = 8, y = 49, dropType= Small, sequence = 0.67 }
    , { x = 15, y = 48, dropType= Small, sequence = 0.67 }
    , { x = -16, y = 47, dropType= Small, sequence = 0.68 }
    , { x = 20, y = 48, dropType= Big, sequence = 0.69 }
    , { x = -20, y = 49, dropType= Small, sequence = 0.70 }
    , { x = -28, y = 49, dropType= Small, sequence = 0.72 }
    , { x = 25, y = 49, dropType= Small, sequence = 0.73 }
    , { x = 15, y = 47, dropType= Small, sequence = 0.75 }
    , { x = -21, y = 49, dropType= Small, sequence = 0.75 }
    , { x = 21, y = 49, dropType= Small, sequence = 0.77 }
    , { x = -19, y = 48, dropType= Big, sequence = 0.77 }
    , { x = -30, y = 49, dropType= Small, sequence = 0.77 }
    , { x = 25, y = 49, dropType= Small, sequence = 0.80 }
    ]


womanSize : Float
womanSize = 0.75

womanScrollSpeed : Float
womanScrollSpeed = 0.75

womanHeight : Model -> Int
womanHeight model =
    model.storyHeight
        |> toFloat
        |> (*) womanSize
        |> round

womanScroll : Model -> Int
womanScroll model =
    let
        womanScroll =
           floor ((toFloat (model.scrollLevel * -1) * womanSize) * womanScrollSpeed)

        maxScroll =
            ((womanHeight model) - model.boundY)

    in
        if (womanScroll * -1) > maxScroll then
            (maxScroll * -1)
        else
            womanScroll


storyScrollTopToBottom : Model -> Int
storyScrollTopToBottom model =
    (model.storyHeight - model.boundY) + 1000


scrollPercentage : Model -> Float
scrollPercentage model =
    toFloat model.scrollLevel / (toFloat (storyScrollTopToBottom model))
