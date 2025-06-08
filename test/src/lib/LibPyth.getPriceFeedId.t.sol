// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibPyth, UnsupportedFeedSymbol} from "src/lib/LibPyth.sol";

contract LibPythGetPriceFeedIdTest is Test {
    function getPriceFeedIdExternal(string memory symbol) external pure returns (bytes32) {
        return LibPyth.getPriceFeedId(symbol);
    }

    function testPriceFeedIdKnownMappings() external pure {
        // Test known price feed IDs.
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_GOOG_USD, LibPyth.getPriceFeedId("Equity.US.GOOG/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_AMZN_USD, LibPyth.getPriceFeedId("Equity.US.AMZN/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_AAPL_USD, LibPyth.getPriceFeedId("Equity.US.AAPL/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_MSFT_USD, LibPyth.getPriceFeedId("Equity.US.MSFT/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_TSLA_USD, LibPyth.getPriceFeedId("Equity.US.TSLA/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_NVDA_USD, LibPyth.getPriceFeedId("Equity.US.NVDA/USD"));
        assertEq(LibPyth.PRICE_FEED_ID_EQUITY_US_META_USD, LibPyth.getPriceFeedId("Equity.US.META/USD"));
    }

    function testPriceFeedIdUnknownMappings(string memory symbol) external {
        vm.expectRevert(UnsupportedFeedSymbol.selector);
        this.getPriceFeedIdExternal(symbol);
    }
}
