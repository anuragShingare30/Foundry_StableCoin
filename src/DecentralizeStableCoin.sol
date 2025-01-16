// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";


/**
 * @title Main contract to develop a Stablecoin.
 * @author anurag shingare
 * @notice This is the main contract to develop a StableCoin which is goverened by the Decentralize StableCoin engine(DSC engine).
 * @dev Implements main function to develop a stablecoin. The stable is categorized as:
        1. It is a Exogenously Collaterized (ETH or BTC)
            a. Implements ERC-20 token standard to develop a stablecoin
            b. Collaterized by ETH or BTC.
        2. Algorithmic minting
            a. Will code the minting function if enough collateral is provided
        3. Pegged stablecoin
            a. Implements chainlinf pricefeed functions
            b. Will implement the function to exchange the value of stablecoin with Dollar
 */



contract DecentralizeStableCoin is ERC20, ERC20Burnable, Ownable {
    // errors
    error DecentralizeStableCoin_ZeroAmountNotAllowed();
    error DecentralizeStableCoin_TokenBalanceIsLessThanAmount();
    error DecentralizeStableCoin_ZeroAddressNotAllowed();

    // type declaration

    // state variables

    // events

    // functions
    constructor()
        ERC20("DecentralizeStableCoin", "DSC")
        Ownable(msg.sender)
    {}

    function burn(uint256 _burnAmount) public override{
        uint256 balance = balanceOf(msg.sender);
        if(_burnAmount <= 0){
            revert DecentralizeStableCoin_ZeroAmountNotAllowed();
        }
        if(balance < _burnAmount){
            revert DecentralizeStableCoin_TokenBalanceIsLessThanAmount();
        }
        super.burn(_burnAmount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        if(amount <= 0){
            revert DecentralizeStableCoin_ZeroAmountNotAllowed();
        }
        if(to == address(0)){
            revert DecentralizeStableCoin_ZeroAddressNotAllowed();
        }
        _mint(to, amount);
    }
}