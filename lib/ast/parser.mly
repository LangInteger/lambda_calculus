%{
   open Ast
%}

%token DOT
%token LAMBDA

%token<string> IDENT

%token PAREN_LEFT
%token PAREN_RIGHT

%token EOF

%start main
%type <Ast.expr> main

%%


let main :=
  | t = term; EOF; { t }

let variable :=
  | x = IDENT; { Var x }

let element :=
  | variable
  | PAREN_LEFT; x = term; PAREN_RIGHT; { x }

let application :=
  | element
  | t = application; u = element; { App (t, u) }

let abstraction :=
  | LAMBDA; x = IDENT; u = body; { Lam (x, u) }

let body :=
  | DOT; u = term; { u }
  | x = IDENT; u = body; { Lam (x, u) }

let term :=
  | application
  | abstraction

