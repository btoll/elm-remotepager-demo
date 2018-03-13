module Request.Hacker exposing (delete, list, page, post, put)

import Http
import Data.Hacker exposing (Hacker, HackerWithPager, decoder, encoder, manyDecoder, pagingDecoder, succeed)



baseUrl : String
baseUrl =
    "http://127.0.0.1:8080/elm-remotepager-demo/hacker/"


delete : Hacker -> Http.Request Hacker
delete hacker =
    Http.request
        { method = "DELETE"
        , headers = []
        , url =  hacker.id |> toString |> (++) baseUrl
        , body = Http.emptyBody
        , expect = Http.expectJson ( succeed hacker )
        , timeout = Nothing
        , withCredentials = False
        }


get : String -> Http.Request ( List Hacker )
get method =
    manyDecoder
        |> Http.get ( (++) baseUrl method )


list : Http.Request ( List Hacker )
list =
    "list" |> get


page : Int -> Http.Request HackerWithPager
page page =
    pagingDecoder |> Http.get ( baseUrl ++ "list/" ++ ( page |> toString ) )


post : Hacker -> Http.Request Hacker
post hacker =
    let
        body : Http.Body
        body =
            encoder hacker
                |> Http.jsonBody
    in
        decoder
            |> Http.post baseUrl body


put : Hacker -> Http.Request Hacker
put hacker =
    let
        body : Http.Body
        body =
            encoder hacker
                |> Http.jsonBody
    in
        Http.request
            { method = "PUT"
            , headers = []
            , url =  hacker.id |> toString |> (++) baseUrl
            , body = body
            , expect = Http.expectJson ( hacker |> succeed )
            , timeout = Nothing
            , withCredentials = False
            }


