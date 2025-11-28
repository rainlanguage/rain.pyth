// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import {LibPyth} from "src/lib/pyth/LibPyth.sol";
import {FORK_RPC_URL_ARBITRUM, FORK_RPC_URL_BASE, FORK_BLOCK_ARBITRUM, FORK_BLOCK_BASE} from "test/lib/LibFork.sol";
import {IntOrAString, LibIntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";
import {Float, LibDecimalFloat} from "rain.math.float/lib/LibDecimalFloat.sol";

contract LibPythGetPriceNoOlderThanTest is Test {
    using LibIntOrAString for string;

    function getPriceNoOlderThanExternal(IntOrAString symbol, Float maxAge) external view returns (Float, Float) {
        return LibPyth.getPriceNoOlderThan(symbol, maxAge);
    }

    function checkPriceNoOlderThan(IntOrAString symbol, Float maxAge, Float expectedPrice, Float expectedConf)
        internal
        view
    {
        (Float actualPrice, Float actualConf) = LibPyth.getPriceNoOlderThan(symbol, maxAge);
        (int256 actualSignedCoefficient, int256 actualExponent) = LibDecimalFloat.unpack(actualPrice);
        console2.logInt(actualSignedCoefficient);
        console2.logInt(actualExponent);
        (actualSignedCoefficient, actualExponent) = LibDecimalFloat.unpack(actualConf);
        console2.logInt(actualSignedCoefficient);
        console2.logInt(actualExponent);
        assertEq(Float.unwrap(actualPrice), Float.unwrap(expectedPrice));
        assertEq(Float.unwrap(actualConf), Float.unwrap(expectedConf));
    }

    function testPriceNoOlderThanArbitrum() external {
        vm.createSelectFork(FORK_RPC_URL_ARBITRUM, FORK_BLOCK_ARBITRUM);
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.ARB/USD"),
            LibDecimalFloat.packLossless(1 days, 0),
            LibDecimalFloat.packLossless(0.28491187e8, -8),
            LibDecimalFloat.packLossless(0.00029951e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.BTC/USD"),
            LibDecimalFloat.packLossless(30 minutes, 0),
            LibDecimalFloat.packLossless(103000.24186427e8, -8),
            LibDecimalFloat.packLossless(52.03163361e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.WBTC/USD"),
            LibDecimalFloat.packLossless(60 minutes, 0),
            LibDecimalFloat.packLossless(103135.4737378e8, -8),
            LibDecimalFloat.packLossless(73.43314845e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.CBBTC/USD"),
            LibDecimalFloat.packLossless(30 minutes, 0),
            LibDecimalFloat.packLossless(103138.439578e8, -8),
            LibDecimalFloat.packLossless(75.2658823e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.DOT/USD"),
            LibDecimalFloat.packLossless(10 days, 0),
            LibDecimalFloat.packLossless(3.23959837e8, -8),
            LibDecimalFloat.packLossless(0.00341749e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.ENA/USD"),
            LibDecimalFloat.packLossless(10 days, 0),
            LibDecimalFloat.packLossless(0.36282387e8, -8),
            LibDecimalFloat.packLossless(0.00033349e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.ETH/USD"),
            LibDecimalFloat.packLossless(30 minutes, 0),
            LibDecimalFloat.packLossless(3455.777e8, -8),
            LibDecimalFloat.packLossless(1.85822327e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.WETH/USD"),
            LibDecimalFloat.packLossless(60 days, 0),
            LibDecimalFloat.packLossless(3474.79067028e8, -8),
            LibDecimalFloat.packLossless(4.96764921e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.WSTETH/USD"),
            LibDecimalFloat.packLossless(60 days, 0),
            LibDecimalFloat.packLossless(4301.42590185e8, -8),
            LibDecimalFloat.packLossless(8.75253083e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.LINK/USD"),
            LibDecimalFloat.packLossless(60 days, 0),
            LibDecimalFloat.packLossless(15.762499e8, -8),
            LibDecimalFloat.packLossless(0.01491013e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.PEPE/USD"),
            LibDecimalFloat.packLossless(10 days, 0),
            LibDecimalFloat.packLossless(0.0000061234e10, -10),
            LibDecimalFloat.packLossless(0.0000000105e10, -10)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.PYTH/USD"),
            LibDecimalFloat.packLossless(2 days, 0),
            LibDecimalFloat.packLossless(0.10425667e8, -8),
            LibDecimalFloat.packLossless(0.0001372e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.UNI/USD"),
            LibDecimalFloat.packLossless(2 days, 0),
            LibDecimalFloat.packLossless(8.66789332e8, -8),
            LibDecimalFloat.packLossless(0.00858892e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.XAUT/USD"),
            LibDecimalFloat.packLossless(500 days, 0),
            LibDecimalFloat.packLossless(2624.06053898e8, -8),
            LibDecimalFloat.packLossless(5.95231113e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Crypto.XRP/USD"),
            LibDecimalFloat.packLossless(2 hours, 0),
            LibDecimalFloat.packLossless(2.41151002e8, -8),
            LibDecimalFloat.packLossless(0.00130317e8, -8)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GOOG/USD"),
            LibDecimalFloat.packLossless(90 days, 0),
            LibDecimalFloat.packLossless(252.91299e5, -5),
            LibDecimalFloat.packLossless(0.17951e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AMZN/USD"),
            LibDecimalFloat.packLossless(100 days, 0),
            LibDecimalFloat.packLossless(227.27075e5, -5),
            LibDecimalFloat.packLossless(2.45325e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AAPL/USD"),
            LibDecimalFloat.packLossless(100 days, 0),
            LibDecimalFloat.packLossless(255.00017e5, -5),
            LibDecimalFloat.packLossless(0.52767e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSFT/USD"),
            LibDecimalFloat.packLossless(100 days, 0),
            LibDecimalFloat.packLossless(522.19838e5, -5),
            LibDecimalFloat.packLossless(0.43069e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.TSLA/USD"),
            LibDecimalFloat.packLossless(100 days, 0),
            LibDecimalFloat.packLossless(315.47837e5, -5),
            LibDecimalFloat.packLossless(0.40855e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.NVDA/USD"),
            LibDecimalFloat.packLossless(100 days, 0),
            LibDecimalFloat.packLossless(181.12249e5, -5),
            LibDecimalFloat.packLossless(0.1829e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.META/USD"),
            LibDecimalFloat.packLossless(500 days, 0),
            LibDecimalFloat.packLossless(448.73e5, -5),
            LibDecimalFloat.packLossless(0.72984e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GME/USD"),
            LibDecimalFloat.packLossless(8000 hours, 0),
            LibDecimalFloat.packLossless(24.84804e5, -5),
            LibDecimalFloat.packLossless(0.03914e5, -5)
        );
    }

    function testPriceNoOlderThanBase() external {
        vm.createSelectFork(FORK_RPC_URL_BASE, FORK_BLOCK_BASE);
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GOOG/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(318.38811e5, -5),
            LibDecimalFloat.packLossless(0.15811e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AMZN/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(231.63004e5, -5),
            LibDecimalFloat.packLossless(0.10225e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AAPL/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(276.46109e5, -5),
            LibDecimalFloat.packLossless(0.13043e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSFT/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(490.64599e5, -5),
            LibDecimalFloat.packLossless(0.24673e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.TSLA/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(428.27611e5, -5),
            LibDecimalFloat.packLossless(0.20025e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.NVDA/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(177.91002e5, -5),
            LibDecimalFloat.packLossless(0.07893e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.META/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(642.47802e5, -5),
            LibDecimalFloat.packLossless(0.34727e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GME/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(22.32067e5, -5),
            LibDecimalFloat.packLossless(0.02648e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSTR/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(183.90070e5, -5),
            LibDecimalFloat.packLossless(0.17456e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.BRK-B/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(515.13507e5, -5),
            LibDecimalFloat.packLossless(0.37249e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.SPLG/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(80.27004e5, -5),
            LibDecimalFloat.packLossless(0.19553e5, -5)
        );

        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.IAU/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(79.08704e5, -5),
            LibDecimalFloat.packLossless(0.04352e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.COIN/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(276.53500e5, -5),
            LibDecimalFloat.packLossless(0.18138e5, -5)
        );
    }
}
