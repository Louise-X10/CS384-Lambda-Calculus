open Ast

let next_var = ref 0

let fresh_var (_ : unit) : string =
  let () = next_var := !next_var + 1 in
  "x$" ^ string_of_int !next_var

(* takes a lambda calculus term s, a string x, and a term t and returns s[t/x]. *)
let rec beta_red (s: lc_expr) (x: string) (t: lc_expr) : lc_expr = 
  match s with 
  | EVar y -> if y = x then t else EVar y
  | EApp (e1, e2) -> EApp(beta_red e1 x t, beta_red e2 x t)
  | ELambda (y, e) -> if y = x then ELambda (x, e) else 
                        let z = fresh_var () in 
                        let e2 = beta_red e y (EVar z) in 
                      ELambda(z, beta_red e2 x t)

let rec is_irr (s: lc_expr) : bool = 
  match s with 
  | EVar _ -> true
  | ELambda (_, t) -> if is_irr t then true else false
  | EApp (EVar _, t) -> if is_irr t then true else false
  | EApp (EApp(t1, t2), t3) -> if is_irr (EApp(t1, t2)) && is_irr t3 then true else false
  | _ -> false

let rec reduce (s : lc_expr) : lc_expr =
  match s with 
  | EApp (ELambda(x, s), t) -> reduce (beta_red s x t)
  | ELambda(x, t) -> if is_irr t then ELambda(x, t) else 
                      let t' = reduce t in 
                      ELambda(x, t')
  | EApp (EApp(t1, t2), t3) -> if is_irr (EApp(t1, t2)) then 
                                (if is_irr t3 then EApp (EApp(t1, t2), t3) else
                                  let t3' = reduce t3 in EApp (EApp(t1, t2), t3'))
                                else let t' = reduce (EApp(t1, t2)) in reduce(EApp (t', t3))
                          
  | EApp (EVar x, t) -> if is_irr t then EApp (EVar x, t) else 
                        let t' = reduce t in 
                        EApp (EVar x, t')
  | e -> if is_irr e then e else failwith("expect irreducible input but recieve reducible input not covered by reduce function")