// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibPyth} from "src/lib/pyth/LibPyth.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_RPC_URL_BASE, FORK_BLOCK_ARBITRUM, FORK_BLOCK_BASE} from "test/lib/LibFork.sol";
import {IntOrAString, LibIntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";

contract LibPythGetPriceNoOlderThanTest is Test {
    using LibIntOrAString for string;

    function getPriceNoOlderThanExternal(IntOrAString symbol, uint256 maxAge) external view returns (uint256) {
        return LibPyth.getPriceNoOlderThan(symbol, maxAge);
    }

    function checkPriceNoOlderThan(IntOrAString symbol, uint256 maxAge, uint256 expectedPrice) internal view {
        assertEq(LibPyth.getPriceNoOlderThan(symbol, maxAge), expectedPrice);
    }

    function testPriceNoOlderThanArbitrum() external {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.GOOG/USD"), 72 hours, 172.3176e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.AMZN/USD"), 500 hours, 205.06198e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.AAPL/USD"), 72 hours, 202.86002e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.MSFT/USD"), 72 hours, 469.8035e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.TSLA/USD"), 300 hours, 360.02978e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.NVDA/USD"), 1000 hours, 104.5623e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.META/USD"), 8000 hours, 448.73e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.GME/USD"), 8000 hours, 29.3177e18);
    }

    function testPriceNoOlderThanBase() external {
        vm.createSelectFork(FORK_RPC_URL_BASE, FORK_BLOCK_BASE);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.GOOG/USD"), 24 hours, 246.29352e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.AMZN/USD"), 24 hours, 222.43512e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.AAPL/USD"), 24 hours, 257.33026e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.MSFT/USD"), 24 hours, 515.64431e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.TSLA/USD"), 24 hours, 436.03414e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.NVDA/USD"), 24 hours, 188.92e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.META/USD"), 24 hours, 727.0145e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.GME/USD"), 24 hours, 27.24202e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.MSTR/USD"), 24 hours, 352.34642e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.BRK-B/USD"), 24 hours, 496.12003e18);
        checkPriceNoOlderThan(LibIntOrAString.fromString2("Equity.US.SPLG/USD"), 24 hours, 78.71367e18);
    }
}
