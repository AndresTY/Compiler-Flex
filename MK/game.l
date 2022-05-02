%{
	#include <string.h>
	#include <stdio.h>
	#include "y.tab.h"
	void yyerror(char *);
	int vs(char *l);
	int getValue(char a);
	int split(char *str);
	int fatalities(char* s);
%}

%option noyywrap

/* STANDAR FRIENDSHIP = Back Front Down Down X */
FRIENDSHIP BFDDX 
/* STANDAR BABALITY = Down Down Up Up Y*/ 
BABALITY DDUUY
JAX_FATALITIES {FRIENDSHIP}|{BABALITY}|FBFA|BFBDX
KABAL_FATALITIES {FRIENDSHIP}|{BABALITY}|BFBFA|DDDB
PERSON JAX|KABAL
HIT X|Y|B|A
COMBO {HIT}+

%%

{PERSON} { yylval = vs(yytext); return PJ; }
{COMBO} { yylval = split(yytext); return DMG; }
[-] { return *yytext; }
player { return CREATED; }
JAX:{JAX_FATALITIES} { yylval = fatalities(yytext); return FATALITY; }
KABAL:{KABAL_FATALITIES} { yylval = fatalities(yytext); return FATALITY; }
. ECHO;

%%

int fatalities(char* s){
	if(strcmp(s,"BFDDX")==0){
		return 0;
	}else if(strcmp(s,"UUY")==0){
		return 1;
	}else{return 2;}
}

int vs(char*l){
	if(strcmp(l,"JAX")==0){
		return 0;
	}else if (strcmp(l,"KABAL")==0){
		return 1;
	}else{return 42;}
}

int split(char *str) {   
    int sum=0;
    int pos=0;
    int temp=0;

    while(*str){
	temp=getValue(*str++);
        sum = sum + temp ;
    }
    
    return sum;
}

int getValue(char a){
	if(a=='A'){
		return 5;
	}else if(a=='B'){
		return 5;
	}else if(a=='X'){
		return 10;
	}else if(a=='Y'){
		return 10;
	}else{
		return 0;
	}	
}
