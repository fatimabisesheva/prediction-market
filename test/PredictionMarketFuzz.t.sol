// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

import "../src/market/PredictionMarket.sol";
import "./MockERC20.sol";

contract PredictionMarketFuzzTest is Test {

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
    }

    function testFuzzBuyYes(uint256 amount) public {

        amount = bound(amount, 1 ether, 1000 ether);

        vm.prank(user);

        market.buyYes(amount);

        assertEq(
            market.totalYesShares(),
            amount
        );
    }

    function testFuzzBuyNo(uint256 amount) public {

        amount = bound(amount, 1 ether, 1000 ether);

        vm.prank(user);

        market.buyNo(amount);

        assertEq(
            market.totalNoShares(),
            amount
        );
    }

    function testFuzzResolve(uint256 outcome) public {

        outcome = bound(outcome, 0, 1);

        market.resolveMarket(outcome);

        assertEq(
            market.winningOutcome(),
            outcome
        );
    }

    function testFuzzClaim(uint256 amount) public {

        amount = bound(amount, 1 ether, 100 ether);

        vm.startPrank(user);

        market.buyYes(amount);

        vm.stopPrank();

        market.resolveMarket(0);

        vm.prank(user);

        market.claimRewards(amount);

        assertEq(
            token.balanceOf(user),
            1_000_000 ether
        );
    }

    function testFuzzMultipleYesBuys(
        uint256 amount1,
        uint256 amount2
    )
        public
    {
        amount1 = bound(amount1, 1 ether, 500 ether);
        amount2 = bound(amount2, 1 ether, 500 ether);

        vm.startPrank(user);

        market.buyYes(amount1);
        market.buyYes(amount2);

        vm.stopPrank();

        assertEq(
            market.totalYesShares(),
            amount1 + amount2
        );
    }

    function testFuzzMultipleNoBuys(
        uint256 amount1,
        uint256 amount2
    )
        public
    {
        amount1 = bound(amount1, 1 ether, 500 ether);
        amount2 = bound(amount2, 1 ether, 500 ether);

        vm.startPrank(user);

        market.buyNo(amount1);
        market.buyNo(amount2);

        vm.stopPrank();

        assertEq(
            market.totalNoShares(),
            amount1 + amount2
        );
    }

    function testFuzzCannotResolveInvalidOutcome(
        uint256 outcome
    )
        public
    {
        vm.assume(outcome > 1);

        vm.expectRevert();

        market.resolveMarket(outcome);
    }

    function testFuzzCannotBuyAfterResolve(
        uint256 amount
    )
        public
    {
        amount = bound(amount, 1 ether, 100 ether);

        market.resolveMarket(0);

        vm.prank(user);

        vm.expectRevert();

        market.buyYes(amount);
    }

    function testFuzzClaimDifferentAmounts(
        uint256 amount
    )
        public
    {
        amount = bound(amount, 1 ether, 500 ether);

        vm.startPrank(user);

        market.buyYes(amount);

        vm.stopPrank();

        market.resolveMarket(0);

        vm.prank(user);

        market.claimRewards(amount);

        assertEq(
            token.balanceOf(user),
            1_000_000 ether
        );
    }

    function testFuzzMarketStateAfterResolve(
        uint256 outcome
    )
        public
    {
        outcome = bound(outcome, 0, 1);

        market.resolveMarket(outcome);

        assertEq(
            uint256(market.marketState()),
            1
        );
    }
}