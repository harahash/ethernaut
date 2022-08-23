// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Instance {
    string public password;
    uint8 public infoNum = 42;
    string public theMethodName = "The method name is method7123949.";
    bool private cleared = false;

    // constructor
    constructor(string memory _password) public {
        password = _password;
    }

    function info() public pure returns (string memory) {
        return "You will find what you need in info1().";
    }

    function info1() public pure returns (string memory) {
        return 'Try info2(), but with "hello" as a parameter.';
    }

    function info2(string memory param) public pure returns (string memory) {
        if (
            keccak256(abi.encodePacked(param)) ==
            keccak256(abi.encodePacked("hello"))
        ) {
            return
                "The property infoNum holds the number of the next info method to call.";
        }
        return "Wrong parameter.";
    }

    function info42() public pure returns (string memory) {
        return "theMethodName is the name of the next method.";
    }

    function method7123949() public pure returns (string memory) {
        return "If you know the password, submit it to authenticate().";
    }

    function authenticate(string memory passkey) public {
        if (
            keccak256(abi.encodePacked(passkey)) ==
            keccak256(abi.encodePacked(password))
        ) {
            cleared = true;
        }
    }

    function getCleared() public view returns (bool) {
        return cleared;
    }
}

//
// input: await contract.info()
// output: 'You will find what you need in info1().'
//
// i: await contract.info1()
// o: 'Try info2(), but with "hello" as a parameter.'
//
// i: await contract.info2("hello")
// o: 'The property infoNum holds the number of the next info method to call.'
//
// i: await contract.infoNum()
// o: words: Array(2) 0: 42 length: 2
//
// i: await contract.info42()
// o: 'theMethodName is the name of the next method.'
//
// i: await contract.theMethodName()
// o: 'The method name is method7123949.'
//
// i: await contract.method7123949()
// o: 'If you know the password, submit it to authenticate().'
//
// i: await contract.abi
// o:
//
// i: await contract.password()
// o: 'ethernaut0'
//
// i: await contract.authenticate('ethernaut0')
// o: Sent transaction / Mined transaction
//
// i: contract.getCleared()
// o: true
//
