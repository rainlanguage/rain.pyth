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
            LibIntOrAString.fromString2("Equity.US.GOOG/USD"),
            LibDecimalFloat.packLossless(72 hours, 0),
            LibDecimalFloat.packLossless(172.3176e5, -5),
            LibDecimalFloat.packLossless(2.00302e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AMZN/USD"),
            LibDecimalFloat.packLossless(500 hours, 0),
            LibDecimalFloat.packLossless(205.06198e5, -5),
            LibDecimalFloat.packLossless(0.27188e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.AAPL/USD"),
            LibDecimalFloat.packLossless(72 hours, 0),
            LibDecimalFloat.packLossless(202.86002e5, -5),
            LibDecimalFloat.packLossless(1.91401e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.MSFT/USD"),
            LibDecimalFloat.packLossless(72 hours, 0),
            LibDecimalFloat.packLossless(469.8035e5, -5),
            LibDecimalFloat.packLossless(2.02763e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.TSLA/USD"),
            LibDecimalFloat.packLossless(300 hours, 0),
            LibDecimalFloat.packLossless(360.02978e5, -5),
            LibDecimalFloat.packLossless(0.35259e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.NVDA/USD"),
            LibDecimalFloat.packLossless(1000 hours, 0),
            LibDecimalFloat.packLossless(104.5623e5, -5),
            LibDecimalFloat.packLossless(0.1513e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.META/USD"),
            LibDecimalFloat.packLossless(8000 hours, 0),
            LibDecimalFloat.packLossless(448.73e5, -5),
            LibDecimalFloat.packLossless(0.72984e5, -5)
        );
        checkPriceNoOlderThan(
            LibIntOrAString.fromString2("Equity.US.GME/USD"),
            LibDecimalFloat.packLossless(8000 hours, 0),
            LibDecimalFloat.packLossless(29.3177e5, -5),
            LibDecimalFloat.packLossless(0.26199e5, -5)
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
    }
}
