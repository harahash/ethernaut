// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract Fallback {
    using SafeMath for uint256;
    mapping(address => uint256) public contributions;
    address payable public owner;

    constructor() public {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}

//
// i:  await contract.abi
// o:
//
// i: await contract.contribute({ value: 1})
// o: Sent transaction / Mined transaction
//
// i: await contract.getContribution()
// o: # now your address is in a contributors list
//
// i: await contract.sendTransaction({ value: 1})
// o: # now your address is an owner of contract
//
// i: await contract.owner()
// o: # your address
//
// i: await contract.withdraw()
// o: Sent transaction / Mined transaction
//
