{
  open Parser
  exception Error of char
}
let ident = ['a'-'z' 'A'-'Z' '0'-'9' ] +
let ws = [' ' '\t']

rule token = parse
  | ws { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | "\r\n" { Lexing.new_line lexbuf; token lexbuf }
  | "." { DOT }
  | "λ" { LAMBDA }
  | ident as str
      {
        match str with
        | s -> IDENT(s)
      }
  | "(" { PAREN_LEFT }
  | ")" { PAREN_RIGHT }
  | eof { EOF }


