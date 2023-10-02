{

open Parser

let sb = Buffer.create 256

exception SyntaxError of string

}

let id = ['_' 'a'-'z' 'A'-'Z'] ['_' 'a'-'z' 'A'-'Z' '0'-'9']*
let whitespace = [' ' '\t' '\r' '\n']+
let int = ['0'-'9']+

rule tok = parse
| whitespace { tok lexbuf }
| '&'        { Lambda }
| '.'        { Dot }
| '('        { LParen }
| ')'        { RParen }
| ';'        { Semicolon }
| '='        { Equal }
| id as s    { Var s }
| eof        { EOF }
| _          { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }

{
let tok_to_str : token -> string = function
  | Lambda -> "&"
  | Dot -> "."
  | Var i -> i
  | LParen -> "("
  | RParen -> ")"
  | Equal -> "="
  | Semicolon -> ";"
  | EOF -> ""

let tokenize input_string =
  let lexbuf = Lexing.from_string input_string in
  let rec collect_tokens tokens =
    match tok lexbuf with
    | Parser.EOF -> List.rev (tokens) (* Don't add EOF token *)
    | token -> collect_tokens (token :: tokens)
  in
   collect_tokens []
}