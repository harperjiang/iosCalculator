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

class CFunction {
    
};

class CVariable : public CFunction {

};

class CArithFunc : public CFunction {
public:
    CFunction* left;
    Operator opr;
    CFunction* right;
    
    CArithFunc(CFunction* left, Operator opr, CFunction* right);
    ~CArithFunc();
};

class CIntFunc : public CFunction {
public:
    CFunction* base;
    CFunction* factor;
    
    CIntFunc(CFunction* base, CFunction* factor);
    ~CIntFunc();
};

class CDiffFunc : public CFunction {
public:
    CFunction* base;
    CFunction* factor;
    
    CDiffFunc(CFunction* base, CFunction* factor);
    ~CDiffFunc();
};

typedef enum _FuncName {
    SIN,COS,LN
} FuncName;

class CNameFunc : public CFunction {
public:
    FuncName name;
    CFunction* param;
    
    CNameFunc(FuncName name, CFunction* param);
    ~CNameFunc();
};

class CPowerFunc : public CFunction {
public:
    CFunction* base;
    CFunction* power;
    
    CPowerFunc(CFunction* base, CFunction* power);
    ~CPowerFunc();
};

class CConstant : public CFunction {
    
};

class CNumConstant : public CConstant {
public:
    int value;
    
    CNumConstant(int val);
    ~CNumConstant();
};

typedef enum _ConstantType {
    CT_E, CT_PI
} ConstantType;

class CSpecialConstant : public CConstant {
public:
    ConstantType type;
    
    CSpecialConstant(ConstantType type);
    ~CSpecialConstant();
};

#endif /* defined(__IDCalculator__CalModel__) */
