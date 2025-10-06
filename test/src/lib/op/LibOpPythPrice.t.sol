// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibOpPythPrice, OperandV2, StackItem} from "src/lib/op/LibOpPythPrice.sol";
import {LibIntOrAString, IntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM} from "test/lib/LibFork.sol";
import {Float, LibDecimalFloat} from "rain.math.float/lib/LibDecimalFloat.sol";

contract LibOpPythPriceTest is Test {
    function testIntegrity(OperandV2 operand, uint256 inputs, uint256 outputs) external pure {
        (uint256 calculatedInputs, uint256 calculatedOutputs) = LibOpPythPrice.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, 2);
        assertEq(calculatedOutputs, 1);
    }

    function testRunForkCurrentPriceHappy() external {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);

        StackItem[] memory inputs = new StackItem[](2);
        inputs[0] = StackItem.wrap(bytes32(IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.GOOG/USD"))));
        inputs[1] = StackItem.wrap(Float.unwrap(LibDecimalFloat.packLossless(72 hours, 0)));

        StackItem[] memory outputs = LibOpPythPrice.run(OperandV2.wrap(0), inputs);
        assertEq(outputs.length, 1);
        assertEq(StackItem.unwrap(outputs[0]), Float.unwrap(LibDecimalFloat.packLossless(172.3176e5, -5)));
    }
}
