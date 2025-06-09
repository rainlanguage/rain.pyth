// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {PythExtern} from "../abstract/PythExtern.sol";
import {OPCODE_FUNCTION_POINTERS, INTEGRITY_FUNCTION_POINTERS} from "../generated/PythWords.pointers.sol";

contract PythWords is PythExtern {
    function opcodeFunctionPointers() internal pure override returns (bytes memory) {
        return OPCODE_FUNCTION_POINTERS;
    }

    function integrityFunctionPointers() internal pure override returns (bytes memory) {
        return INTEGRITY_FUNCTION_POINTERS;
    }
}
