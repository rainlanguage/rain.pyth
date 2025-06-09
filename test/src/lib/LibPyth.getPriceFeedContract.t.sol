// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibPyth, UnsupportedChainId} from "src/lib/pyth/LibPyth.sol";

contract LibPythGetPriceFeedContractTest is Test {
    function getPriceFeedContractExternal(uint256 chainId) external pure returns (address) {
        return address(LibPyth.getPriceFeedContract(chainId));
    }

    function testGetPriceFeedContractArbitrum() external pure {
        assertEq(
            address(LibPyth.PRICE_FEED_CONTRACT_ARBITRUM),
            address(LibPyth.getPriceFeedContract(LibPyth.CHAIN_ID_ARBITRUM))
        );
    }

    function testGetPriceFeedContractBase() external pure {
        assertEq(
            address(LibPyth.PRICE_FEED_CONTRACT_BASE), address(LibPyth.getPriceFeedContract(LibPyth.CHAIN_ID_BASE))
        );
    }

    function testGetPriceFeedContractUnsupportedChainId(uint256 chainId) external {
        vm.assume(chainId != LibPyth.CHAIN_ID_ARBITRUM && chainId != LibPyth.CHAIN_ID_BASE);
        vm.expectRevert(UnsupportedChainId.selector);
        this.getPriceFeedContractExternal(chainId);
    }
}
