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

        StackItem[] memory expectedStack = new StackItem[](2);
        expectedStack[0] = StackItem.wrap(Float.unwrap(LibDecimalFloat.packLossless(2.00302e5, -5)));
        expectedStack[1] = StackItem.wrap(Float.unwrap(LibDecimalFloat.packLossless(172.3176e5, -5)));

        checkHappy(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(pythWords).toHexString(),
                    "price confidence: pyth-price(\"Equity.US.GOOG/USD\" 1080000),",
                    ":ensure(equal-to(price 172.3176) \"bad price\"),",
                    ":ensure(equal-to(confidence 2.00302) \"bad confidence\");"
                )
            ),
            expectedStack,
            "pyth-price(\"Equity.US.GOOG/USD\" 1080000)"
        );
    }
}
