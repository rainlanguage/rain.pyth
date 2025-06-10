// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibIntorastring} from "rain.intorastring/lib/LibIntOrAString.sol";
import {LibPyth} from "src/lib/pyth/LibPyth.sol";

contract LibPythConstantsTest is Test {
    function testChainIdConstants() external {
        assertEq(LibPyth.CHAIN_ID_ARBITRUM, 42161);
        assertEq(LibPyth.CHAIN_ID_BASE, 8453);
    }

    function testIntorastringConstants() external {
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GOOG_USD, LibIntorastring.toString2("Equity.US.GOOG/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AMZN_USD, LibIntOrAString.toString2("Equity.US.AMZN/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AAPL_USD, LibIntOrAString.toString2("Equity.US.AAPL/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSFT_USD, LibIntOrAString.toString2("Equity.US.MSFT/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_TSLA_USD, LibIntOrAString.toString2("Equity.US.TSLA/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_NVDA_USD, LibIntOrAString.toString2("Equity.US.NVDA/USD"));
        assertEq(LibPyth.PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_META_USD, LibIntOrAString.toString2("Equity.US.META/USD"));
    }
}