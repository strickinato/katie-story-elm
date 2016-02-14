module Model where

type alias Model =
    { x : Int
    , y : Int
    , boundX : Int
    , boundY : Int
    , storyHeight : Int
    , scrollLevel : Int
    , womanScale : Float
    , drops : List Drop
    }

type alias Drop =
  { x : Int
  , y : Int
  , src : String
  , sequence : Float
  }

model : Model
model =
    { x = 300
    , y = 300
    , boundX = 0
    , boundY = 0
    , storyHeight = 0
    , scrollLevel = 0
    , womanScale = 1.0
    , drops = initDrops
    }

{-
    x,y coordinates from the center point of the scaled woman
-}
initDrops : List Drop
initDrops =
    [ { x = -80, y = 50, src = "little.png", sequence = 0.2 }
    , { x = 25, y = 600, src = "little.png", sequence = 0.3 }
    , { x = -10, y = 580, src = "little.png", sequence = 0.4 }
    , { x = 10, y = 400, src = "little.png", sequence = 0.45 }
    , { x = 20, y = 500, src = "little.png", sequence = 0.6 }
    , { x = 40, y = 600, src = "little.png", sequence = 0.5 }
    , { x = -15, y = 550, src = "little.png", sequence = 0.55 }
    , { x = 10, y = 490, src = "little.png", sequence = 0.6 }
    , { x = -120, y = 300, src = "little.png", sequence = 0.5 }
    , { x = 15, y = 500, src = "little.png", sequence = 0.9 }
    ]


womanSize : Float
womanSize = 0.75

womanScrollSpeed : Float
womanScrollSpeed = 1.5

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

        _ = Debug.log "WomanScroll" womanScroll
        _ = Debug.log "maxScroll" maxScroll
    in
        if (womanScroll * -1) > maxScroll then
            (maxScroll * -1)
        else
            womanScroll


storyScrollRatio : Model -> Float
storyScrollRatio model =
    -1 * ((toFloat model.storyHeight) / (toFloat model.boundY))


storyScrollTopToBottom : Model -> Int
storyScrollTopToBottom model =
    model.storyHeight - model.boundY


scrollPercentage : Model -> Float
scrollPercentage model =
    toFloat model.scrollLevel / toFloat ((floor ((toFloat model.boundY))))
