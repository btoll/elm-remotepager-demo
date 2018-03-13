module Main exposing (..)

import Data.Hacker exposing (Hacker, HackerWithPager, new)
import Data.Pager exposing (Pager)
import Html exposing (Html, button, div, form, h1, li, section, span, text, ul)
import Html.Attributes exposing (autofocus, disabled, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Request.Hacker
import Views.Form as Form
import Views.Pager



-- MODEL

type alias Model =
    { action : Action
    , editing : Maybe Hacker
    , hackers : List Hacker
    , pagerState : Pager
    }


type Action = None | Adding | Editing



init : ( Model, Cmd Msg )
init =
    { action = None
    , editing = Nothing
    , hackers = []
    , pagerState = Data.Pager.new
    } ! [ 0 |> Request.Hacker.page |> Http.send FetchedHackers ]



-- UPDATE

type Msg
    = Add
    | Cancel
    | Delete Hacker
    | Deleted ( Result Http.Error Hacker )
    | Edit Hacker
    | FetchedHackers ( Result Http.Error HackerWithPager )
    | NewPage ( Maybe Int )
    | Post
    | Posted ( Result Http.Error Hacker )
    | Put
    | Putted ( Result Http.Error Hacker )
    | SetFormValue ( String -> Hacker ) String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            { model |
                action = Adding
            } ! []

        Cancel ->
            { model |
                action = None
                , editing = Nothing
            } ! []

        Delete hacker ->
            model ! [ hacker |> Request.Hacker.delete |> Http.send Deleted ]

        Deleted ( Ok hacker ) ->
            { model |
                hackers =
                    model.hackers |> List.filter ( \m -> hacker.id |> (/=) m.id )
            } ! []

        Deleted ( Err err ) ->
            model ! []

        Edit hacker ->
            { model |
                action = Editing
                , editing = hacker |> Just
            } ! []

        FetchedHackers ( Ok hackerWithPager ) ->
            { model |
                hackers = hackerWithPager.hackers
                , pagerState = hackerWithPager.pager
            } ! []

        FetchedHackers ( Err err ) ->
            { model |
                hackers = []
            } ! []

        NewPage page ->
            model !
            [ page
                |> Maybe.withDefault -1
                |> Request.Hacker.page
                |> Http.send FetchedHackers
            ]

        Post ->
            let
                cmd =
                    case model.editing of
                        Nothing ->
                            Cmd.none

                        Just hacker ->
                            Request.Hacker.post hacker
                                |> Http.send Posted
            in
            model ! [ cmd ]

        Posted ( Ok hacker ) ->
            { model |
                action = None
                , editing = Nothing
                , hackers =
                    model.hackers |> (::) hacker
            } ! []

        Posted ( Err err ) ->
            { model |
                action = None
                , editing = Nothing
            } ! []

        Put ->
            let
                cmd =
                    case model.editing of
                        Nothing ->
                            Cmd.none

                        Just hacker ->
                            Request.Hacker.put hacker
                                |> Http.send Putted
            in
            model ! [ cmd ]

        Putted ( Ok hacker ) ->
            { model |
                action = None
                , editing = Nothing
                , hackers =
                    model.hackers |> List.filter ( \m -> hacker.id |> (/=) m.id ) |> (::) hacker
            } ! []

        Putted ( Err err ) ->
            { model |
                action = None
                , editing = Nothing
            } ! []

        SetFormValue setFormValue s ->
            { model |
                editing = Just ( setFormValue s )
            } ! []



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
        editable =
            case model.editing of
                Nothing ->
                    new

                Just hacker ->
                    hacker
    in
    case model.action of
        None ->
            [ button [ Add |> onClick ] [ "Add Hacker" |> text ]
            , model.pagerState |> Views.Pager.view NewPage               -- NewPage same as ( \page -> page |> NewPage )
            , model.hackers
                |> List.map
                    ( \hacker ->
                        li []
                            [ span [] [ hacker.id |> toString |> text ]
                            , span [] [ hacker.name |> text ]
                            , button [ hacker |> Edit |> onClick ] [ "Edit" |> text ]
                            , button [ hacker |> Delete |> onClick ] [ "Delete" |> text ]
                            ]
                    )
                |> ul []
            ]

        Adding ->
            [ form [ onSubmit Post ]
                [ Form.text "Name"
                    [ value editable.name
                    , onInput ( SetFormValue ( \v -> { editable | name = v } ) )
                    , autofocus True
                    ]
                    []
                , Form.submit False Cancel
                ]
            ]

        Editing ->
            [ form [ onSubmit Put ]
                [ Form.text "ID"
                    [ editable.id |> toString |> value
                    , disabled True
                    ]
                    []
                , Form.text "Name"
                    [ value editable.name
                    , onInput ( SetFormValue ( \v -> { editable | name = v } ) )
                    , autofocus True
                    ]
                    []
                , Form.submit False Cancel
                ]
            ]



main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


