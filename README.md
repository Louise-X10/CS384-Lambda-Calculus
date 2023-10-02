# Lambda Calculus

For CS 384 Programming Language and Implementation. 


To build project, run `dune build`. 

To run tests, run `dune runtests`. 

- `_lib` contains original lib files provided by instructor, ignored by dune. 
- `lib` contains my files for generating lexer with ocamllex and generating parser with Menhir. 
  - `lexer.mll` defines rules to tokenize input strings into tokens. 
  - `parser.mly` defines grammar to parse tokens into AST data types. 
  - `reducer.ml` defines reduction rules on Lambda Calculus expressions (i.e. ASTs)
