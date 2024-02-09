%{
// Roberto Campero Calderon Cruz
// Traductores de Lenguales I 2021A
// Actividad Traductor
// C CODE
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#define NOMBRE_ARCHIVO_OUT "salida.txt"
#define NOMBRE_ARCHIVO_IN "prueba2.txt"
int chars = 0;
int lineas = 0;
short cuentaHex = 0;
short cuentaCadenas = 0;
short cuentaNumeros = 0;
unsigned short direccionMac[8] = {0x0};
unsigned char numeros[4] = {0x0};
char cadenas[10][50];
FILE * archivo;
%}

DIGITO [0-9]
NUM8 (,|\.)(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])
ID [a-z][a-z0-9]*
NAME [A-Z][a-z]*
DIR [0-9][a-f0-9]*
HEX [a-f0-9]
SEG ^(\/)DIGITO{2}


ESPACIO [ \t]
SEPARADOR (,)|{ESPACIO}|(:)
DOT (\.)

%%
{HEX}{4}	{direccionMac[cuentaHex] = (unsigned short)strtol(yytext, NULL, 16); cuentaHex++;}
{SEPARADOR} {}
{SEG}		{}
{NAME}		{strcpy(cadenas[cuentaCadenas], yytext); cuentaCadenas++;}
{NUM8}		{yytext++; numeros[cuentaNumeros] = (unsigned char)strtol(yytext, NULL, 0); cuentaNumeros++;}
\n 			{
				fprintf(archivo, "%s,", cadenas[1]);
				for (int i = 0; i < cuentaHex; i++){ 
					(i != 7) ? fprintf(archivo, "%u:", direccionMac[i]) : fprintf(archivo, "%u,", direccionMac[i]);
				}
				for (int i = 0; i < cuentaNumeros; ++i)
				 {
				 	(i != 3) ? fprintf(archivo, "%X.", numeros[i]) : fprintf(archivo, "%X\n", direccionMac[i]);
				 } 
				 cuentaNumeros = 0; cuentaHex = 0; cuentaCadenas = 0;
				 lineas++;
			}
.			{chars++;}
%%

int main(){
	yyin=fopen(NOMBRE_ARCHIVO_IN,"r");
	archivo = fopen(NOMBRE_ARCHIVO_OUT, "w");
	yylex();
	fclose(archivo);
	printf("Caracteres: %8d Lineas: %8d\n", chars, lineas);
	return 0;
}