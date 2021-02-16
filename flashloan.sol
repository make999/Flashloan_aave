pragma solidity ^0.6.6;

import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/FlashLoanReceiverBase.sol"
import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPoolAddressProvider.sol"
import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPool.sol"

contract Flashloan is FlashLoanReceiverBase {

    constructor(address _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}

    // This function is called after your contract has reseived the flash loaned amount

    function executeOperation( address _reserve,uint256 _amount, uint256 _fee, bytes calldata _params) external override {

        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was flashLoan successful?");

        uint totalDebt = _amount.ad(_fee);
        trasnferFundsBackToPoolInternal(_reserve, totalDebt);
    }
}

// Remaining code ...