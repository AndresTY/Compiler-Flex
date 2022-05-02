%{

#include <stdio.h>
/* DEFINITION */
%}

%option noyywrap

/*  RULES  */
%%

[a-z0-9.]{3,}@[a-z0-9.-]+ {printf("Email addres\n");} 
3[0-9]{9} {printf("Mobile Number\n");} 
[a-zA-Z_][a-zA-Z0-9_]* {printf("Identifier\n");}
.+ {printf("Invalid");}
\n {return 0;}

%%



int main(){
	printf("Entre string: ");
	yylex();


	return 0;
}


