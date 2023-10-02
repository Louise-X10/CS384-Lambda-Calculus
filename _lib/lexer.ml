exception LexError of string

type token =
  | Lambda
  | Dot
  | Var of string
  | LParen
  | RParen
  | Equal
  | Semicolon

let tok_to_str : token -> string = function
  | Lambda -> "&"
  | Dot -> "."
  | Var i -> i
  | LParen -> "("
  | RParen -> ")"
  | Equal -> "="
  | Semicolon -> ";"

let is_digit (c : char) : bool = '0' <= c && c <= '9'

let is_id_char (c : char) : bool =
  c = '_' || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || is_digit c

let consume_id (i : int) (src : string) : int * token =
  let rec loop j acc =
    if j >= String.length src || not (is_id_char src.[j])
    then (j, Var acc)
    else loop (j + 1) (acc ^ String.make 1 src.[j]) in
  let (j, ret) = loop i "" in
  if j = i
  then raise (LexError "Tried to parse empty identifier")
  else (j, ret)

let tokenize (src : string) : token list =
  let rec loop i acc =
    if i >= String.length src
    then List.rev acc
    else match src.[i] with
      | '&' -> loop (i + 1) (Lambda :: acc)
      | '.' -> loop (i + 1) (Dot :: acc)
      | '(' -> loop (i + 1) (LParen :: acc)
      | ')' -> loop (i + 1) (RParen :: acc)
      | '=' -> loop (i + 1) (Equal :: acc)
      | ';' -> loop (i + 1) (Semicolon :: acc)
      | c when c = '_' || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') ->
        let (ni, tok) = consume_id i src in
        loop ni (tok :: acc)
      | c when String.contains "\n\r\t " c -> loop (i + 1) acc
      | c -> raise (LexError ("Unexpected character: " ^ String.make 1 c))
  in
  loop 0 []
