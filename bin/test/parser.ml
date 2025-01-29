open Ast_entry.ParserUtil

(* let expr = "x"
let parsed_expr: expr = parse_input expr 
let parsed_expr_str = pprint_expr parsed_expr
let _ = print_endline (Printf.sprintf "lambda calculus expression [%s] is parsed as [%s]" expr parsed_expr_str)
 *)

let process_expression expr =
  let parsed_expr_opt = parse_input_opt expr in
  match parsed_expr_opt with
  | Some parsed_expr ->  begin
      let parsed_expr_str = pprint_expr parsed_expr in
      Printf.printf "lambda calculus expression [%s] is parsed as [%s]\n" expr parsed_expr_str
    end
  | None -> 
    Printf.printf "lambda calculus expression [%s] cannot be parsed\n" expr
  

let () =
  let filename = "expressions.txt" in
  let in_channel = open_in filename in
  try
    while true do
      let line = input_line in_channel in
      (* let _ = print_endline (Printf.sprintf "second char: %c" (String.get line 1)) in *)
      process_expression line
    done
  with End_of_file ->
    close_in in_channel
