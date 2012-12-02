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
     POWER = 265,
     FUNC_SIN = 266,
     FUNC_COS = 267,
     FUNC_LN = 268,
     DOPR = 269,
     VAR = 270,
     IOPR = 271,
     CONST_E = 272,
     CONST_PI = 273
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
#define POWER 265
#define FUNC_SIN 266
#define FUNC_COS 267
#define FUNC_LN 268
#define DOPR 269
#define VAR 270
#define IOPR 271
#define CONST_E 272
#define CONST_PI 273




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 14 "/Users/harper/Projects/IDCalculator/IDCalculator/IDCalculator/calculus.ypp"
{
    char* stringTerm;
    CFunction* func;
    CNameFunc* namefunc;
    CConstant* num;
}
/* Line 1529 of yacc.c.  */
#line 92 "/Users/harper/Projects/IDCalculator/IDCalculator/IDCalculator/CalculusParser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE callval;

