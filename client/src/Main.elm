module Main exposing (..)

import Data.Hacker exposing (Hacker, HackerWithPager, new)
import Data.Pager exposing (Pager)
import Html exposing (Html, button, div, h1, li, section, span, text, ul)
import Http
import Request.Hacker
import Views.Form as Form
import Views.Pager



-- MODEL

type alias Model =
    { hackers : List Hacker
    , pager : Pager
    }



-- UPDATE

type Msg
    = FetchedHackers ( Result Http.Error HackerWithPager )
    | PagerMsg Views.Pager.Msg
    | Post
    | Put



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchedHackers ( Ok hackerWithPager ) ->
            { model |
                hackers = hackerWithPager.hackers
                , pager = hackerWithPager.pager
            } ! []

        FetchedHackers ( Err err ) ->
            { model |
                hackers = []
            } ! []

        PagerMsg subMsg ->
            model !
            [ subMsg
                |> Views.Pager.update ( model.pager.currentPage, model.pager.totalPages )
                |> Request.Hacker.page
                |> Http.send FetchedHackers
            ]
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
    let
        pager : Pager
        pager =
            model.pager

        showPager : Html Msg
        showPager =
            if 1 |> (>) pager.totalPages then
                pager.currentPage |> Views.Pager.view pager.totalPages |> Html.map PagerMsg
            else
                div [] []
    in
    [ button [] [ "Add Hacker" |> text ]
    , showPager
    , model.hackers
        |> List.map
            ( \hacker ->
                li []
                    [ span [] [ hacker.id |> toString |> text ]
                    , span [] [ hacker.name |> text ]
                    , button [] [ "Edit" |> text ]
                    , button [] [ "Delete" |> text ]
                    ]
            )
        |> ul []
    ]



init : ( Model, Cmd Msg )
init =
    { hackers = []
    , pager = Data.Pager.new
    } ! [ 0 |> Request.Hacker.page |> Http.send FetchedHackers ]



main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


