module Main exposing (..)

import Browser
import Element exposing (layout, padding, paddingXY, rgb255, row, spacing, text)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


type alias Model =
    { text : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { text = "" }, Cmd.none )



-- UPDATE


type Msg
    = UserTypedText String
    | UserClickButton
    | GotResponse (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserTypedText text ->
            ( { model | text = text }, Cmd.none )

        UserClickButton ->
            ( model
            , Http.post
                { url = "http://localhost:3000"
                , body = Http.emptyBody
                , expect = Http.expectString GotResponse
                }
            )

        GotResponse response ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    layout [ padding 10 ] <|
        row [ spacing 5 ]
            [ textbox model
            , button model
            ]


textbox model =
    Input.multiline
        [ Border.rounded 5
        ]
        { text = model.text
        , onChange = UserTypedText
        , placeholder = Just <| Input.placeholder [] <| text "Type your input"
        , label = Input.labelLeft [] <| text "Input"
        , spellcheck = False
        }


button model =
    Input.button
        [ Border.rounded 5
        , paddingXY 20 15
        , Background.color (rgb255 30 120 111)
        , Font.color (rgb255 255 255 255)
        ]
        { onPress = Just UserClickButton
        , label = text "Submit"
        }
