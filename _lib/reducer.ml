open Ast

let next_var = ref 0

let fresh_var (_ : unit) : string =
  let () = next_var := !next_var + 1 in
  "x$" ^ string_of_int !next_var

let reduce (_ : lc_expr) : lc_expr =
  failwith "Not implemented"
