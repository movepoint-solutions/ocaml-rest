type rest =
        | Para of string
        | Markup of string

let parse s = Para s
