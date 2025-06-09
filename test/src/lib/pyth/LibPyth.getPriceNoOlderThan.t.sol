// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibPyth} from "src/lib/pyth/LibPyth.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_RPC_URL_BASE, FORK_BLOCK_ARBITRUM, FORK_BLOCK_BASE} from "test/lib/LibFork.sol";

contract LibPythGetPriceNoOlderThanTest is Test {
    function getPriceNoOlderThanExternal(string memory symbol, uint256 maxAge) external view returns (uint256) {
        return LibPyth.getPriceNoOlderThan(symbol, maxAge);
    }

    function checkPriceNoOlderThan(string memory symbol, uint256 maxAge, uint256 expectedPrice) internal view {
        assertEq(LibPyth.getPriceNoOlderThan(symbol, maxAge), expectedPrice);
    }

    function testPriceNoOlderThanArbitrum() external {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);
        checkPriceNoOlderThan("Equity.US.GOOG/USD", 72 hours, 172.3176e18);
        checkPriceNoOlderThan("Equity.US.AMZN/USD", 500 hours, 205.06198e18);
        checkPriceNoOlderThan("Equity.US.AAPL/USD", 72 hours, 202.86002e18);
        checkPriceNoOlderThan("Equity.US.MSFT/USD", 72 hours, 469.8035e18);
        checkPriceNoOlderThan("Equity.US.TSLA/USD", 300 hours, 360.02978e18);
        checkPriceNoOlderThan("Equity.US.NVDA/USD", 1000 hours, 104.5623e18);
        checkPriceNoOlderThan("Equity.US.META/USD", 8000 hours, 448.73e18);
        vm.createSelectFork(FORK_RPC_URL_BASE, FORK_BLOCK_BASE);
        checkPriceNoOlderThan("Equity.US.GOOG/USD", 72 hours, 174.93179e18);
        checkPriceNoOlderThan("Equity.US.AMZN/USD", 500 hours, 207.372e18);
        checkPriceNoOlderThan("Equity.US.AAPL/USD", 72 hours, 205.12e18);
        checkPriceNoOlderThan("Equity.US.MSFT/USD", 300 hours, 458.35309e18);
        checkPriceNoOlderThan("Equity.US.TSLA/USD", 72 hours, 301.47341e18);
        checkPriceNoOlderThan("Equity.US.NVDA/USD", 72 hours, 141.66994e18);
        checkPriceNoOlderThan("Equity.US.META/USD", 72 hours, 693.349e18);
    }
}
