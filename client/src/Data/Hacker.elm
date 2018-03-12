module Data.Hacker exposing (Hacker, decoder, encoder, manyDecoder, new, succeed)

import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Json.Encode as Encode



type alias Hacker =
    { id : Int
    , name : String
    }


new : Hacker
new =
    { id = -1
    , name = ""
    }


decoder : Decoder Hacker
decoder =
    decode Hacker
        |> required "id" int
        |> optional "name" string ""


manyDecoder : Decoder ( List Hacker )
manyDecoder =
    list decoder


encoder : Hacker -> Encode.Value
encoder hacker =
    Encode.object
        [ ( "id", Encode.int hacker.id )
        , ( "name", Encode.string hacker.name )
        ]

succeed : a -> Decoder a
succeed =
    Decode.succeed


