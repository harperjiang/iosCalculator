//
//  CalModel.h
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#ifndef __IDCalculator__CalModel__
#define __IDCalculator__CalModel__

#include <iostream>
#include "Operator.h"

typedef enum _CalModelType {
    CAL_VAR,
    CAL_FUNC_ARITH,
    CAL_FUNC_POWER,
    CAL_FUNC_NAME,
    CAL_FUNC_INT,
    CAL_FUNC_DIFF,
    CAL_CON_NUM,
    CAL_CON_SPEC
} CalModelType;

class CFunction {
public:
    virtual int type() = 0;
    virtual ~CFunction() {}
};

class CVariable : public CFunction {
public:
    int type() {return CAL_VAR;}
};

class CArithFunc : public CFunction {
public:
    CFunction* left;
    Operator opr;
    CFunction* right;
    
    CArithFunc(CFunction* left, Operator opr, CFunction* right);
    ~CArithFunc();
    
    int type() {return CAL_FUNC_ARITH;}
};

class CIntFunc : public CFunction {
public:
    CFunction* base;
    CFunction* factor;
    
    CIntFunc(CFunction* base, CFunction* factor);
    ~CIntFunc();
    
    int type() {return CAL_FUNC_INT;}
};

class CDiffFunc : public CFunction {
public:
    CFunction* base;
    CFunction* factor;
    
    CDiffFunc(CFunction* base, CFunction* factor);
    ~CDiffFunc();
    
    int type() {return CAL_FUNC_DIFF;}
};

typedef enum _FuncName {
    NF_SIN,NF_COS,NF_LN
} FuncName;

class CNameFunc : public CFunction {
public:
    FuncName name;
    CFunction* param;
    
    CNameFunc(FuncName name, CFunction* param);
    ~CNameFunc();
    
    int type() {return CAL_FUNC_NAME;}
};

class CPowerFunc : public CFunction {
public:
    CFunction* base;
    CFunction* power;
    
    CPowerFunc(CFunction* base, CFunction* power);
    ~CPowerFunc();
    
    int type() {return CAL_FUNC_POWER;}
};

class CConstant : public CFunction {

};

class CNumConstant : public CConstant {
public:
    int value;
    
    CNumConstant(int val);
    ~CNumConstant();
    
    int type() {return CAL_CON_NUM;}
};

typedef enum _ConstantType {
    CT_E, CT_PI
} ConstantType;

class CSpecialConstant : public CConstant {
public:
    ConstantType consType;
    
    CSpecialConstant(ConstantType type);
    ~CSpecialConstant();
    
    int type() {return CAL_CON_SPEC;}
};

#endif /* defined(__IDCalculator__CalModel__) */
