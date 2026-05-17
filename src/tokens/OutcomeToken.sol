// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OutcomeToken is ERC1155, Ownable {

    uint256 public constant YES = 0;
    uint256 public constant NO = 1;

    constructor()
        ERC1155("")
        Ownable(msg.sender)
    {}

    function mint(
        address to,
        uint256 id,
        uint256 amount
    )
        external
        onlyOwner
    {
        _mint(to, id, amount, "");
    }

    function burn(
        address from,
        uint256 id,
        uint256 amount
    )
        external
        onlyOwner
    {
        _burn(from, id, amount);
    }
}