// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUniswapV2Router02 {
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
}

contract ShitcoinSniper {
    address private constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; // WETH address on Arbitrum Sepolia
    address private constant ARBITRUM_ROUTER = 0xcE18836b233C83325Cc8848CA4487e94C6288264; // Arbitrum Sepolia Uniswap Router

    IUniswapV2Router02 private uniswapRouter;

    constructor() {
        uniswapRouter = IUniswapV2Router02(ARBITRUM_ROUTER);
    }

    // Function to buy a shitcoin
    function buyShitcoin(address _token) external payable {
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = _token;

        uint[] memory amounts = uniswapRouter.swapExactETHForTokens{value: msg.value}(
            0, // accept any amount of tokens
            path,
            address(this),
            block.timestamp + 300 // 5 minutes deadline
        );

        // Check if the trade was successful
        require(amounts[amounts.length - 1] > 0, "Failed to buy shitcoin");
        
        // You can perform further actions here, such as transferring the bought tokens to another address
    }

    // Function to get the current WETH balance of this contract
    function getWethBalance() public view returns (uint) {
        return address(this).balance;
    }
}
