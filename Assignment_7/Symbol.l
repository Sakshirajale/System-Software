/* Write a program using LEX and YACC to generate a symbol table for 
identifiers declared in a C-like program  */
%{
#include "y.tab.h"
#include <string.h>

extern int yylval;
%}

%%
int      { return INT; }
float    { return FLOAT; }
char     { return CHAR; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval = strdup(yytext); return ID; }

","      { return COMMA; }
";"      { return SEMICOLON; }
[ \t\n]+ ; // ignore whitespace
.        ; // ignore unknown characters
%%
