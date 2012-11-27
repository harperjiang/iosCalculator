//
//  CExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#ifndef __IDCalculator__CModel__
#define __IDCalculator__CModel__

#include <vector>
#include "Operator.h"

typedef enum _CModelType {
    ASSIGN_COMMAND = 100,
    CLEAR_COMMAND,
    VAR_COMMAND,
    CMD_EXP,
    
    EXP_LIST = 200,
    EXP_ARITH,
    EXP_ID,
    EXP_FUNC,
    
    CONST_MATRIX = 300,
    CONST_NUM,
    CONST_FRAC
} CModelType;

class CExpression {
public:
    virtual int type() = 0;
    virtual ~CExpression(){};
};

class CArithExpression : public CExpression {
public:
    CExpression* left;
    Operator opr;
    CExpression* right;
    
    CArithExpression(CExpression* left, Operator o, CExpression* right) {
        this->left = left;
        this->opr = o;
        this->right = right;
    }
    
    int type() {
        return EXP_ARITH;
    }
    ~CArithExpression() {
        if (left != NULL)
            delete left;
        if(right != NULL)
            delete right;
    }
};

class CIdentifier : public CExpression {
public:
    char* name;
    
    CIdentifier(char* input) {
        name = new char[strlen(input)];
        strcpy(name, input);
    }
    int type() {
        return EXP_ID;
    }
    
    ~CIdentifier() {
        delete name;
    }
};

class CExpList : public CExpression {
public:
    std::vector<CExpression*>* list;
    
    CExpList() {
        list = new std::vector<CExpression*>();
    }
    
    void add(CExpression* exp) {
        list->push_back(exp);
    }
    
    void insert(int index,CExpression* exp) {
        list->insert(list->begin()+index, exp);
    }
    int size() {
        return list->size();
    }
    
    CExpression* get(int index) {
        return list->at(index);
    }
    
    int type() {
        return EXP_LIST;
    }
    
    ~CExpList() {
        delete list;
    }
};


class CFuncExpression : public CExpression {
    
public:
    CIdentifier* name;
    CExpList* params;
    
    CFuncExpression(CIdentifier* id, CExpList* list) {
        this->name = id;
        this->params = list;
    }
    
    int type() {
        return EXP_FUNC;
    }
    
    ~CFuncExpression() {
        delete name;
        delete params;
    }
};



class CData : public CExpression {
public:
    virtual ~CData(){}
};

class CMatrix :public CData {
public:
    CExpList* content;
    
    CMatrix() {}
    
    int type() {
        return CONST_MATRIX;
    }
    
    ~CMatrix() {
        if(content != 0)
            delete content;
    }
};

class CNumData : public CData {
public:
    int value;
    
    CNumData(int val) {
        this->value = val;
    }
    int type() {
        return CONST_NUM;
    }

    ~CNumData() {}
};

class CFracData : public CData {
public:
    int numerator;
    int denominator;
    int type() {
        return CONST_FRAC;
    }
    CFracData(int n,int d) {
        this->numerator = n;
        this->denominator = d;
    }
    
    ~CFracData() {}
};


class CCommand {
    
public:
    virtual int type() = 0;
    virtual ~CCommand() {}
};

class CAssignCommand : public CCommand {
public:
    CIdentifier* id;
    CExpression* value;
    
    CAssignCommand(CIdentifier* id, CExpression* value) {
        this->id = id;
        this->value = value;
    }
    
    int type();
    
    ~CAssignCommand() {
        delete id;
        if(value!=0)
            delete value;
    }
};

class CClearCommand : public CCommand {
public:
    int type();
};

class CExpCommand : public CCommand {
public:
    CExpression* exp;
    
    CExpCommand(CExpression* exp) {
        this->exp = exp;
    }
    
    int type() {
        return CMD_EXP;
    }
    
    ~CExpCommand() {
        delete exp;
    }
};

class CVarCommand : public CCommand {
public:
    CIdentifier* id;
    
    CVarCommand(CIdentifier* id) {
        this->id = id;
    }
    
    int type();
    
    ~CVarCommand() {
        delete id;
    }
};


#endif /* defined(__IDCalculator__CModel__) */
