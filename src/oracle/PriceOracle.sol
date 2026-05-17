// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./AggregatorV3Interface.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract PriceOracle is Ownable {

    AggregatorV3Interface public priceFeed;

    uint256 public staleTime = 1 hours;

    constructor(address feed)
        Ownable(msg.sender)
    {
        priceFeed = AggregatorV3Interface(feed);
    }

    function getLatestPrice()
        public
        view
        returns (int256)
    {
        (
            ,
            int256 price,
            ,
            uint256 updatedAt,

        ) = priceFeed.latestRoundData();

        require(
            block.timestamp - updatedAt <= staleTime,
            "Stale price"
        );

        return price;
    }

    function setStaleTime(uint256 newTime)
        external
        onlyOwner
    {
        staleTime = newTime;
    }
}
