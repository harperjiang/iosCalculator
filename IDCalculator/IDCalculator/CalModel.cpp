//
//  CalModel.cpp
//  IDCalculator
//
//  Created by Harper Jiang on 12/1/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#include "CalModel.h"

CArithFunc::CArithFunc(CFunction* left, Operator opr, CFunction* right) {
    this->left = left;
    this->right = right;
    this->opr = opr;
}

CArithFunc::~CArithFunc() {
    delete this->left;
    delete this->right;
}

CIntFunc::CIntFunc(CFunction* base, CFunction* factor) {
    this->base = base;
    this->factor = factor;
}

CIntFunc::~CIntFunc() {
    delete this->base;
    delete this->factor;
}

CDiffFunc::CDiffFunc(CFunction* base, CFunction* factor) {
    this->base = base;
    this->factor = factor;
}

CDiffFunc::~CDiffFunc() {
    delete this->base;
    delete this->factor;
}

CNameFunc::CNameFunc(FuncName funcName, CFunction* param) {
    this->name = funcName;
    this->param = param;
}

CNameFunc::~CNameFunc() {
    delete this->param;
}

CPowerFunc::CPowerFunc(CFunction* base, CFunction* power) {
    this->base = base;
    this->power = power;
}

CPowerFunc::~CPowerFunc() {
    delete this->base;
    delete this->power;
}

CNumConstant::CNumConstant(int val) {
    this->value = val;
}

CSpecialConstant::CSpecialConstant(ConstantType type) {
    this->type = type;
}
