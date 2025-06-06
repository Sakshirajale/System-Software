%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Symbol {
    char* name;
    char* type;
};

struct Symbol symbolTable[100];
int symbolCount = 0;
char currentType[10];

void insertSymbol(char* name);
void printSymbolTable();
%}

%union {
    char* str;
}

%token <str> ID
%token INT FLOAT CHAR
%token COMMA SEMICOLON

%%

program:
    declarations
    {
        printSymbolTable();
    }
    ;

declarations:
    declarations declaration
    |
    declaration
    ;

declaration:
    type id_list SEMICOLON
    ;

type:
    INT     { strcpy(currentType, "int"); }
    | FLOAT { strcpy(currentType, "float"); }
    | CHAR  { strcpy(currentType, "char"); }
    ;

id_list:
    ID          { insertSymbol($1); }
    | id_list COMMA ID { insertSymbol($3); }
    ;

%%

void insertSymbol(char* name) {
    for (int i = 0; i < symbolCount; ++i) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            printf("Error: Redefinition of identifier '%s'\n", name);
            return;
        }
    }
    symbolTable[symbolCount].name = strdup(name);
    symbolTable[symbolCount].type = strdup(currentType);
    symbolCount++;
}

void printSymbolTable() {
    printf("\nSymbol Table:\n");
    printf("%-15s %-10s\n", "Identifier", "Type");
    for (int i = 0; i < symbolCount; ++i) {
        printf("%-15s %-10s\n", symbolTable[i].name, symbolTable[i].type);
    }
}

int main() {
    return yyparse();
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
