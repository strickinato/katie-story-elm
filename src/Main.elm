import StartApp
import Effects
import Task

import Mouse
import Window
import Primer

import Html

import View exposing (view)
import Update exposing (update, Action(..))
import Model exposing (Model, model)

app : StartApp.App Model
app =
    let
        updateStoryHeight =
            Signal.map (\ num -> SetStoryHeight num) sendStoryHeight

        updateTop =
            Signal.map (\ num -> SetTop num) sendTop

        addresses =
            { storyHeightAddress = requestStoryHeightMailbox.address
            , topAddress = requestTopMailbox.address
            }
    in
        StartApp.start
            { init = (model, Effects.none)
            , update = update addresses
            , view = view
            , inputs = [ mouseInput, viewport, updateStoryHeight, updateTop ]
            }



main : Signal Html.Html
main =
    app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks =
  app.tasks


port sendStoryHeight : Signal Int

requestStoryHeightMailbox : Signal.Mailbox ()
requestStoryHeightMailbox = Signal.mailbox ()

port requestStoryHeight : Signal ()
port requestStoryHeight =
    requestStoryHeightMailbox.signal

port sendTop : Signal Int

requestTopMailbox : Signal.Mailbox ()
requestTopMailbox = Signal.mailbox ()

port requestTop : Signal ()
port requestTop =
    requestTopMailbox.signal


mouseInput : Signal Action
mouseInput =
    Signal.map MouseScroll (Primer.prime Mouse.position)


viewport : Signal Action
viewport =
    Signal.map Viewport (Primer.prime Window.dimensions)
