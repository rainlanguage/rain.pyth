// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {PythWords} from "src/concrete/PythWords.sol";
import {LibFs} from "rain.sol.codegen/lib/LibFs.sol";
import {LibCodeGen} from "rain.sol.codegen/lib/LibCodeGen.sol";
import {LibGenParseMeta} from "rain.interpreter.interface/lib/codegen/LibGenParseMeta.sol";
import {LibPythSubParser} from "src/lib/parse/LibPythSubParser.sol";
import {PARSE_META_BUILD_DEPTH} from "src/abstract/PythSubParser.sol";

contract BuildPointers is Script {
    function buildPythWordsPointers() internal {
        PythWords pythWords = new PythWords();

        string memory name = "PythWords";

        LibFs.buildFileForContract(
            vm,
            address(pythWords),
            name,
            string.concat(
                LibCodeGen.describedByMetaHashConstantString(vm, name),
                LibGenParseMeta.parseMetaConstantString(
                    vm, LibPythSubParser.authoringMetaV2(), PARSE_META_BUILD_DEPTH
                ),
                LibCodeGen.subParserWordParsersConstantString(vm, pythWords),
                LibCodeGen.operandHandlerFunctionPointersConstantString(vm, pythWords),
                LibCodeGen.integrityFunctionPointersConstantString(vm, pythWords),
                LibCodeGen.opcodeFunctionPointersConstantString(vm, pythWords)
            )
        );
    }

    function run() external {
        buildPythWordsPointers();
    }
}
