// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.6;


import "@forge-std/src/Test.sol";
import "@forge-std/src/console2.sol";

import '@uni-v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import '@openzeppelin/token/ERC20/IERC20.sol';

interface Hevm {
    function createFork(string calldata urlOrAlias, bytes32 transaction) external returns (uint256);
    function selectFork(uint256 forkId) external;
}

contract UniV2SpatialArbTest is Test {
    Hevm hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    function setUp() public {
        uint256 fork = hevm.createFork(
            "http://localhost:8545",
            0xbed0c8c1b9ff8bf0452979d170c52893bb8954f18a904aa5bcbd0f709be050b9
        );
        hevm.selectFork(fork);
    }

    function testPoolState(
        address poolAddr,
        uint256 expectedSqrtPriceX96,
        uint256 expectedLiquidity
    ) private {
        IUniswapV3Pool pool = IUniswapV3Pool(poolAddr);

        (uint256 actualSqrtPriceX96,,,,,,) = pool.slot0();
        uint256 actualLiquidity = pool.liquidity();

        assertEq(expectedSqrtPriceX96, actualSqrtPriceX96);
        assertEq(expectedLiquidity, actualLiquidity);
    }

    function testTokenBalance(
        address tokenAddr,
        address account,
        uint256 expectedBalance
    ) private {
        IERC20 token = IERC20(tokenAddr);
        uint256 actualBalance = token.balanceOf(account);
        assertTrue(expectedBalance != actualBalance);
    }

    function testStatePool1() public {
        testPoolState(
            0x847b64f9d3A95e977D157866447a5C0A5dFa0Ee5,
            1076133273204200901840477866344,
            1221531661829
        );
    }

    function testStatePool2() public {
       testPoolState(
           0x50eaEDB835021E4A108B7290636d62E9765cc6d7,
           29344980527396021373083957193598046,
           63106417987627857
       );
    }

    function testStatePool3() public {
        testPoolState(
            0x45dDa9cb7c25131DF268515131f647d726f50608,
            2158492202962238680259690147925313,
            588702194510526627
        );
    }

    function testTokenBalance1() public {
        testTokenBalance(
            0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174,
            0x200800030b0920400c0100b30BB0fd6Bab300050,
            109434379418
        );
    }

    function testTokenBalance2() public {
        testTokenBalance(
            0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6,
            0x847b64f9d3A95e977D157866447a5C0A5dFa0Ee5,
            11587054831
        );
    }

    function testTokenBalance3() public {
        testTokenBalance(
            0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6,
            0x50eaEDB835021E4A108B7290636d62E9765cc6d7,
            8562351311
        );
    }

    function testTokenBalance4() public {
        testTokenBalance(
            0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174,
            0x847b64f9d3A95e977D157866447a5C0A5dFa0Ee5,
            1224710159848
        );
    }

    function testTokenBalance5() public {
        testTokenBalance(
            0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174,
            0x45dDa9cb7c25131DF268515131f647d726f50608,
            2160762715376
        );
    }

    function testTokenBalance6() public {
        testTokenBalance(
            0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619,
            0x45dDa9cb7c25131DF268515131f647d726f50608,
            5069111567539236303841
        );
    }

    function testTokenBalance7() public {
        testTokenBalance(
            0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619,
            0x50eaEDB835021E4A108B7290636d62E9765cc6d7,
            1640142708175996572419
        );
    }
}
