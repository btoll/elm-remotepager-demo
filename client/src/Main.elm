module Main exposing (..)

import Data.Hacker exposing (Hacker, new)
import Html exposing (Html, h1, li, section, span, text, ul)
import Http
import Request.Hacker
import Views.Form as Form



-- MODEL

type alias Model =
    { hackers : List Hacker
    }



-- UPDATE

type Msg
    = FetchedHackers ( Result Http.Error ( List Hacker ) )
    | Post
    | Put



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchedHackers ( Ok hackers ) ->
            { model |
                hackers = hackers
            } ! []

        FetchedHackers ( Err err ) ->
            { model |
                hackers = []
            } ! []

        Post ->
            model ! []

        Put ->
            model ! []



-- VIEW

view : Model -> Html Msg
view model =
    section []
        ( model
            |> drawView
            |> (::) ( h1 [] [ text "Hackers" ] )
        )


drawView : Model -> List ( Html Msg )
drawView model =
    [ model.hackers
        |> List.map
            ( \hacker ->
                li []
                    [ span [] [ hacker.id |> toString |> text ]
                    , span [] [ hacker.name |> text ]
                    ]
            )
        |> ul []
    ]



init : ( Model, Cmd Msg )
init =
    { hackers = []
    } ! [ Request.Hacker.list |> Http.send FetchedHackers ]



main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


