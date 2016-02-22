import StartApp
import Effects
import Task

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
            , scrollParentAddress = scrollParentMailbox.address
            }
    in
        StartApp.start
            { init = (model, Effects.none)
            , update = update addresses
            , view = view
            , inputs = [ viewport, updateStoryHeight, updateTop ]
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

scrollParentMailbox : Signal.Mailbox Float
scrollParentMailbox = Signal.mailbox 0.0

port scrollParent : Signal Float
port scrollParent =
    scrollParentMailbox.signal

port sendTop : Signal Int

requestTopMailbox : Signal.Mailbox ()
requestTopMailbox = Signal.mailbox ()

port requestTop : Signal ()
port requestTop =
    requestTopMailbox.signal


viewport : Signal Action
viewport =
    Signal.map Viewport (Primer.prime Window.dimensions)
