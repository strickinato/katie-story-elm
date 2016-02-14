module Update where

import Model exposing (Model, storyScrollTopToBottom)
import Effects exposing (Effects)
import Task
import Signal

type Action
    = MouseScroll (Int, Int)
    | Viewport (Int, Int)
    | SetStoryHeight Int
    | Scroll Float
    | NoOp


update : Signal.Address () -> Action -> Model -> (Model, Effects Action )
update requestStoryHeight action model =
    case action of
        MouseScroll (x, y) ->
            ({ model | x = x, y = y }, Effects.none)

        Viewport (x, y) ->
            ({ model | boundX = x, boundY = y }, Effects.task (getStoryHeight requestStoryHeight))

        Scroll level ->
          let
              scrollUpdate =
                  model.scrollLevel + (floor level)

              newScrollLevel =
                  if scrollUpdate <= 0 then
                    0
                  else if scrollUpdate > (storyScrollTopToBottom model) then
                    (model.storyHeight - model.boundY)
                  else
                    scrollUpdate
          in
            ({ model | scrollLevel = newScrollLevel}, Effects.none)

        SetStoryHeight height ->
            ({ model | storyHeight = height}, Effects.none)

        NoOp ->
            (model, Effects.none)


getStoryHeight : Signal.Address () -> Task.Task Effects.Never Action
getStoryHeight address =
    Task.map (\_ -> NoOp) (Signal.send address ())
