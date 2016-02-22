module Update where

import Model exposing (Model, storyScrollTopToBottom, ScrollStatus(..))
import Effects exposing (Effects)
import Task
import Signal

type Action
    = Viewport (Int, Int)
    | SetStoryHeight Int
    | Scroll Float
    | ScrollParent Float
    | SetTop Int
    | NoOp

type alias Addresses =
    { storyHeightAddress : Signal.Address ()
    , topAddress : Signal.Address ()
    , scrollParentAddress : Signal.Address Float
    }


update : Addresses -> Action -> Model -> (Model, Effects Action )
update addresses action model =
    let
        _ = Debug.log "Scroll Level: " model.scrollLevel
        _ = Debug.log "Scroll Scroll Status: " model.scrollStatus
        _ = Debug.log "Scroll Top: " model.top

    in
    case action of
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
                    { model | scrollLevel = newScrollLevel, scrollStatus = newScrollStatus}
            in
                (newModel, Effects.task (pingAddress addresses.topAddress))

        ScrollParent level ->
            (model, Effects.task (Task.map (\_ -> NoOp) (Signal.send addresses.scrollParentAddress level)))

        SetStoryHeight height ->
            ({ model | storyHeight = height}, Effects.none)

        SetTop newTop ->
            ({ model | top = newTop }, Effects.none)

        NoOp ->
            (model, Effects.task (pingAddress addresses.topAddress))


pingAddress : Signal.Address () -> Task.Task Effects.Never Action
pingAddress address =
    Task.map (\_ -> NoOp) (Signal.send address ())
