// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {OpTest, StackItem} from "rain.interpreter/../test/abstract/OpTest.sol";
import {PythWords} from "src/concrete/PythWords.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM} from "test/lib/LibFork.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";
import {LibPyth} from "src/lib/pyth/LibPyth.sol";
import {LibDecimalFloat, Float} from "rain.math.float/lib/LibDecimalFloat.sol";

contract PythWordsPythPriceTest is OpTest {
    using Strings for address;

    function beforeOpTestConstructor() internal override {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);
    }

    function testPythWordsPythPriceHappy() external {
        vm.chainId(LibPyth.CHAIN_ID_ARBITRUM);

        PythWords pythWords = new PythWords();

        StackItem[] memory expectedStack = new StackItem[](1);
        expectedStack[0] = StackItem.wrap(Float.unwrap(LibDecimalFloat.packLossless(172.3176e5, -5)));

        checkHappy(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(pythWords).toHexString(),
                    " _: pyth-price(\"Equity.US.GOOG/USD\" 1080000);"
                )
            ),
            expectedStack,
            "pyth-price(\"Equity.US.GOOG/USD\" 1080000)"
        );
    }
}
