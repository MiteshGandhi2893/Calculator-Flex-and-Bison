%option noyywrap
%{
#include<string.h>
#include "calculatorFB.tab.h"
%}

nums	[0-9]
I1	{nums}+
R	({nums}+[.]{nums}*)|({nums}*[.]{nums}+)
expression1	({I1}|{R})[eE]{I1}
expression2	({I1}|{R})[eE][+-]{I1}
expression3	[+-]({I1}|{R})[eE][+-]{I1}
I2	[+-]({I1}|{R})

%%

({I1}|{I2}|{R}|{expression1}|{expression2}|{expression3})			{yylval.valI=atof(yytext);return IntExp;}
	
						
"+"																{return ADD;}
"-"																{return SUB;}
"/"																{return DIVIDE;}
"*"																{return MUL;}
\n	               												{return NEXTLINE;}																		

[^-0-9+*/.;eE \t\n]+												{printf("Invalid character %c\n",yytext[0]); exit(1);}                  
%%

