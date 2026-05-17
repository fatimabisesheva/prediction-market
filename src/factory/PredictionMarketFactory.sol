// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../market/PredictionMarket.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract PredictionMarketFactory is Ownable {

    address[] public markets;

    event MarketCreated(
        address marketAddress,
        string question
    );

    constructor()
        Ownable(msg.sender)
    {}

    function createMarket(
        address paymentToken,
        string memory question
    )
        external
        onlyOwner
        returns (address)
    {
        PredictionMarket market = new PredictionMarket(
            paymentToken,
            question
        );

        markets.push(address(market));

        emit MarketCreated(
            address(market),
            question
        );

        return address(market);
    }

    function createMarketDeterministic(
        address paymentToken,
        string memory question,
        bytes32 salt
    )
        external
        onlyOwner
        returns (address)
    {
        PredictionMarket market = new PredictionMarket{salt: salt}(
            paymentToken,
            question
        );

        markets.push(address(market));

        emit MarketCreated(
            address(market),
            question
        );

        return address(market);
    }

    function getMarkets()
        external
        view
        returns (address[] memory)
    {
        return markets;
    }
}