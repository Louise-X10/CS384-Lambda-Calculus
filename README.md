# Lambda Calculus

Lambda Calculus is a programming language where everything is an expression (e.g. function application, lambda function definition). This homework implements Lambda Calculus with name bindings.  *For CS 384 Programming Language and Implementation* 


**Syntax**

A disambiguated grammar for Lambda Calculus with bindngs:

```
<program> ::= <term> | <binding> <program>
<binding> ::= $id = <term> ;
<term> ::= & $id . <term> | <application>
<application> ::= <application> <base> | <base>
<base> ::= $id | ( <term> )
```

**Semantics**

Any expression that doesn't match any of the following irreducible rules is irreducible. 

```
----- (Irr-Symb)
x irr

  t irr
--------- (Irr-Lambda)
&x. t irr

  t irr
--------- (Irr-AppVar)
(x t) irr

(t1 t2) irr   t3 irr
-------------------- (Irr-AppApp)
   (t1 t2) t3 irr
```

Reducible expressions can be reduced via any of the following reduction rules. 

```
-------------------- (Reduce-Beta)
(&x. t) s ~~> t[s/x]

    t ~~> t`
---------------- (Reduce-Lambda)
&x. t ~~> &x. t'

   (t1 t2) ~~> t'
-------------------- (Reduce-Left)
(t1 t2) t3 ~~> t' t3

  t ~~> t'
------------ (Reduce-AppVar)
x t ~~> x t'

(t1 t2) irr     t3 ~~> t3'
-------------------------- (Reduce-AppApp)
(t1 t2) t3 ~~> (t1 t2) t3'
```


## Implementation

To build project, run `dune build`. 

To run tests, run `dune runtests`. 

- `_lib` contains original lib files provided by instructor, ignored by dune. 
- `lib` contains my files for generating lexer with ocamllex and generating parser with Menhir. 
  - `lexer.mll` defines rules to tokenize input strings into tokens. 
  - `parser.mly` defines grammar to parse tokens into AST data types. 
  - `reducer.ml` defines reduction rules on Lambda Calculus expressions (i.e. ASTs)
