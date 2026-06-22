type markup =
        | Text of string
        | Em of string
        | Strong of string
        | Interp of string

type rest =
        | Para of markup list

let parse s = Para [Text s]
