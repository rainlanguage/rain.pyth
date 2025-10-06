// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibOpPythPrice, OperandV2} from "src/lib/op/LibOpPythPrice.sol";
import {LibIntOrAString, IntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM} from "test/lib/LibFork.sol";

contract LibOpPythPriceTest is Test {
    function testIntegrity(OperandV2 operand, uint256 inputs, uint256 outputs) external pure {
        (uint256 calculatedInputs, uint256 calculatedOutputs) = LibOpPythPrice.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, 2);
        assertEq(calculatedOutputs, 1);
    }

    function testRunForkCurrentPriceHappy() external {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);

        uint256[] memory inputs = new uint256[](2);
        inputs[0] = IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.GOOG/USD"));
        inputs[1] = 72 hours;

        uint256[] memory outputs = LibOpPythPrice.run(OperandV2.wrap(0), inputs);
        assertEq(outputs.length, 1);
        assertEq(outputs[0], 172.3176e18);
    }
}
