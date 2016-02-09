module Update where

import Model exposing (Model)
import Effects exposing (Effects)


type Action
    = MouseScroll (Int, Int)
    | Viewport (Int, Int)
    | Scroll Float


update : Action -> Model -> (Model, Effects Action )
update action model =
    let _ = Debug.log "scroll" model.scrollLevel in
    case action of
        MouseScroll (x, y) ->
            ({ model | x = x, y = y }, Effects.none)

        Viewport (x, y) ->
            ({ model | boundX = x, boundY = y }, Effects.none)

        Scroll level ->
          let
              scrollUpdate =
                  model.scrollLevel + (floor level)

              bound =
                  floor ((toFloat model.boundY) * 1.5)

              newScrollLevel =
                  if scrollUpdate <= 0 then
                    0
                  else if scrollUpdate > bound then
                    bound
                  else
                    scrollUpdate

          in
            ({ model | scrollLevel = newScrollLevel}, Effects.none)