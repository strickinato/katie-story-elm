module Update where

import Effects exposing (Effects)
import Task
import Signal

import Model exposing (Model, storyScrollTopToBottom, ScrollStatus(..))


type Action
    = Viewport (Int, Int)
    | SetStoryHeight Int
    | Scroll Float
    | SetTop Int
    | NoOp


type alias Addresses =
    { storyHeightAddress : Signal.Address () }


update : Addresses -> Action -> Model -> (Model, Effects Action)
update addresses action model =
    case action of
        Viewport (x, y) ->
            ({ model | boundX = x, boundY = y }, Effects.task (pingAddress addresses.storyHeightAddress))

        Scroll level ->
            let
                scrollUpdate =
                    model.scrollLevel + (floor level)

                (newScrollLevel, newScrollStatus) =
                    if scrollUpdate <= 0 then
                        (0, Top)
                    else if scrollUpdate > (storyScrollTopToBottom model) then
                        (storyScrollTopToBottom model, Bottom)
                    else
                        (scrollUpdate, Scrolling)

                newModel =
                    { model | scrollLevel = newScrollLevel, scrollStatus = newScrollStatus}
            in
                (newModel, Effects.none)

        SetStoryHeight height ->
            ({ model | storyHeight = height }, Effects.none)

        SetTop newTop ->
            ({ model | top = newTop }, Effects.none)

        NoOp ->
            (model, Effects.none)


pingAddress : Signal.Address () -> Task.Task Effects.Never Action
pingAddress address =
    Task.map (\_ -> NoOp) (Signal.send address ())


isPositive : Float -> Bool
isPositive num =
    if num > 0.0 then
        True
    else
        False
