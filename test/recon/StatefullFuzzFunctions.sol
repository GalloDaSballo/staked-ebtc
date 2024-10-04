
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.25;

import {TargetFunctions} from "./TargetFunctions.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";
import {vm} from "@chimera/Hevm.sol";
import "forge-std/console2.sol";

abstract contract StatefullFuzzFunctions is TargetFunctions {

    function erc4626_mint_preview_match(uint256 amount) public prepare {
        amount = between(amount, 1, MAX_EBTC);

        uint256 fromPreview = stakedEbtc.previewMint(amount);

        uint256 beforeShares = stakedEbtc.balanceOf(senderAddr);
        uint256 b4Mint = mockEbtc.balanceOf(senderAddr);
        vm.prank(senderAddr);
        uint256 paid = stakedEbtc.mint(amount, senderAddr);
        uint256 afterMint = mockEbtc.balanceOf(senderAddr);
        uint256 afterShares = stakedEbtc.balanceOf(senderAddr);

        
        t(fromPreview == paid, "Matches view");
        t(amount == afterShares - beforeShares, "Matches Storage");
        t(fromPreview == b4Mint - afterMint, "Payment is what was intended");
    }

    function erc4626_deposit_preview_match(uint256 amount) public prepare {
        amount = between(amount, 1, MAX_EBTC);

        uint256 fromPreview = stakedEbtc.previewDeposit(amount);

        uint256 beforeShares = stakedEbtc.balanceOf(senderAddr);
        uint256 b4Mint = mockEbtc.balanceOf(senderAddr);
        vm.prank(senderAddr);
        uint256 sharesReceived = stakedEbtc.deposit(amount, senderAddr);
        uint256 afterMint = mockEbtc.balanceOf(senderAddr);
        uint256 afterShares = stakedEbtc.balanceOf(senderAddr);

        
        t(fromPreview == sharesReceived, "Matches view");
        t(sharesReceived == afterShares - beforeShares, "Matches Storage");
        t(amount == b4Mint - afterMint, "Payment is what was intended");
    }

}
