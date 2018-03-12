module Data.Hacker exposing (Hacker, HackerWithPager, decoder, encoder, manyDecoder, new, pagingDecoder, succeed)

import Data.Pager
import Json.Decode as Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Json.Encode as Encode



type alias Hacker =
    { id : Int
    , name : String
    }


type alias HackerWithPager =
    { hackers : List Hacker
    , pager : Data.Pager.Pager
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


pagingDecoder : Decoder HackerWithPager
pagingDecoder =
    decode HackerWithPager
        |> required "hackers" manyDecoder
        |> required "pager" Data.Pager.decoder


succeed : a -> Decoder a
succeed =
    Decode.succeed


