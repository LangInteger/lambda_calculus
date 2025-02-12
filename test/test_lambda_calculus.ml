module P = Ast_entry.ParserUtil

let lines = P.lines_from_file "./expressions.txt"
let parse_and_print (s: string): bool =
  match P.parse_input_opt s with 
  | Some e -> 
    let _ = print_endline ("Parse success for " ^ s ^ ", output: " ^ (P.pprint_expr e)) in 
      true 
  | None -> 
    let _ = print_endline ("Parse fail for " ^ s) in 
      false

let _ = List.for_all parse_and_print lines