// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibPyth, UnsupportedFeedSymbol} from "src/lib/pyth/LibPyth.sol";
import {IntOrAString, LibIntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";

contract LibPythGetPriceFeedIdTest is Test {
    function getPriceFeedIdExternal(IntOrAString symbol) external pure returns (bytes32) {
        return LibPyth.getPriceFeedId(symbol);
    }

    function testPriceFeedIdKnownMappings() external pure {
        // Test known price feed IDs.
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_BTC_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.BTC/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_ETH_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.ETH/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_XRP_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.XRP/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_GOOG_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.GOOG/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_AMZN_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.AMZN/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_AAPL_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.AAPL/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_MSFT_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.MSFT/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_TSLA_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.TSLA/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_NVDA_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.NVDA/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_META_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.META/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_GME_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.GME/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_MSTR_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.MSTR/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_BRK_B_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.BRK-B/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_SPLG_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.SPLG/USD"))
        );
    }

    function testPriceFeedIdUnknownMappings(IntOrAString symbol) external {
        vm.assume(
            IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.GOOG/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.AMZN/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.AAPL/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.MSFT/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.TSLA/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.NVDA/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.META/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.GME/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.MSTR/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.BRK-B/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.SPLG/USD"))
        );
        vm.expectRevert(UnsupportedFeedSymbol.selector);
        this.getPriceFeedIdExternal(symbol);
    }
}
