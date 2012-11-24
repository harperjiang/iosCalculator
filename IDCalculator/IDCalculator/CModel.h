//
//  CExpression.h
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#ifndef __IDCalculator__CModel__
#define __IDCalculator__CModel__

#include <list>
#include "Operator.h"

typedef enum _CModelType {
    ASSIGN_COMMAND = 100,
    CLEAR_COMMAND,
    VAR_COMMAND,
    
    EXP_LIST = 200,
    EXP_ARITH,
    EXP_ID,
    
    CONST_MATRIX = 300,
    CONST_NUM,
    CONST_FRAC
} CModelType;

class CExpression {
public:
    int type() {
        return 0;
    }
};

class CArithExpression : public CExpression {
public:
    CExpression* left;
    Operator opr;
    CExpression* right;
    
    CArithExpression();
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
    std::list<CExpression*>* list;
    
    CExpList() {
        list = new std::list<CExpression*>();
    }
    
    void add(CExpression* exp) {
        list->push_back(exp);
    }
    
    int type() {
        return EXP_LIST;
    }
    
    ~CExpList() {
        delete list;
    }
};

class CData : public CExpression {
    
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
};


class CCommand {
    
public:
    virtual int type();
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
    
    int type();
    
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
