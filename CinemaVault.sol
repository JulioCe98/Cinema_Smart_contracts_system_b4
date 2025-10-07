// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

error NoOwnerError();

contract CinemaVault {
    struct Person {
        address fromAddress;
        uint amount;
    }

    address public cinemaAddress;
    Person[] public deposits;
    Person[] public withdraws;

    modifier isOwner() {
        if (msg.sender != cinemaAddress) revert NoOwnerError();
        _;
    }

    event depositEvent(address from_, uint amount_);
    event withdrawEvent(address from_, uint amount_);

    function setCinemaAddress(address cinemaAddress_) public {
        require(cinemaAddress == address(0), "Cinema address already set");
        cinemaAddress = cinemaAddress_;
    }

    //Only the owner (Cinema contract) can deposit ether
    function depositEther() public payable isOwner {
        deposits.push(Person(tx.origin, msg.value));
        emit depositEvent(tx.origin, msg.value);
    }

    //Only the owner (Cinema contract) can withdraw ether
    function withdrawEther() public isOwner {
        //todo
    }
}
