module Main exposing (..)

import Browser
import Element exposing (Element, fill, layout, minimum, padding, paddingXY, px, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import Json.Decode as D
import Json.Encode as E



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { input : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = "" }, Cmd.none )



-- TYPES


node : Int -> E.Value
node input =
    E.object [ ( "input", E.int input ) ]


output : D.Decoder Int
output =
    D.field "value" D.int



-- HELPERS


runNode : Int -> Cmd Msg
runNode input =
    Http.post
        { url = "http://localhost:3000"
        , body = Http.jsonBody (node input)
        , expect = Http.expectJson FinishNode output
        }



-- UPDATE


type Msg
    = RunNode
    | UpdateInput String
    | FinishNode (Result Http.Error Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput text ->
            ( { model | input = text }, Cmd.none )

        RunNode ->
            case String.toInt model.input of
                Nothing ->
                    ( model, Cmd.none )

                Just input ->
                    ( model, runNode input )

        FinishNode response ->
            case response of
                Ok value ->
                    ( { model | input = String.fromInt value }, Cmd.none )

                Err _ ->
                    ( { model | input = "Failed" }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    layout [ padding 10 ] <|
        row [ spacing 5 ]
            [ textbox model
            , button model
            ]


textbox : Model -> Element Msg
textbox model =
    Input.multiline
        [ Border.rounded 5
        , width (px 250)
        ]
        { text = model.input
        , onChange = UpdateInput
        , placeholder = Just <| Input.placeholder [] <| text "Type your input"
        , label = Input.labelLeft [] <| text "Input"
        , spellcheck = False
        }


button : Model -> Element Msg
button model =
    Input.button
        [ Border.rounded 5
        , paddingXY 20 15
        , Background.color (rgb255 30 120 111)
        , Font.color (rgb255 255 255 255)
        ]
        { onPress = Just RunNode
        , label = text "Submit"
        }
