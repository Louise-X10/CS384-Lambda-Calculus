open Lexer
open Ast

exception ParseError of string

let parse_term : token list -> lc_expr * token list =
  fun _ -> failwith "undefined"

let parse (src : string) : lc_expr =
  let (ex, rest) = parse_term (tokenize src) in
  match rest with
  | [] -> ex
  | t :: _ -> raise (ParseError ("Expected end of file, got: " ^ tok_to_str t))
