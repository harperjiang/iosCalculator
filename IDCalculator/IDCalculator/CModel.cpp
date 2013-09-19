//
//  CExpression.cpp
//  IDCalculator
//
//  Created by Harper Jiang on 11/23/12.
//  Copyright (c) 2012 Harper Jiang. All rights reserved.
//

#include "CModel.h"

int CCommand::type() {
    return 0;
}

int CClearCommand::type() {
    return CLEAR_COMMAND;
}

int CVarCommand::type() {
    return VAR_COMMAND;
}

int CAssignCommand::type() {
    return ASSIGN_COMMAND;
}

int CPlotFuncCommand::type() {
    return PLOTFUNC_COMMAND;
}

int CPlotRemoveCommand::type() {
    return PLOTREM_COMMAND;
}