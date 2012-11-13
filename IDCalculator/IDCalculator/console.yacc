%{
#include <stdio.h>
#import "Matrix.h"
#import "ClearCommand.h"
#import "AssignCommand.h"
#import "VariableCommand.h"
#import "IntegerConstant.h"

int yyerror(char* s) {
	printf("%s",s);
}

void main(int argc, char** argv) {
	yyparse();	
}
%}

%union {
	int number;
	char* string;
}

%token CLEAR EQUAL SEMICOLON LBR RBR DASH 
%token ADD SUB MUL ID NUM

%left ID
%left EQUAL

%start command

%%

command :	CLEAR					{return [[ClearCommand alloc] init];}
		|	ID EQUAL object			{return [[AssignCommand alloc] init:$1 value:$2];}
		|	ID						{return [[VariableCommand alloc] init:$1];};

object	:	matrix					{return $1;};

matrix	:	LBR rowList	RBR			{return [[Matrix alloc] init:$1];};

rowList	:	numList						{NSMutableArray* arrayOfRow = [[NSMutableArray] alloc] initWithCapacity:10]; [arrayOfRow addObject:$1]; return arrayOfRow;}
		|	numList	SEMICOLON rowList	{NSMutableArray* arrayOfRow = (NSMutableArray*)$2; [arrayOfRow addObject:$1]; return arrayOfRow;};

numList	:	NUM						{NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:20]; [array addObject:[IntegerConstant construct:$1]]; return array;}
		|	NUM	numList				{NSMutableArray* array = (NSMutableArray*)$2; [array insertObject:[IntegerConstant construct:$1]]; return array;};

%%