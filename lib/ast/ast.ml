type expr = 
  | Var of string 
  | Lam of string * expr
  | App of expr * expr
