let parse (src : string) : Ast.lc_expr =
  let lexbuf = Lexing.from_string src in
  Parser.start Lexer.tok lexbuf