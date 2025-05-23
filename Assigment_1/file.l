/* Write a program using LEX specifications to implement lexical 
analysis phase of compiler to generate tokens of subset of C program. */

%{
%}
letter [A-Za-z]
digit [0-9]
identifier {letter}({letter}|{digit})*
number {digit}+(\.{digit}+)?
punctuation [;,."#(){}]
operators [+-=*<>]
keywords if|else|for|int|while|do|void
literal ["].*["]
comment "//".*
headerfile "#".*
multicomment "/*"(.|\n)*"*/"

%%

{headerfile}   {printf("\n Headerfile %s is found ",yytext);}
{keywords}     {printf("\n Keyword %s is found",yytext);}
{identifier}   {printf("\n Identifier %s is found ",yytext);}
{number}       {printf("\n  Number %s is found ",yytext);}
{punctuation}  {printf("\n Punctuation  %s is found ",yytext);}
{literal}      {printf("\n Literal %s is found ",yytext);}
{operators}    {printf("\n Operators  %s is found ",yytext);}
{comment}      {printf("\n  Single-line Comment %s is found ",yytext);}
{multicomment} {printf("\n Multi-line comment %s is found",yytext);}

%%

int main(void)
{
 yylex();
 return 0;
}

int yywrap()
{
  return 1;
}




