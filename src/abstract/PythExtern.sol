// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {BaseRainterpreterExternNPE2, Operand} from "rain.interpreter/abstract/BaseRainterpreterExternNPE2.sol";
import {LibOpPythPrice} from "../lib/op/LibOpPythPrice.sol";
import {LibConvert} from "rain.lib.typecast/LibConvert.sol";

uint256 constant OPCODE_PYTH_PRICE = 0;

uint256 constant OPCODE_FUNCTION_POINTERS_LENGTH = 1;

abstract contract PythExtern is BaseRainterpreterExternNPE2 {
    // /// @inheritdoc BaseRainterpreterExternNPE2
    // function opcodeFunctionPointers() internal pure override returns (bytes memory) {
    //     return "";
    // }

    // /// @inheritdoc BaseRainterpreterExternNPE2
    // function integrityFunctionPointers() internal pure override returns (bytes memory) {
    //     return "";
    // }

    function buildOpcodeFunctionPointers() external pure returns (bytes memory) {
        function(Operand, uint256[] memory)
            internal
            view
            returns (uint256[] memory)[] memory fs = new function(Operand, uint256[] memory)
                internal
                view
                returns (uint256[] memory)[](OPCODE_FUNCTION_POINTERS_LENGTH);
        fs[OPCODE_PYTH_PRICE] = LibOpPythPrice.run;

        uint256[] memory pointers;
        assembly ("memory-safe") {
            pointers := fs
        }
        return LibConvert.unsafeTo16BitBytes(pointers);
    }

    function buildIntegrityFunctionPointers() external pure returns (bytes memory) {
        function(Operand, uint256, uint256)
            internal
            pure
            returns (uint256, uint256)[] memory fs = new function(Operand, uint256, uint256)
                internal
                pure
                returns (uint256, uint256)[](OPCODE_FUNCTION_POINTERS_LENGTH);
        fs[OPCODE_PYTH_PRICE] = LibOpPythPrice.integrity;

        uint256[] memory pointers;
        assembly ("memory-safe") {
            pointers := fs
        }
        return LibConvert.unsafeTo16BitBytes(pointers);
    }
}
