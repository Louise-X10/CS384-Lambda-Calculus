
(* The type of tokens. *)

type token = 
  | Var of (string)
  | Semicolon
  | RParen
  | Lambda
  | LParen
  | Equal
  | EOF
  | Dot

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.lc_expr)
