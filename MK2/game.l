%{
	#include <string.h>
	#include <stdio.h>
	int getValue(char a);
	void yyerror(char *s);
	int split(char *str);
	int DoDamage(int hp, int dmg);
	void do_global_fatality(char *s);
	void do_scorpion_fatality(char *s);
	void do_sindel_fatality(char *s);
	int hp1 = 0;
	int hp2 = 0;
	char *n1 = "SCORPION";
	char *n2 = "SINDEL";
	int is_alive(int hp);
	void combinho(char* s);
	int is_special(char* y,char* s);
	int scorpion_special(char* s);
	int sindel_special(char* s);
%}

%option noyywrap

/* STANDAR FRIENDSHIP = Back(L) Front(R) Down Down X */
FRIENDSHIP LRDDX 
/* STANDAR BABALITY = Down Down Up Up Y*/ 
BABALITY DDUUY
SCORPION_FATALITIES RLRA|LRLDX
SINDEL_FATALITIES LRLRA|DDDB
GLOBAL_FATALITIES {FRIENDSHIP}|{BABALITY}|{HIT}
PERSON SCORPION|SINDEL
HIT X|Y|B|A
MOVES L|R|U|D
SPECIAL {HIT}+{MOVES}*|{MOVES}*{HIT}+|{MOVES}+
COMBO {SPECIAL}+
%%

{PERSON}-{COMBO} { combinho(yytext); }
{PERSON}-{GLOBAL_FATALITIES}-{PERSON} { do_global_fatality(yytext); }
{PERSON}-{SCORPION_FATALITIES}-{PERSON} { do_scorpion_fatality(yytext); }
{PERSON}-{SINDEL_FATALITIES}-{PERSON} { do_sindel_fatality(yytext); }
						
. ECHO;

%%

void combinho(char * s){
	char* temp = strtok(s,"-");
	char* comb = strtok(NULL,"-");
	int special = is_special(temp,comb);
	if(special==-1){
		if(strcmp(temp,n1)==0){
			if (hp1>0 && is_alive(hp2)){
				hp2 = DoDamage(hp2,split(comb));
				printf("%s have %d HP",n2,hp2);
			}else{printf("\nESE PERSONAJE NO ESTA EN EL JUEGO O EL PERSONAJE YA ESTA MUERTO");} 
		}else if(strcmp(temp,n2)==0){
			if (hp2>0 && is_alive(hp1)){
				hp1 = DoDamage(hp1,split(comb));
				printf("%s have %d HP",n1,hp1);
			}else{printf("\nESE PERSONAJE NO ESTA EN EL JUEGO O EL PERSONAJE YA ESTA MUERTO");} 
		}
	}else{
		if(strcmp(temp,n1)==0){
			if (hp1>0 && is_alive(hp2)){
				hp2 = DoDamage(hp2,special);
				printf("%s have %d HP",n2,hp2);
			}else{printf("\nESE PERSONAJE NO ESTA EN EL JUEGO O EL PERSONAJE YA ESTA MUERTO");} 
		}else if(strcmp(temp,n2)==0){
			if (hp2>0 && is_alive(hp1)){
				hp1 = DoDamage(hp1,special);
				printf("%s have %d HP",n1,hp1);
			}else{printf("\nESE PERSONAJE NO ESTA EN EL JUEGO O EL PERSONAJE YA ESTA MUERTO");} 
		}
	
	}
}

int is_special(char* y,char* s){
	return (strcmp(y,n1)==0)?scorpion_special(s):(strcmp(y,n2)==0?sindel_special(s):printf("ESE PERSONAJE NO ESTA EN EL JUEGO"));
}

int scorpion_special(char* s){
	if(strcmp(s,"LLX")==0){
		printf("\n%s - SPEAR\n",n1);
		return 15;
	}else if(strcmp(s,"DLY")==0){
		printf("\n%s - DEMON FIRE\n",n1);
		return 18;
	}else if(strcmp(s,"DLB")==0){
		printf("\n%s - TELEPORT\n",n1);
		return 0;
	}else  if(strcmp(s,"DLX")==0){
		printf("\n%s - TAKEDOWN\n",n1);
		return 12;
	}else{
		return -1;
	}
}

