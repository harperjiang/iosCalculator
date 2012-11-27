/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     COMMA = 258,
     SEMICOLON = 259,
     LBR = 260,
     RBR = 261,
     SIQ = 262,
     LP = 263,
     RP = 264,
     CLEAR = 265,
     EQUAL = 266,
     OADD = 267,
     OSUB = 268,
     OMUL = 269,
     ODIV = 270,
     ID = 271,
     NUM = 272,
     LV3 = 273,
     LV2 = 274,
     LV1 = 275
   };
#endif
/* Tokens.  */
#define COMMA 258
#define SEMICOLON 259
#define LBR 260
#define RBR 261
#define SIQ 262
#define LP 263
#define RP 264
#define CLEAR 265
#define EQUAL 266
#define OADD 267
#define OSUB 268
#define OMUL 269
#define ODIV 270
#define ID 271
#define NUM 272
#define LV3 273
#define LV2 274
#define LV1 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "/Users/harper/Projects/IDCalculator/IDCalculator/IDCalculator/console.ypp"
{
    char* stringTerm;
    CData* data;
    CNumData* num;
    CExpression* exp;
    CExpList* expList;
    CExpList* dataList;
    CExpList* rowList;
    CExpList* params;
    CMatrix*  matrix;
    CCommand* command;
    CIdentifier* id;
    CFuncExpression* func;
}
/* Line 1529 of yacc.c.  */
#line 104 "/Users/harper/Projects/IDCalculator/IDCalculator/IDCalculator/ConsoleParser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

