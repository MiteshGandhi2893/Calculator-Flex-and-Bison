%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
void yyerror(const char* s);
%}

%union {
	float  valI;
}

%token<valI> IntExp
%token ADD SUB MUL DIVIDE NEXTLINE

%type<valI> Iexpression
%start calculator

%%

calculator: 
	   | calculator line
;

line: NEXTLINE
    | Iexpression NEXTLINE {float answer=$1; if((answer-(int)answer)==0){printf("%d\n",(int)answer);}else{printf("%f\n",answer);}} 

;



Iexpression :	IntExp			{$$=$1;}
				|Iexpression Iexpression ADD		{$$=$1+$2;}
				|Iexpression Iexpression SUB		{$$=$1-$2;}
				|Iexpression Iexpression MUL		{$$=$1*$2;}
				|Iexpression Iexpression DIVIDE		{$$=$1/$2;}
;




%%
int main() {
yyparse();
	return 0;
}
void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}