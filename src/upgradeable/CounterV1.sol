// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract CounterV1 is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable
{
    uint256 public number;

    function initialize() public initializer {
        __Ownable_init(msg.sender);

        number = 1;
    }

    function increment() external {
        number += 1;
    }

    function _authorizeUpgrade(address)
        internal
        override
        onlyOwner
    {}
}