type markup =
        | Text of string
        | Em of string
        | Strong of string
        | Interp of string

type rest =
        | Para of markup list

open Angstrom

let text (p : string t) = lift (fun cnt -> Text cnt) p
let em (p : string t) = char '*' *> lift (fun cnt -> Em cnt) p <* char '*'
let para (p : markup list t) = lift (fun cnt -> Para cnt) p
let nonspaces : string t = take_while1 (function | ' ' | '\t' -> false | _ -> true)
let spaces : string t = take_while1 (function | ' ' | '\t' -> true | _ -> false)
(*let any_string : string t = lift (fun l -> String.of_seq (List.to_seq l)) (many any_char)*)
let plain_string : string t = take_while1 (function | '_' | '*' -> false | _ -> true)
(*let markupable : string t = lift3 (fun n1 a n2 -> n1 ^ a ^ n2) nonspaces plain_string nonspaces*)
let markupable = plain_string
let contents = many (text plain_string <|> em markupable)
let parse (str:string) : rest =
  match parse_string ~consume:All (para contents) str with
  | Ok v      -> v
  | Error msg -> failwith msg
