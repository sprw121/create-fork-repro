// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.6;


import "@forge-std/src/Test.sol";
import "@forge-std/src/console2.sol";

import '@uni-v3-core/contracts/interfaces/IUniswapV3Pool.sol';

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
}
