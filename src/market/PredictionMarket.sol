// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../tokens/OutcomeToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract PredictionMarket is Ownable, ReentrancyGuard {

    using SafeERC20 for IERC20;

    enum MarketState {
        OPEN,
        RESOLVED
    }

    OutcomeToken public outcomeToken;
    IERC20 public paymentToken;

    uint256 public totalYesShares;
    uint256 public totalNoShares;

    uint256 public winningOutcome;

    string public question;

    MarketState public marketState;

    constructor(
        address _paymentToken,
        string memory _question
    )
        Ownable(msg.sender)
    {
        paymentToken = IERC20(_paymentToken);

        outcomeToken = new OutcomeToken();

        question = _question;

        marketState = MarketState.OPEN;
    }

    function buyYes(uint256 amount)
        external
        nonReentrant
    {
        require(
            marketState == MarketState.OPEN,
            "Market resolved"
        );

        paymentToken.safeTransferFrom(
            msg.sender,
            address(this),
            amount
        );

        outcomeToken.mint(
            msg.sender,
            outcomeToken.YES(),
            amount
        );

        totalYesShares += amount;
    }

    function buyNo(uint256 amount)
        external
        nonReentrant
    {
        require(
            marketState == MarketState.OPEN,
            "Market resolved"
        );

        paymentToken.safeTransferFrom(
            msg.sender,
            address(this),
            amount
        );

        outcomeToken.mint(
            msg.sender,
            outcomeToken.NO(),
            amount
        );

        totalNoShares += amount;
    }

    function resolveMarket(uint256 outcome)
        external
        onlyOwner
    {
        require(
            marketState == MarketState.OPEN,
            "Already resolved"
        );

        require(
            outcome == 0 || outcome == 1,
            "Invalid outcome"
        );

        winningOutcome = outcome;

        marketState = MarketState.RESOLVED;
    }

    function claimRewards(uint256 amount)
        external
        nonReentrant
    {
        require(
            marketState == MarketState.RESOLVED,
            "Not resolved"
        );

        outcomeToken.burn(
            msg.sender,
            winningOutcome,
            amount
        );

        paymentToken.safeTransfer(
            msg.sender,
            amount
        );
    }
}