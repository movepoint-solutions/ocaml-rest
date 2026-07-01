open OUnit2
open Ocaml_rest

let printer r =
    match r with
    Para ml ->
        let aux m = match m with
        | Text s -> "Text " ^ s ^ "\n"
        | Em s -> "Em " ^ s ^ "\n"
        | Strong s -> "Strong " ^ s ^ "\n"
        | Interp s -> "Interp " ^ s ^ "\n"
        | Inline s -> "Inline " ^ s ^ "\n"
        in
        List.fold_left (^) "" (List.map aux ml)

let () =
        assert_equal ~printer (Para [Text "Hello"]) (parse "Hello");
        assert_equal ~printer (Para [Em "Hello"]) (parse "*Hello*");
        assert_equal ~printer (Para [Strong "Hello"]) (parse "**Hello**");
        assert_equal ~printer (Para [Text "Hello"; Interp "the"; Inline "World"]) (parse "Hello`the```World``")
