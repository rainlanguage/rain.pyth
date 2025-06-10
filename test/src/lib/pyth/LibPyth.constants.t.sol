// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";

contract LibPythConstantsTest is Test {
    function testConstants() external {
        assertEq(LibPyth.CHAIN_ID_ARBITRUM, 42161);
        assertEq(LibPyth.CHAIN_ID_BASE, 8453);
    }
}