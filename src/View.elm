module View where

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import Html.Events
import Html.Attributes
import Html.Decoder
import Random

import Model exposing (Model)
import Model.StoryText
import Update exposing (Action(..))


heightScale : Int
heightScale =
    1000


view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        [ scrollCapture address, relativePosition ]
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
                [ ("position", "absolute")
                , ("background", "red")
                ]

        pullRight =
            model.boundX // 4

    in
        Html.div
            [ id "woman", style ]
            [ svg
                [ width (toPixel model.boundX)
                , height (toPixel (model.boundY * 2))
                ]
                [ image
                      [ width (toPixel model.boundX)
                      , height (toPixel (model.boundY * 2))
                      , xlinkHref "src/assets/woman.png"
                      , x (toPixel (pullRight))
                      , y (toString (model.scrollLevel * -1))
                      ]
                      []
                ]
            ]


  -- , svg
  --     (boundingDimensions model)
  --     (List.concat
  --       [ renderCircles model
  --       , [ renderSquareFast model ]
  --       , [ renderSquareSlow model ]
  --       ])

renderSquareFast : Model -> Svg
renderSquareFast model =
    rect [ x (toString 0), y (toString model.scrollLevel), width "50", height "50", fill "red" ] []

renderSquareSlow : Model -> Svg
renderSquareSlow model =
    rect [ x (toString 50), y (toString (floor ((toFloat model.scrollLevel) / 2))), width "50", height "50", fill "green" ] []

renderCircles : Model -> List Svg
renderCircles model =
    let
        numCircles =
            floor ((toFloat model.scrollLevel) / 10)

        initialSeed =
            Random.initialSeed 10

        circleGeneratorList =
            Random.list numCircles circleGenerator

    in
        fst <| Random.generate circleGeneratorList initialSeed


circleGenerator : Random.Generator Svg
circleGenerator =
    Random.map circleGeneratorRandomizer (Random.int 0 500)


circleGeneratorRandomizer : Int -> Svg
circleGeneratorRandomizer num =
    let
        seed0 = Random.initialSeed num

        (cxValue, seed1) =
            Random.generate (Random.int 0 800) seed0

        (cyValue, seed2) =
            Random.generate (Random.int 0 600) seed1

    in
        circle [ cx (toString cxValue), cy (toString cyValue), r "10", width "10", height "10", fill "white" ] []


boundingDimensions : Model -> List Svg.Attribute
boundingDimensions model =
    [ width (toString (model.boundX - 1)), height (toString (model.boundY - 10)) ]


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

relativePosition : Html.Attribute
relativePosition =
    Html.Attributes.style [ ("position", "relative") ]