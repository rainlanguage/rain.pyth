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
            LibPyth.PRICE_FEED_ID_CRYPTO_ARB_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.ARB/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_BTC_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.BTC/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_WBTC_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.WBTC/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_CBBTC_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.CBBTC/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_DOT_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.DOT/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_ENA_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.ENA/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_ETH_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.ETH/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_WETH_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.WETH/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_WSTETH_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.WSTETH/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_LINK_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.LINK/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_PEPE_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.PEPE/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_PYTH_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.PYTH/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_UNI_USD, LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.UNI/USD"))
        );
        assertEq(
            LibPyth.PRICE_FEED_ID_CRYPTO_XAUT_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Crypto.XAUT/USD"))
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
        assertEq(
            LibPyth.PRICE_FEED_ID_EQUITY_US_IAU_USD,
            LibPyth.getPriceFeedId(LibIntOrAString.fromString2("Equity.US.IAU/USD"))
        );
    }

    function testPriceFeedIdUnknownMappings(IntOrAString symbol) external {
        vm.assume(
            IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.ARB/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.BTC/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.WBTC/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.CBBTC/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.DOT/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.ENA/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.ETH/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.WETH/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.WSTETH/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.LINK/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.PEPE/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.PYTH/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.UNI/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.XAUT/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Crypto.XRP/USD"))
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.GOOG/USD"))
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
                && IntOrAString.unwrap(symbol) != IntOrAString.unwrap(LibIntOrAString.fromString2("Equity.US.IAU/USD"))
        );
        vm.expectRevert(UnsupportedFeedSymbol.selector);
        this.getPriceFeedIdExternal(symbol);
    }
}
