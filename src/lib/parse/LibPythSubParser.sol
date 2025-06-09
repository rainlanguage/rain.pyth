// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {AuthoringMetaV2} from "rain.interpreter.interface/interface/deprecated/IParserV1.sol";

uint256 constant SUB_PARSER_WORD_PYTH_PRICE = 0;

uint256 constant SUB_PARSER_WORD_PARSERS_LENGTH = 1;

library LibPythSubParser {
    function authoringMetaV2() internal pure returns (bytes memory) {
        AuthoringMetaV2[] memory meta = new AuthoringMetaV2[](SUB_PARSER_WORD_PARSERS_LENGTH);

        meta[SUB_PARSER_WORD_PYTH_PRICE] = AuthoringMetaV2(
            "pyth-price",
            "Returns the current price of the given asset according to Pyth. Accepts 2 inputs, the price symbol and the timeout in seconds. The price will error if there are rounding errors. The timeout will be used to determine if the price is stale and revert if it is."
        );
        return abi.encode(meta);
    }
}
