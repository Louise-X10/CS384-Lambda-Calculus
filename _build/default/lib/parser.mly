%{

open Ast

%}

%token Lambda
%token Dot
%token LParen
%token RParen
%token Equal
%token Semicolon
%token <string> Var
%token EOF

%start <lc_expr> start

%type <lc_expr> program
%type <lc_expr> term application base

/* 
<program> ::= <term> | <binding> <program>
<binding> ::= $id = <term> ;
<term> ::= & $id . <application> | <application>
<application> ::= <application> <base> | <base>
<base> ::= $id | ( <term> )
*/

/* 
<program> ::= <term> | $id = <term> ; <program> --> (&id. <program>) <term>
<term> ::= & $id . <application> | <application>
<application> ::= <application> <base> | <base>
<base> ::= $id | ( <term> )
 */

%%

start :
  | p = program; EOF { p }

program :
  | t = term              { t }
  | x = Var; Equal; t = term ; Semicolon; p = program { EApp (ELambda( x, p), t) }

term : 
  | a = application        { a }
  | Lambda; x = Var; Dot; a = term { ELambda( x, a) }

application :
  | a = application; b = base { EApp (a, b) }
  | b = base                  { b }

base :
  | x = Var                   { EVar x }
  | LParen; t = term; RParen  { t }