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

main:
  | expression EOF   { $1 }

expression:
  | IDENT {Var $1}
  | LAMBDA IDENT DOT expression { Lam ($2, $4) }
  | expression expression { App ($1, $2) }
  | LAMBDA IDENT DOT PAREN_LEFT expression PAREN_RIGHT { Lam ($2, $5) }
  | PAREN_LEFT expression PAREN_RIGHT PAREN_LEFT expression PAREN_RIGHT { App ($2, $5) }
  | PAREN_LEFT expression PAREN_RIGHT {$2}
