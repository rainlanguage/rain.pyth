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
            LibDecimalFloat.packLossless(246.29352e5, -5),
            LibDecimalFloat.packLossless(0.40327e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AMZN/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(222.43512e5, -5),
            LibDecimalFloat.packLossless(0.10153e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AAPL/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(257.33026e5, -5),
            LibDecimalFloat.packLossless(0.13478e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSFT/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(515.64431e5, -5),
            LibDecimalFloat.packLossless(0.21746e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.TSLA/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(436.03414e5, -5),
            LibDecimalFloat.packLossless(0.28529e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.NVDA/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(188.92e5, -5),
            LibDecimalFloat.packLossless(0.13648e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.META/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(727.0145e5, -5),
            LibDecimalFloat.packLossless(0.40439e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GME/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(27.24202e5, -5),
            LibDecimalFloat.packLossless(0.05212e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSTR/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(352.34642e5, -5),
            LibDecimalFloat.packLossless(0.32048e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.BRK-B/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(496.12003e5, -5),
            LibDecimalFloat.packLossless(0.1009e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.SPLG/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(78.71367e5, -5),
            LibDecimalFloat.packLossless(0.03281e5, -5)
        );

        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.IAU/USD"),
            LibDecimalFloat.packLossless(24 hours, 0),
            LibDecimalFloat.packLossless(71.99028e5, -5),
            LibDecimalFloat.packLossless(0.07147e5, -5)
        );
    }
}
