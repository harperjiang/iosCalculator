%{
#include <stdio.h>
#include "console_parser.h"
%}

%option noyywrap

%%
=				{return EQUAL;}
;				{return SEMICOLON;}
'				{return DASH;}
"["				{return LBR;}
"]"				{return RBR;}
"+"				{return ADD;}
-				{return SUB;}
"*"				{return MUL;}
[0-9]+			{yylval.number = atoi(yytext); return NUM;}
"clear"			{return CLEAR;}
[a-z][a-z0-9]+	{yylval.string = yytext; return ID;}
.				{yyerror();}
%%