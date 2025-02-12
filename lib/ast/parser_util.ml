open Ast

let read_line i = try Some (input_line i) with End_of_file -> None 

let lines_from_file filename = 
  let rec lines_from_files_aux i acc = match (read_line i) with 
    | None -> List.rev acc
    | Some s -> lines_from_files_aux i (s :: acc) in 
  lines_from_files_aux (open_in filename) [] 

let parse_input_opt (s : string) : expr option =
  let lexbuf = Lexing.from_string s in
  try
    Some (Parser.main Lexer.token lexbuf)
  with
  | End_of_file -> 
    print_endline "End_of_file";
    None
  | Lexer.Error c ->
     print_endline ("Lexical error at pos " 
      ^ string_of_int lexbuf.lex_curr_p.pos_cnum 
      ^ ": Unknown character '" ^ Char.escaped c ^ "'");
     None
  | Parser.Error ->
     Printf.fprintf stderr "Parse error at column %d:\n" lexbuf.lex_curr_p.pos_cnum;
     None

let parse_input (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  try
    Parser.main Lexer.token lexbuf
  with
  | End_of_file -> 
    Printf.fprintf stderr "End_of_file";
    exit 1 
  | Lexer.Error c ->
     print_endline ("Lexical error at pos " 
      ^ string_of_int lexbuf.lex_curr_p.pos_cnum 
      ^ ": Unknown character '" ^ Char.escaped c ^ "'");
     exit 1
  | Parser.Error ->
     Printf.fprintf stderr "Parse error at column %d" lexbuf.lex_curr_p.pos_cnum;
     exit 1

let parse_inputs (s : string list) : expr list =
  List.map parse_input s

let parse(file_addr: string): expr list  =
  parse_inputs (lines_from_file file_addr)

let rec pprint_expr (exp: expr): string =
  match exp with
  | Var x -> x 
  | Lam (x, b) -> Printf.sprintf "λ%s.(%s)" x (pprint_expr b)
  | App (e1, e2) -> Printf.sprintf "(%s) (%s)" (pprint_expr e1) (pprint_expr e2)