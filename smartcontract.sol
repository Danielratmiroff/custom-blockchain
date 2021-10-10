// Pollo Coin ICO

// Version of compiler
pragma solidity ^0.4.11;

contract pollocoin_ico {
    
    // Introducing maximum number of coins available
    uint public max_pollocoins = 1000000;
    
    // Introducing the USD to pollocoin conversion rate
    uint public usd_to_pollocoins = 100;
    
    // Introducing total number of Pollocoins bought
    uint public total_pollocoins_bought = 100;
    
    // Mapping from investor to address
    mapping(address => uint) equity_pollocoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Pollocoins
    modifier can_buy_pollocoins(uint usd_invested) {
        require (usd_invested * usd_to_pollocoins + total_pollocoins_bought <= max_pollocoins);
        _;
    }
    
    // Getting the equity of an investor
    function equity_in_pollocoins (address investor) external constant returns (uint) {
        return equity_pollocoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd (address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buy Pollocoins
    function buy_pollocoins(address investor, uint usd_invested) external 
    can_buy_pollocoins(usd_invested) {
        uint pollocoins_bought = usd_invested * usd_to_pollocoins;
        equity_pollocoins[investor] += pollocoins_bought;
        equity_usd[investor] = equity_pollocoins[investor] / 1000;
        total_pollocoins_bought += pollocoins_bought;
    }
    
    // Sell Pollocoins
    function sell_pollocoins(address investor, uint pollocoins_sold) external  {
        equity_pollocoins[investor] -= pollocoins_sold;
        equity_usd[investor] = equity_pollocoins[investor] / 1000;
        total_pollocoins_bought -= pollocoins_sold;
    }
    
}