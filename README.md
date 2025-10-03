# rain.pyth

## Test proofs

The test proofs are generated in JS using the Open Zeppelin example script verbatim.

The OZ scripts can be found in the README at:

https://github.com/OpenZeppelin/merkle-tree/tree/98ff55dc7b6004a6e57ca0cb256cc0d08ecb6096

This linked commit is HEAD as of time of writing.

The proofs build deterministically and so are included in the `rain-merkle-prelude` nix task, and are committed to the repo.

The outputs are copied to Solidity constants in `test/proof/LibTestProof.sol`.