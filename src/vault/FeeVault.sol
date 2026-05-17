// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FeeVault is ERC4626, Ownable {

    constructor(address assetToken)
        ERC20("Fee Vault Share", "FVS")
        ERC4626(IERC20(assetToken))
        Ownable(msg.sender)
    {}

    function emergencyWithdraw(
        address token,
        uint256 amount
    )
        external
        onlyOwner
    {
        IERC20(token).transfer(
            msg.sender,
            amount
        );
    }
}