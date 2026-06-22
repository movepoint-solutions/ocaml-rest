open OUnit2
open Ocaml_rest

let () =
        assert_equal (parse "Hello") (Para [Text "Hello"])
