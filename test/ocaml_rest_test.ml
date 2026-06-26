open OUnit2
open Ocaml_rest

let () =
        assert_equal (Para [Text "Hello"]) (parse "Hello");
        assert_equal (Para [Em "Hello"]) (parse "*Hello*")
