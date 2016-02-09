import StartApp
import Effects

import Mouse
import Window
import Primer

import Html

import View exposing (view)
import Update exposing (update, Action(..))
import Model exposing (Model, model)

app : StartApp.App Model
app =
    StartApp.start
        { init = (model, Effects.none)
        , update = update
        , view = view
        , inputs = [ mouseInput, viewport ]
        }


main : Signal Html.Html
main =
    app.html


mouseInput : Signal Action
mouseInput =
    Signal.map MouseScroll (Primer.prime Mouse.position)


viewport : Signal Action
viewport =
    Signal.map Viewport (Primer.prime Window.dimensions)
