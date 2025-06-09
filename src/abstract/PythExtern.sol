// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {BaseRainterpreterExternNPE2, Operand} from "rain.interpreter/abstract/BaseRainterpreterExternNPE2.sol";

abstract contract PythExtern is BaseRainterpreterExternNPE2 {
    /// @inheritdoc BaseRainterpreterExternNPE2
    function opcodeFunctionPointers() internal pure override returns (bytes memory) {
        return "";
    }

    /// @inheritdoc BaseRainterpreterExternNPE2
    function integrityFunctionPointers() internal pure override returns (bytes memory) {
        return "";
    }

    // This contract is abstract and does not implement any specific functionality.
}