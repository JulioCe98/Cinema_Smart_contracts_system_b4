// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

error NoOwnerError();

contract CinemaToken is ERC20 {
    address public cinemaAddress;
    uint minted;

    event mintedTokensEvent(address to_, uint amount_);

    modifier isOwner() {
        if (msg.sender != cinemaAddress) revert NoOwnerError();
        _;
    }

    constructor(
        string memory tokenName_,
        string memory tokenSymbol_
    ) ERC20(tokenName_, tokenSymbol_) {}

    function loadGas() public payable {}

    function setCinemaAddress(address cinemaAddress_) public {
        require(cinemaAddress == address(0), "Cinema address already set");
        cinemaAddress = cinemaAddress_;
    }

    function mintTokens(address to_, uint amount_) public isOwner {
        _mint(to_, amount_);
        minted += amount_;
        emit mintedTokensEvent(to_, amount_);
    }
}
