// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import "./interfaces/iCinemaToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error TransactionFailed(uint weiAmount);

contract CinemaContract is Ownable {
    address public cinemaVaultAddress;
    address public cinemaTokenAddress;
    uint public cinemaTokensConversionRate;

    constructor(
        address cinemaVaultAddress_,
        address cinemaTokenAddress_
    ) Ownable(msg.sender) {
        cinemaVaultAddress = cinemaVaultAddress_;
        cinemaTokenAddress = cinemaTokenAddress_;
        cinemaTokensConversionRate = 1;
    }

    function loadGas() public payable {}

    function buyCinemaTokens() public payable {
        //Send wei to Cinema Vault
        (bool transactionResult, ) = cinemaVaultAddress.call{value: msg.value}(
            abi.encodeWithSignature("depositEther()")
        );
        //with custom errors
        if (!transactionResult) revert TransactionFailed(msg.value);
        //with require
        //require(transactionResult, "Error sending wei to cinemaVaultAddress");

        //Mint Cinema tokens and send it to the user
        uint tokenAmount = msg.value * cinemaTokensConversionRate;
        iCinemaToken(cinemaTokenAddress).mintTokens(msg.sender, tokenAmount);
    }

    function setCinemaTokensConversionRate(uint newRate_) public onlyOwner {
        cinemaTokensConversionRate = newRate_;
    }
}
