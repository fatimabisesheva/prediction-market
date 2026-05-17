// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/StdInvariant.sol";

import "../src/market/PredictionMarket.sol";
import "./MockERC20.sol";

contract PredictionInvariantTest is StdInvariant, Test {

    PredictionMarket market;
    MockERC20 token;

    address user = address(1);

    function setUp() public {

        token = new MockERC20();

        market = new PredictionMarket(
            address(token),
            "Will BTC exceed 100k?"
        );

        token.mint(user, 1_000_000 ether);

        vm.prank(user);

        token.approve(
            address(market),
            type(uint256).max
        );

        targetContract(address(market));
    }

    function invariantYesSharesNonNegative()
        public
        view
    {
        assertGe(
            market.totalYesShares(),
            0
        );
    }

    function invariantNoSharesNonNegative()
        public
        view
    {
        assertGe(
            market.totalNoShares(),
            0
        );
    }

    function invariantMarketStateValid()
        public
        view
    {
        uint256 state =
            uint256(market.marketState());

        assertTrue(
            state == 0 || state == 1
        );
    }

    function invariantWinningOutcomeValid()
        public
        view
    {
        uint256 outcome =
            market.winningOutcome();

        assertTrue(
            outcome == 0 || outcome == 1
        );
    }

    function invariantContractBalanceConsistent()
        public
        view
    {
        uint256 contractBalance =
            token.balanceOf(address(market));

        uint256 totalShares =
            market.totalYesShares()
            +
            market.totalNoShares();

        assertGe(
            contractBalance,
            totalShares
        );
    }
}