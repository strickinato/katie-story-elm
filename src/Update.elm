module Update where

import Model exposing (Model)
import Effects exposing (Effects)


type Action
    = MouseMove (Int, Int)
    | Viewport (Int, Int)
    | Scroll Float


update : Action -> Model -> (Model, Effects Action )
update action model =
    case action of
        MouseMove (x, y) ->
            ({ model | x = x, y = y }, Effects.none)

        Viewport (x, y) ->
            ({ model | boundX = x, boundY = y }, Effects.none)

        Scroll level ->
            ({ model | scrollLevel = (model.scrollLevel + (floor level))}, Effects.none)