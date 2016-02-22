module Update where

import Model exposing (Model, storyScrollTopToBottom, ScrollStatus(..))
import Effects exposing (Effects)
import Task
import Signal

type Action
    = MouseScroll (Int, Int)
    | Viewport (Int, Int)
    | SetStoryHeight Int
    | Scroll Float
    | SetTop Int
    | NoOp

type alias Addresses =
    { storyHeightAddress : Signal.Address ()
    , topAddress : Signal.Address ()
    }


update : Addresses -> Action -> Model -> (Model, Effects Action )
update addresses action model =
    let _ = Debug.log "hi" model.top in
    case action of
        MouseScroll (x, y) ->
            ({ model | x = x, y = y }, Effects.none)

        Viewport (x, y) ->
            ({ model | boundX = x, boundY = y }, Effects.task (pingAddress addresses.storyHeightAddress))

        Scroll level ->
            let
                scrollUpdate =
                    model.scrollLevel + (floor level)

                (newScrollLevel, newScrollStatus) =
                    if scrollUpdate <= 0 then
                      (0, Scrolling)
                    else if scrollUpdate > (storyScrollTopToBottom model) then
                        (storyScrollTopToBottom model, Bottom)
                    else
                      (scrollUpdate, Scrolling)

                newModel =
                    if model.top >= 0 then
                        { model | scrollLevel = newScrollLevel, scrollStatus = newScrollStatus}
                    else
                        { model | scrollLevel = newScrollLevel, scrollStatus = newScrollStatus}
            in
                (newModel, Effects.task (pingAddress addresses.topAddress))

        SetStoryHeight height ->
            ({ model | storyHeight = height}, Effects.none)

        SetTop newTop ->
            ({ model | top = newTop }, Effects.none)

        NoOp ->
            (model, Effects.none)


pingAddress : Signal.Address () -> Task.Task Effects.Never Action
pingAddress address =
    Task.map (\_ -> NoOp) (Signal.send address ())
