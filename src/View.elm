module View where

import Svg exposing (svg, image)
import Svg.Attributes exposing (id, width, height, overflow, xlinkHref, x, y, opacity)
import Html
import Html.Events
import Html.Attributes
import Html.Decoder

import Model exposing (Model, DropType(..), Drop, ScrollStatus(..), womanHeight, scrollPercentage)
import Model.StoryText
import Update exposing (Action(..))



view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        [ id "katie-story-container"
        , scrollCaptureHandler address model
        ]
        [ renderWomanSection model
        , renderStorySection model
        ]


renderStorySection : Model -> Html.Html
renderStorySection model =
    let
        top =
            toPixel (round ((toFloat model.scrollLevel) * -1))

        style =
            Html.Attributes.style
                [ ("position", "absolute")
                , ("width", "50%")
                , ("top", top)
                , ("overflow", "hidden")
                ]
    in
        Html.div
            [ id "story", style ]
            [ Model.StoryText.presents
            , Model.StoryText.title
            , Model.StoryText.byLine
            , Model.StoryText.author
            , Model.StoryText.storyText
            ]


toPixel : Int -> String
toPixel distance =
    (toString (distance) ++ "px")


renderWomanSection : Model -> Html.Html
renderWomanSection model =
    let
        style =
            Html.Attributes.style
                [ ("position", "absolute")
                , ("overflow", "hidden")
                , ("height", toPixel (model.storyHeight) )
                ]
    in
        Html.div
            [ id "woman", style ]
            [ svg
                [ width (toPixel model.boundX)
                , height (toPixel (model.storyHeight))
                , overflow "hidden"
                ]
                ((renderWomanImage model) :: (renderDrops model))
            ]

renderWomanImage : Model -> Svg.Svg
renderWomanImage model =
    image
        [ width (toPixel model.boundX)
        , height (toPixel (Model.womanHeight model))
        , xlinkHref "src/assets/woman.gif"
        , x (toPixel (model.boundX // 4))
        , y (toString (Model.womanScroll model))
        , overflow "hidden"
        ]
        []

renderDrops : Model -> List Html.Html
renderDrops model =
    let
        womanXOrigin =
            floor (((toFloat model.boundX) * 3) / 4 )

        womanYOrigin =
            (Model.womanScroll model) + ((womanHeight model) // 2)
    in
        List.map (renderDrop model (womanXOrigin, womanYOrigin)) model.drops


renderDrop : Model -> (Int, Int) -> Drop -> Html.Html
renderDrop model (xOrigin, yOrigin) drop =
    let
        xOffset =
            (drop.x * (model.boundX // 4)) // 100

        yOffset =
            (drop.y * (womanHeight model)) // 100

        xCoord =
            xOrigin + xOffset

        yCoord =
             yOrigin + yOffset

        fadeInValue =
            ((scrollPercentage model) - drop.sequence - 0.2) * 10

        url =
            case drop.dropType of
                Big ->
                    "src/assets/pearl-big.png"
                Small ->
                    "src/assets/pearl-little.png"

    in
        image
            [ width (toPixel 21)
            , height (toPixel 20)
            , opacity (toString fadeInValue)
            , xlinkHref url
            , x (toPixel xCoord)
            , y (toPixel yCoord)
            ]
            []

scrollCaptureHandler : Signal.Address Action -> Model -> Html.Attribute
scrollCaptureHandler address model =
    let
        (isPreventDefault, action) =
            case model.scrollStatus of
                Scrolling ->
                    (True, (\event -> Signal.message address (Scroll event.deltaY) ) )
                Bottom ->
                    (False, \_ -> Signal.message address NoOp)
                Top ->
                    (False, \_ -> Signal.message address NoOp)

        options =
            { stopPropagation = False
            , preventDefault = isPreventDefault
            }

    in
        Html.Events.onWithOptions
            "wheel"
            options
            Html.Decoder.wheelEvent
            (\event -> Signal.message address (Scroll event.deltaY) )
