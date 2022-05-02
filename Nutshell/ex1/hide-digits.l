%{

#include <stdio.h>
/* DEFINITION */
%}

%option noyywrap

/*  RULES  */
%%
[0-9]+ printf("?");
. ECHO;
%%



int main(){
	printf("->: ");
	yylex();


	return 0;
}

