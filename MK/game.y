%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int yylex(void);
	void yyerror(char *s);
	int DoDamage(int hp, int dmg);
	void do_fatality(int f, int s);
	int hp1 = 0;
	int hp2 = 0;
	char *n1 = "JAX";
	char *n2 = "KABAL";
%}

%token DMG PJ CREATED FATALITY
%start INICIO

%%
	INICIO: 
	PJ '-' Expr {
		//printf("\n%s %d",($1==0)?"JAX":"KABAL",$3);
		if ($1==0 && hp1>0){
			hp2 = DoDamage(hp2,$3);
			printf("%s - %d",n2,hp2);
		}else if($1==1 && hp2>0){
			hp1 = DoDamage(hp1,$3);
		}else{printf("\nESE PERSONAJE NO ESTA EN EL JUEGO O EL PERSONAJE YA ESTA MUERTO");}
	}
	|
	CREATED PJ{
		if(n1==""){
			n1 =($2==0 && $2!=42)?"JAX":"KABAL";
			printf("%s",n1);
		}else if (n2==""){
			n2 =($2==0 && $2!=42)?"JAX":"KABAL";
			printf("%s",n2);
		}else{printf("nYA HAY DOS KRAK");}
			

	}
	|
	FATALITY PJ{
		if($2==0 && hp1==0 && hp2>0){
			do_fatality($1,$2);
			return 0;
		}else if($2==1 && hp2==0 &&hp1>0){
			do_fatality($1,$2);
			return 0;
		}else{printf("\nNO SE PUEDE HACER LA FATALITY");}
			
	}
	;

	Expr : DMG {
		$$ = $1;
		}

%%

int main( int argc, char **argv ){
	hp1 = (int) atof(argv[1]); argc--; argv++;
	hp2 = (int) atof(argv[1]); argc--; argv++;
	printf("PARTIDA\n JAX: %d HP\n KABAL: %d HP\n",hp1,hp2);
	if(yyparse()==0)
		printf("\nFIN\n");
}

void yyerror(char *s){
	printf("\n%s\n",s);
}

int yywrap(){
	return 1;
}

int DoDamage(int hp, int dmg){
	if(hp-dmg <= 0){
		return 0;
		}
		return hp-dmg;
}

void do_fatality(int f,  int s){
	if(f==0){
		printf("\nBABALITY, \n%s WINS",(s==0 && s!=42)?"JAX":"KABAL");
	}else if(f==1){
		printf("\nFRIENDSHIP, \n%s WINS",(s==0 && s!=42)?"JAX":"KABAL");
	}else{
		printf("\nFATALITY, \n%s WINS",(s==0 && s!=42)?"JAX":"KABAL");
	}
}
