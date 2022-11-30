module Main exposing (..)

import Browser
import Element exposing (layout, padding, text)
import Element.Border as Border
import Element.Input as Input
import Html exposing (Html)



-- INIT


type alias Model =
    { text : String }


init : Model
init =
    { text = "" }


type Msg
    = UserTypedText String



-- VIEW


view : Model -> Html Msg
view model =
    layout [ padding 10 ] <|
        Input.multiline
            [ Border.rounded 5
            ]
            { onChange = UserTypedText
            , text = model.text
            , placeholder = Just <| Input.placeholder [] <| text "Type your message"
            , label = Input.labelAbove [] <| text "Message"
            , spellcheck = False
            }



-- UPDATE


update : Msg -> Model -> Model
update (UserTypedText text) model =
    { model | text = text }



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
