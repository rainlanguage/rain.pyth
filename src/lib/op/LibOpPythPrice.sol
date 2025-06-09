// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Operand} from "rain.interpreter.interface/interface/deprecated/IInterpreterV2.sol";
import {LibIntOrAString, IntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";
import {LibPyth} from "../pyth/LibPyth.sol";

library LibOpPythPrice {
    using LibIntOrAString for IntOrAString;

    /// Extern integrity for the Pyth price operation.
    /// Always requires 2 inputs and produces 1 output.
    function integrity(Operand, uint256, uint256) internal pure returns (uint256, uint256) {
        return (2, 1);
    }

    /// Runs the Pyth price operation.
    /// @param inputs the inputs to the extern.
    function run(Operand, uint256[] memory inputs) internal view returns (uint256[] memory) {
        IntOrAString symbol;
        uint256 staleAfter;
        assembly ("memory-safe") {
            symbol := mload(add(inputs, 0x20))
            staleAfter := mload(add(inputs, 0x40))
        }

        uint256 price18 = LibPyth.getPriceNoOlderThan(symbol.toString(), staleAfter);

        uint256[] memory outputs;
        assembly ("memory-safe") {
            outputs := mload(0x40)
            mstore(0x40, add(outputs, 0x40))
            mstore(outputs, 1)
            mstore(add(outputs, 0x20), price18)
        }
        return outputs;
    }
}