int sindel_special(char* s){
	if(strcmp(s,"DRX")==0){
		printf("\nFIREBALL\n");
		return 15;
	}else if(strcmp(s,"DRA")==0){
		printf("\nLOW FIREBALL\n");
		return 10;
	}else if(strcmp(s,"DLY")==0){
		printf("\nSCREAM\n");
		return 4;
	}else if(strcmp(s,"DDU")==0){
		printf("\nLEVITAR\n");
		return 0;
	}else if(strcmp(s,"DRY")==0){
		printf("\nHAIR WHIP\n");
		return 11;
	}else if(strcmp(s,"DRB")==0){
		printf("\nSTEP UP\n");
		return 13;
	}else{
		return -1;
	}
}

int is_alive(int hp){
	return ((hp>0)?1:0);
}

int fatalities(char* s){
	if(strcmp(s,"BFDDX")==0){
		return 0;
	}else if(strcmp(s,"UUY")==0){
		return 1;
	}else{return 2;}
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
int main( int argc, char **argv ){
	hp1 = (int) atof(argv[1]); argc--; argv++;
	hp2 = (int) atof(argv[1]); argc--; argv++;
	printf("PARTIDA\n SCORPION: %d HP\n SINDEL: %d HP\n",hp1,hp2);
	yylex();
}

void yyerror(char *s){
	printf("\n%s\n",s);
}

int DoDamage(int hp, int dmg){
	if(hp-dmg <= 0){
		return 0;
		}
		return hp-dmg;
}

void do_global_fatality(char *s){
	char* name1 = strtok(s,"-");
	char* combix = strtok(NULL,"-");
	char* name2 = strtok(NULL,"-");
	if(strcmp(name1,n1)==0 && is_alive(hp1)){
		if(strcmp(combix,"BFDDX")==0 && hp2==0){
			printf("\n%s FRIENDSHIP\n %s WINS",name1,name1);
		}else if(strcmp(combix,"DDUUY")==0 && hp2==0){
			printf("\n%s BABALITY\n %s WINS",name1,name1);
		}else if ((strcmp(combix,"X")==0||strcmp(combix,"Y")==0 ||strcmp(combix,"A")==0 ||strcmp(combix,"B")==0) && hp2==0){
			printf("\n %s WINS",name1);
		}else{
			printf("FATALITY NO VALIDA");
		}
	}else if(strcmp(name2,n2)==0 && is_alive(hp2)){
		if(strcmp(combix,"BFDDX")==0 && hp1==0){
			printf("\n%s FRIENDSHIP\n %s WINS",name2,name2);
		}else if(strcmp(combix,"DDUUY")==0 && hp1==0){
			printf("\n%s BABALITY\n %s WINS",name2,name2);
		}else if ((strcmp(combix,"X")==0||strcmp(combix,"Y")==0 ||strcmp(combix,"A")==0 ||strcmp(combix,"B")==0) && hp1==0){
			printf("\n %s WINS",name2);
		}else{
			printf("FATALITY NO VALIDA");
		}
	}else{
		printf("FATALITY NO VALIDA");
	}
}
void do_scorpion_fatality(char *s){
	char* name1 = strtok(s,"-");
	char* combix = strtok(NULL,"-");
	char* name2 = strtok(NULL,"-");
	if(strcmp(name1,n1)==0 && is_alive(hp1)){
		if((strcmp(combix,"FBFA")==0 ||strcmp(combix,"BFBDX")==0 )&& hp2==0){
			printf("\n%s FATALITY\n %s WINS",name1,name1);
		}else{
			printf("FATALITY NO VALIDA");
		}
	}else{
		printf("FATALITY NO VALIDA");
	}
}

void do_sindel_fatality(char *s){
	char* name1 = strtok(s,"-");
	char* combix = strtok(NULL,"-");
	char* name2 = strtok(NULL,"-");
	if(strcmp(name2,n2)==0 && is_alive(hp2)){
		if((strcmp(combix,"BFBFA")==0 ||strcmp(combix,"DDDB")==0 )&& hp1==0){
			printf("\n%s FATALITY\n %s WINS",name2,name2);
		}else{
			printf("FATALITY NO VALIDA");
		}
	}else{
		printf("FATALITY NO VALIDA");
	}
}












