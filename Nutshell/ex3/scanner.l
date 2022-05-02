%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/* DEFINITION */
%}

%option noyywrap

/*  RULES  */


%%

[+>;] { printf("%s",yytext[0]); /* use ASCII code for single-char token */}
"for" { printf("LOOP"); }
[0-9]+ { printf("INT "); }
[a-z]+ { printf("IDENTIFIER "); }
. ECHO;

%%



int main(){
	printf("->: ");
	yylex();


	return 0;
}

