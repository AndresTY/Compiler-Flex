%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/* DEFINITION */
%}

%token T_For T_Identifier T_IntConstant
%start INICIO

%%
	INICIO:
	T_For '(' Conditional ')' '{' Expr '}' 
	{

	}
	;

	Conditional: T_Identifier T_Identifier '=' T_IntConstant ';' T_Identifier '<' T_Identifier ';' T_Identifier '+' '+'{

		if(strcmp($1,"int")==0 && strcmp($2,$6)==0 && strcmp($10,$2)){
			return 0;
		}
		return -1;

	}
	;

	Expr: T_Identifier '=' T_IntConstant ';'{

		if(strcmp($1,"int")==0 && strcmp($3,"int")!=0){
				return 0;
		}
		return -1;

	}
	|
	T_Identifier T_Identifier ';'{



	}
	|
	T_Identifier '(' Function ')' ';'{ $$ = 0;}
	;

	Function: T_Identifier{ $$=$1; }
	|
	T_IntConstant{ $$=$1;}
