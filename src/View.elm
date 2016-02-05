module View where

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html
import Html.Attributes
import Json.Encode

import Model exposing (Model)
import Update exposing (Action(..))

view : Signal.Address Action -> Model -> Html.Html
view address model =
    let
        mask =
            Svg.Attributes.mask "url(#mask)"

    in
      Html.div
          []
          [ svg
                (boundingDimensions model)
                [ maskDefinition model
                , renderBackdrop model
                , image [ xlinkHref "src/assets/room.jpg", width (toString model.boundX), height (toString model.boundY), mask] []
                , renderLogo
                ]
          ]

renderBackdrop : Model -> Svg
renderBackdrop model =
    rect  ( [fill "black"]
            |> List.append origin
            |> List.append (boundingDimensions model)
          ) []


origin : List Svg.Attribute
origin =
    [x "0", y "0"]

renderLogo : Svg
renderLogo =
    text'
      [ x "50"
      , y "50"
      , fill "red"
      , fontFamily "Courier"
      , fontSize "35px"
      ]
      [text "AaronStrick.com"]


boundingDimensions : Model -> List Svg.Attribute
boundingDimensions model =
    [ width (toString model.boundX), height (toString model.boundY) ]


maskDefinition : Model -> Svg
maskDefinition model =
    defs
        []
        [ Svg.mask
          [ id "mask", width "100", height "100" ]
          [ circle [ cx (toString model.x), cy (toString model.y), r "100", width "100", height "100", fill "white"] []
          ]
        ]
