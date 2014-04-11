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
     NUM = 258,
     LP = 259,
     RP = 260,
     OADD = 261,
     OSUB = 262,
     OMUL = 263,
     ODIV = 264,
     OMOD = 265,
     POWER = 266,
     FUNC_SIN = 267,
     FUNC_COS = 268,
     FUNC_LN = 269,
     DOPR = 270,
     VAR = 271,
     IOPR = 272,
     DX = 273,
     CONST_E = 274,
     CONST_PI = 275,
     LOW = 276,
     HIGH = 277
   };
#endif
/* Tokens.  */
#define NUM 258
#define LP 259
#define RP 260
#define OADD 261
#define OSUB 262
#define OMUL 263
#define ODIV 264
#define OMOD 265
#define POWER 266
#define FUNC_SIN 267
#define FUNC_COS 268
#define FUNC_LN 269
#define DOPR 270
#define VAR 271
#define IOPR 272
#define DX 273
#define CONST_E 274
#define CONST_PI 275
#define LOW 276
#define HIGH 277




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 14 "calculus.ypp"
{
    char* stringTerm;
    CFunction* func;
    CFunction* pfunc;
    CNameFunc* namefunc;
    CConstant* num;
}
/* Line 1529 of yacc.c.  */
#line 101 "CalculusParser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE callval;

