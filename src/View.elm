module View where

import Svg exposing (svg, image)
import Svg.Attributes exposing (id, width, height, overflow, xlinkHref, x, y, opacity)
import Html
import Html.Events
import Html.Attributes exposing (style)
import Html.Decoder

import Model exposing (Model, DropType(..), Drop, ScrollStatus(..), scrollPercentage)
import Model.StoryText
import Update exposing (Action(..))
import Util exposing (toPixel)


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
        topValueBasedOnScroll =
            toPixel (model.scrollLevel * -1)

        storySectionStyle =
            style [ ("top", topValueBasedOnScroll) ]

    in
        Html.div
            [ id "katie-story-story-section"
            , storySectionStyle
            ]
            [ Model.StoryText.presents
            , Model.StoryText.title
            , Model.StoryText.byLine
            , Model.StoryText.author
            , Model.StoryText.storyText
            ]


renderWomanSection : Model -> Html.Html
renderWomanSection model =
    let
        womanSectionStyle =
            style [ ( "height", toPixel model.storyHeight ) ]

        womanSections =
            (renderWomanImage model) :: (renderDrops model)

    in
        Html.div
            [ id "katie-story-woman-section"
            , womanSectionStyle
            ]
            [ svg
                [ width (toPixel model.boundX)
                , height (toPixel (model.storyHeight))
                , overflow "hidden"
                ]
                womanSections
            ]


renderWomanImage : Model -> Svg.Svg
renderWomanImage model =
    let
        nudgeOneQuarter =
            (model.boundX // 4)
    in
        image
            [ width (toPixel model.boundX)
            , height (toPixel (Model.womanHeight model))
            , xlinkHref (Model.womanAssetLocation)
            , x (toPixel nudgeOneQuarter)
            , y (toPixel (Model.womanDistanceFromTop model))
            , overflow "hidden"
            ]
            []


renderDrops : Model -> List Html.Html
renderDrops model =
    let
        {- center of woman is three quarters from the left -}
        womanXOrigin =
            model.boundX
                |> toFloat
                |> (*) 0.75
                |> floor

        halfOfWomanHeight =
            (Model.womanHeight model) // 2

        womanYOrigin =
            (Model.womanDistanceFromTop model) + halfOfWomanHeight
    in
        List.map (renderDrop model (womanXOrigin, womanYOrigin)) model.drops


renderDrop : Model -> (Int, Int) -> Drop -> Html.Html
renderDrop model (xOrigin, yOrigin) drop =
    let
        xOffset =
            (drop.x * (model.boundX // 4)) // 100

        yOffset =
            (drop.y * (Model.womanHeight model)) // 100

        xCoord =
            xOrigin + xOffset

        yCoord =
             yOrigin + yOffset

        startNudge =
            -0.1

        fadeSpeed =
            12

        fadeInValue =
            ((scrollPercentage model) - drop.sequence + startNudge) * fadeSpeed

        url =
            case drop.dropType of
                Big ->
                    "assets/pearl-big.png"
                Small ->
                    "assets/pearl-little.png"

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
        isPreventDefault =
            case model.scrollStatus of
                Scrolling ->
                    True
                Bottom ->
                    False
                Top ->
                    False

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
