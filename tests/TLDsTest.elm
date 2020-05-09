module TLDsTest exposing (suite)

import Dict exposing (Dict)
import Expect exposing (Expectation)
import TLDs
import Test exposing (..)


suite : Test
suite =
    describe "Test the list of TLDs"
        [ test "Test a few valid TLDs" validTLDs
        , test "Test a few invalid TLDs" invalidTLDs
        ]


dict : Dict String ()
dict =
    TLDs.list
        |> List.map (\tld -> ( tld, () ))
        |> Dict.fromList


validTLDs : () -> Expectation
validTLDs _ =
    [ "com", "au", "co", "ch", "sydney", "nz" ]
        |> List.all (\tld -> Dict.member tld dict)
        |> Expect.equal True


invalidTLDs : () -> Expectation
invalidTLDs _ =
    [ "dsfgdfs", "what", "pokemon", ".co.nz", "co.uk" ]
        |> List.all (\tld -> Dict.member tld dict)
        |> Expect.equal False
