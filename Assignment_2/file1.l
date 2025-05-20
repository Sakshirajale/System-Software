/*Write a LEX program to display word, character, and line counts for a 
sample input text file. */
%{ 
  
    int ccount=0,capcount=0,smalcount=0,lcount=0;
%}

cword [A-Z]+
sword [a-z]+
eol \n
%%

{cword} {capcount++;ccount+=yyleng;}
{sword} {smalcount++;ccount+=yyleng;}
{eol}  {ccount++;lcount++;}
 .  {ccount++;}
%%

int main(void)
{
  yylex();
  printf("\nNumber of characters : %d",ccount);
  printf("\nNumber of Capital Case Words : %d",capcount);
  printf("\nNumber of small Case Words : %d",smalcount);
  printf("\nNumber of Lines : %d",lcount);
  return 0;
}

int yywrap()
{
  return 1;
}



