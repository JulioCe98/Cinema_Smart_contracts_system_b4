// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

interface iCinemaToken {
    function setCinemaAddress(address cinemaAddress_) external;

    function mintTokens(address to, uint amount) external;
}
