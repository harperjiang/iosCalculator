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
     AS = 266,
     PLOT = 267,
     REMOVE = 268,
     ALL = 269,
     EQUAL = 270,
     OADD = 271,
     OSUB = 272,
     OMUL = 273,
     ODIV = 274,
     OPWR = 275,
     ID = 276,
     NUM = 277,
     DECIMAL = 278,
     ABORT = 279,
     LOW = 280,
     OMOD = 281,
     LV3 = 282,
     LV2 = 283,
     LV1 = 284
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
#define AS 266
#define PLOT 267
#define REMOVE 268
#define ALL 269
#define EQUAL 270
#define OADD 271
#define OSUB 272
#define OMUL 273
#define ODIV 274
#define OPWR 275
#define ID 276
#define NUM 277
#define DECIMAL 278
#define ABORT 279
#define LOW 280
#define OMOD 281
#define LV3 282
#define LV2 283
#define LV1 284




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "console.ypp"
{
    char* stringTerm;
    CExpression* data;
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
#line 122 "ConsoleParser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

