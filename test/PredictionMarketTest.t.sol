// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

import "../src/market/PredictionMarket.sol";
import "./MockERC20.sol";

contract PredictionMarketTest is Test {

    PredictionMarket market;
    MockERC20 token;

    address user = address(1);

    function setUp() public {
        token = new MockERC20();

        market = new PredictionMarket(
            address(token),
            "Will BTC exceed 100k?"
        );

        token.mint(user, 1000 ether);

        vm.prank(user);

        token.approve(address(market), 1000 ether);
    }

    function testBuyYes() public {
        vm.prank(user);

        market.buyYes(100 ether);

        assertEq(
            market.totalYesShares(),
            100 ether
        );
    }

    function testBuyNo() public {
        vm.prank(user);

        market.buyNo(50 ether);

        assertEq(
            market.totalNoShares(),
            50 ether
        );
    }

    function testResolveMarket() public {
        market.resolveMarket(0);

        assertEq(
            uint256(market.marketState()),
            1
        );
    }

    function testClaimRewards() public {
        vm.startPrank(user);

        market.buyYes(100 ether);

        vm.stopPrank();

        market.resolveMarket(0);

        uint256 balanceBefore =
            token.balanceOf(user);

        vm.prank(user);

        market.claimRewards(100 ether);

        uint256 balanceAfter =
            token.balanceOf(user);

        assertGt(
            balanceAfter,
            balanceBefore
        );
    }

    function testCannotBuyAfterResolve() public {
        market.resolveMarket(0);

        vm.prank(user);

        vm.expectRevert();

        market.buyYes(100 ether);
    }
}