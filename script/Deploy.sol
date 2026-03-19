// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {PythWords} from "../src/concrete/PythWords.sol";
import {IMetaBoardV1_2} from "rain.metadata/interface/unstable/IMetaBoardV1_2.sol";
import {LibDescribedByMeta} from "rain.metadata/lib/LibDescribedByMeta.sol";

/// @dev MetaBoard is deterministically deployed via Zoltu CREATE2 deployer
/// at the same address on every chain.
address constant METABOARD_ADDRESS = address(0xfb8437AeFBB8031064E274527C5fc08e30Ac6928);

contract Deploy is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        bytes memory subParserDescribedByMeta = vm.readFileBinary("meta/PythWords.rain.meta");
        IMetaBoardV1_2 metaboard = IMetaBoardV1_2(METABOARD_ADDRESS);

        vm.startBroadcast(deployerPrivateKey);
        PythWords subParser = new PythWords();
        LibDescribedByMeta.emitForDescribedAddress(metaboard, subParser, subParserDescribedByMeta);

        vm.stopBroadcast();
    }
}
