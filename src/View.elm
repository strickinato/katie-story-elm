module View where

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import Html.Events
import Html.Decoder
import Random

import Model exposing (Model)
import Update exposing (Action(..))

view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        [ scrollCapture address ]
        [  text <| toString model.scrollLevel
        , svg
            (boundingDimensions model)
            (List.concat [ [ renderBackdrop model ], renderCircles model ])
        ]

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
    let
        funct n =
            circle [ cx (toString n), cy (toString n), r "50", width "50", height "50", fill "white" ] []
    in
        Random.map circleGenerator2 (Random.int 0 500)


circleGenerator2 : Int -> Svg
circleGenerator2 num =
    let
        seed0 = Random.initialSeed num

        (cxValue, seed1) =
            Random.generate (Random.int 0 800) seed0

        (cyValue, seed2) =
            Random.generate (Random.int 0 600) seed1

        _ = Debug.log "cx" cxValue
        _ = Debug.log "cy" cyValue
    in
        circle [ cx (toString cxValue), cy (toString cyValue), r "10", width "10", height "10", fill "white" ] []


renderBackdrop : Model -> Svg
renderBackdrop model =
    rect  ( [fill model.color]
            |> List.append origin
            |> List.append (boundingDimensions model)
          ) []


origin : List Svg.Attribute
origin =
    [x "0", y "0"]


boundingDimensions : Model -> List Svg.Attribute
boundingDimensions model =
    [ width (toString 800), height (toString 600) ]


maskDefinition : Model -> Svg
maskDefinition model =
    defs
        []
        [ Svg.mask
          [ id "mask", width "100", height "100" ]
          [ circle [ cx (toString model.x), cy (toString model.y), r "100", width "100", height "100", fill "white"] []
          ]
        ]


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