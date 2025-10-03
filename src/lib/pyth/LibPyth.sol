// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {IPyth} from "pyth-sdk/IPyth.sol";
import {PythStructs} from "pyth-sdk/PythStructs.sol";
import {LibDecimalFloat} from "rain.math.float/lib/LibDecimalFloat.sol";
import {IntOrAString} from "rain.intorastring/lib/LibIntOrAString.sol";

error UnsupportedChainId();

error UnsupportedFeedSymbol();

/// Chain IDs from https://chainlist.org/
/// Price feed contract addresses from https://docs.pyth.network/price-feeds/contract-addresses/evm
library LibPyth {
    uint256 constant CHAIN_ID_ARBITRUM = 42161;
    uint256 constant CHAIN_ID_BASE = 8453;

    IPyth constant PRICE_FEED_CONTRACT_ARBITRUM = IPyth(0xff1a0f4744e8582DF1aE09D5611b887B6a12925C);
    IPyth constant PRICE_FEED_CONTRACT_BASE = IPyth(0x8250f4aF4B972684F7b336503E2D6dFeDeB1487a);

    /// Magnificent 7 share price feed IDs.
    /// Google.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_GOOG_USD =
        0xe65ff435be42630439c96396653a342829e877e2aafaeaf1a10d0ee5fd2cf3f2;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GOOG_USD =
        0x924571756974792e55532e474f4f472f55534400000000000000000000000000;
    /// Amazon.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_AMZN_USD =
        0xb5d0e0fa58a1f8b81498ae670ce93c872d14434b72c364885d4fa1b257cbb07a;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AMZN_USD =
        0x924571756974792e55532e414d5a4e2f55534400000000000000000000000000;
    /// Apple.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_AAPL_USD =
        0x49f6b65cb1de6b10eaf75e7c03ca029c306d0357e91b5311b175084a5ad55688;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AAPL_USD =
        0x924571756974792e55532e4141504c2f55534400000000000000000000000000;
    /// Microsoft.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_MSFT_USD =
        0xd0ca23c1cc005e004ccf1db5bf76aeb6a49218f43dac3d4b275e92de12ded4d1;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSFT_USD =
        0x924571756974792e55532e4d5346542f55534400000000000000000000000000;
    /// Tesla.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_TSLA_USD =
        0x16dad506d7db8da01c87581c87ca897a012a153557d4d578c3b9c9e1bc0632f1;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_TSLA_USD =
        0x924571756974792e55532e54534c412f55534400000000000000000000000000;
    /// Nvidia.
    bytes32 constant PRICE_FEED_ID_EQUITY_US_NVDA_USD =
        0xb1073854ed24cbc755dc527418f52b7d271f6cc967bbf8d8129112b18860a593;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_NVDA_USD =
        0x924571756974792e55532e4e5644412f55534400000000000000000000000000;
    /// Meta Platforms (Facebook).
    bytes32 constant PRICE_FEED_ID_EQUITY_US_META_USD =
        0x78a3e3b8e676a8f73c439f5d749737034b139bbbe899ba5775216fba596607fe;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_META_USD =
        0x924571756974792e55532e4d4554412f55534400000000000000000000000000;
    /// Gamestop
    bytes32 constant PRICE_FEED_ID_EQUITY_US_GME_USD =
        0x6f9cd89ef1b7fd39f667101a91ad578b6c6ace4579d5f7f285a4b06aa4504be6;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GME_USD =
        0x914571756974792e55532e474d452f5553440000000000000000000000000000;
    /// MSTR
    bytes32 constant PRICE_FEED_ID_EQUITY_US_MSTR_USD =
        0xe1e80251e5f5184f2195008382538e847fafc36f751896889dd3d1b1f6111f09;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSTR_USD =
        0x924571756974792e55532e4d5354522f55534400000000000000000000000000;
    /// BRK_B
    bytes32 constant PRICE_FEED_ID_EQUITY_US_BRK_B_USD =
        0xe21c688b7fc65b4606a50f3635f466f6986db129bf16979875d160f9c508e8c7;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_BRK_B_USD =
        0x934571756974792e55532e42524b2d422f555344000000000000000000000000;
    /// SPLG
    bytes32 constant PRICE_FEED_ID_EQUITY_US_SPLG_USD =
        0x4dfbf28d72ab41a878afcd4c6d5e9593dca7cf65a0da739cbad9b7414004f82d;
    // slither-disable-next-line too-many-digits
    uint256 constant PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_SPLG_USD =
        0x924571756974792e55532e53504c472f55534400000000000000000000000000;

    /// TODO replace with O(1) lookup table.
    function getPriceFeedContract(uint256 chainId) internal pure returns (IPyth) {
        if (chainId == CHAIN_ID_ARBITRUM) {
            return PRICE_FEED_CONTRACT_ARBITRUM;
        } else if (chainId == CHAIN_ID_BASE) {
            return PRICE_FEED_CONTRACT_BASE;
        } else {
            revert UnsupportedChainId();
        }
    }

    /// TODO replace with O(1) lookup table.
    function getPriceFeedId(IntOrAString feedSymbolIntOrAString) internal pure returns (bytes32) {
        uint256 feedSymbol = IntOrAString.unwrap(feedSymbolIntOrAString);
        if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GOOG_USD) {
            return PRICE_FEED_ID_EQUITY_US_GOOG_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AMZN_USD) {
            return PRICE_FEED_ID_EQUITY_US_AMZN_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_AAPL_USD) {
            return PRICE_FEED_ID_EQUITY_US_AAPL_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSFT_USD) {
            return PRICE_FEED_ID_EQUITY_US_MSFT_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_TSLA_USD) {
            return PRICE_FEED_ID_EQUITY_US_TSLA_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_NVDA_USD) {
            return PRICE_FEED_ID_EQUITY_US_NVDA_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_META_USD) {
            return PRICE_FEED_ID_EQUITY_US_META_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_GME_USD) {
            return PRICE_FEED_ID_EQUITY_US_GME_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_MSTR_USD) {
            return PRICE_FEED_ID_EQUITY_US_MSTR_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_BRK_B_USD) {
            return PRICE_FEED_ID_EQUITY_US_BRK_B_USD;
        } else if (feedSymbol == PRICE_FEED_SYMBOL_INTORASTRING_EQUITY_US_SPLG_USD) {
            return PRICE_FEED_ID_EQUITY_US_SPLG_USD;
        } else {
            revert UnsupportedFeedSymbol();
        }
    }

    function getPriceNoOlderThan(IntOrAString feedSymbol, uint256 staleAfter) internal view returns (uint256) {
        bytes32 feedId = getPriceFeedId(feedSymbol);
        IPyth priceFeedContract = getPriceFeedContract(block.chainid);

        PythStructs.Price memory priceData = priceFeedContract.getPriceNoOlderThan(feedId, staleAfter);

        return LibDecimalFloat.toFixedDecimalLossless(priceData.price, priceData.expo, 18);
    }
}
