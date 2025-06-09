// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {PythWords} from "src/concrete/PythWords.sol";
import {LibFs} from "rain.sol.codegen/lib/LibFs.sol";

contract BuildPointers is Script {
    function buildPythWordsPointers() internal {
        PythWords pythWords = new PythWords();

        string memory name = "PythWords";

        LibFs.buildFileForContract(vm, address(pythWords), name, "");
    }

    function run() external {
        buildPythWordsPointers();
    }
}
