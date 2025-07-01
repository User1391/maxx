grammar maxx;

program: statement* EOF;

statement
    : variableDecl
    | printStmt
    ;

variableDecl
    : 'let' ID '=' expr ';'
    ;

printStmt
    : 'print' expr ';'
    ;

expr
    : expr op=('*'|'/') expr   # MulDiv
    | expr op=('+'|'-') expr   # AddSub
    | INT                      # Int
    | ID                       # Var
    | '(' expr ')'             # Parens
    ;

ID  : [a-zA-Z_][a-zA-Z_0-9]*;
INT : [0-9]+;

WS  : [ \t\r\n]+ -> skip;

