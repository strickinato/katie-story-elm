module View where

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import Html.Events
import Html.Attributes
import Html.Decoder

import Model exposing (Model, Drop, scrollPercentage)
import Model.StoryText
import Update exposing (Action(..))


scaledWomanHeight : Model -> Int
scaledWomanHeight model =
    ceiling ((toFloat model.boundY) * model.womanScale)


womanScroll : Model -> Int
womanScroll model =
    model.scrollLevel * -1


view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        [ scrollCapture address
        , Html.Attributes.style [ ("position", "relative") ]
        ]
        [ renderWoman model
        , renderStory model
        ]

renderStory : Model -> Html.Html
renderStory model =
    let
        top =
            toPixel (model.scrollLevel * -2)

        style =
            Html.Attributes.style
                [ ("position", "absolute")
                , ("width", "50%")
                , ("top", top)
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


renderWoman : Model -> Html.Html
renderWoman model =
    let
        style =
            Html.Attributes.style
                [ ("position", "absolute") ]
    in
        Html.div
            [ id "woman", style ]
            [ svg
                [ width (toPixel model.boundX)
                , height (toPixel (scaledWomanHeight model))
                ]
                ((renderBackgroundWoman model) :: (renderDrops model))
            ]

renderBackgroundWoman : Model -> Svg.Svg
renderBackgroundWoman model =
    image
        [ width (toPixel model.boundX)
        , height (toPixel (scaledWomanHeight model))
        , xlinkHref "src/assets/woman.png"
        , x (toPixel (model.boundX // 4))
        , y (toString (womanScroll model))
        ]
        []

renderDrops : Model -> List Html.Html
renderDrops model =
    List.map (renderDrop model) model.drops


renderDrop : Model -> Drop -> Html.Html
renderDrop model drop =
    let
        xCoord =
            floor (((toFloat model.boundX) * 3) / 4 ) + drop.x

        yCoord =
            ((scaledWomanHeight model) // 2) + (womanScroll model) + drop.y

        fadeInValue =
            bindValueToPercent ((scrollPercentage model) - drop.sequence) * 2
    in
        image
            [ width (toPixel 20)
            , height (toPixel 20)
            , opacity (toString fadeInValue)
            , xlinkHref ("src/assets/pearl-" ++ drop.src)
            , x (toPixel xCoord)
            , y (toPixel yCoord)
            ]
            []

scrollCapture : Signal.Address Action -> Html.Attribute
scrollCapture address =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        Html.Events.onWithOptions
            "wheel"
            options
            Html.Decoder.wheelEvent
            (\event -> Signal.message address (Scroll event.deltaY) )


bindValueToPercent : Float-> Float
bindValueToPercent value =
    if value > 1 then
        1
    else if value <= 0 then
        0
    else
        value

