%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/* DEFINITION */
%}

%option noyywrap

/*  RULES  */


%%
[+>;(){}] { return *yytext; /* use ASCII code for single-char token */}
"for" { return T_For; }
[0-9]+ { yylval = atoi(yytext);
	return T_IntConstant; }
[a-z]+ { yylval = strdup(yytext);
	return T_Identifier; }

%%


