type markup =
        | Text of string
        | Em of string
        | Strong of string
        | Interp of string
        | Inline of string

type rest =
        | Para of markup list

open Angstrom

let text (p : string t) = p |> map ~f:(fun cnt -> Text cnt) 
let em (p : string t) = char '*' *> p <* char '*' |> map ~f:(fun cnt -> Em cnt)
let strong (p : string t) = string "**" *> p <* string "**" |> map ~f:(fun cnt -> Strong cnt)
let interp (p : string t) = char '`' *> p <* char '`' |> map ~f:(fun cnt -> Interp cnt)
let inline (p : string t) = string "``" *> p <* string "``" |> map ~f:(fun cnt -> Inline cnt)
let para (p : markup list t) = lift (fun cnt -> Para cnt) p <?> "para"
let nonspaces : string t = take_while (function | ' ' | '\t' -> false | _ -> true) <?> "nonspaces"
let nonspace : char t = satisfy (function | ' ' | '\t' -> false | _ -> true) <?> "nonspace"
let plain_nonspace : char t = satisfy (function | '_' | '*' | '`' | ' ' | '\t' -> false | _ -> true) <?> "nonspace"
(*let spaces : string t = take_while1 (function | ' ' | '\t' -> true | _ -> false)*)
(*let any_string : string t = lift (fun l -> String.of_seq (List.to_seq l)) (many any_char)*)
let plain_string : string t = take_while1 (function | '_' | '*' -> false | _ -> true) <?> "plain_string"
(*let markupable : string t = lift2 (fun n1 a -> (String.make 1 n1) ^ a) plain_nonspace (option "" (lift (fun (s, c) -> s ^ (String.make 1 c)) (both plain_string plain_nonspace))) <?> "markupable"*)
let markupable = many1 plain_nonspace |> lift (fun l -> String.of_seq (List.to_seq l)) <?> "markupable"
let contents = many (text markupable <|> em markupable <|> strong markupable
                  <|>interp markupable <|> inline markupable)
let parse (str:string) : rest =
  match parse_string ~consume:All (para contents) str with
  | Ok v      -> v
  | Error msg -> failwith msg
