module Request.Hacker exposing (delete, list, post, put)

import Http
import Data.Hacker exposing (Hacker, decoder, encoder, manyDecoder, succeed)



delete : Hacker -> Http.Request Hacker
delete hacker =
    Http.request
        { method = "DELETE"
        , headers = []
        , url =  hacker.id |> toString |> (++) "http://127.0.0.1:8080/elm-remotepager-demo/hacker/"
        , body = Http.emptyBody
        , expect = Http.expectJson ( succeed hacker )
        , timeout = Nothing
        , withCredentials = False
        }


get : String -> Http.Request ( List Hacker )
get method =
    manyDecoder
        |> Http.get ( (++) "http://127.0.0.1:8080/elm-remotepager-demo/hacker/" method )


list : Http.Request ( List Hacker )
list =
    "list" |> get


post : String -> Hacker -> Http.Request Hacker
post url hacker =
    let
        body : Http.Body
        body =
            encoder hacker
                |> Http.jsonBody
    in
        decoder
            |> Http.post "http://127.0.0.1:8080/elm-remotepager-demo/hacker/" body


put : String -> Hacker -> Http.Request Int
put url hacker =
    let
        body : Http.Body
        body =
            encoder hacker
                |> Http.jsonBody
    in
        Http.request
            { method = "PUT"
            , headers = []
            , url =  hacker.id |> toString |> (++) "http://127.0.0.1:8080/elm-remotepager-demo/hacker/"
            , body = body
            , expect = Http.expectJson ( hacker.id |> succeed )
            , timeout = Nothing
            , withCredentials = False
            }


