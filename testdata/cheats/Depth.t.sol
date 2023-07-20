// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.18;

import "ds-test/test.sol";
import "./Vm.sol";

contract DepthTest is DSTest {
    Vm constant vm = Vm(HEVM_ADDRESS);

    function testDepth(uint256 amount) public {
        assertEq(vm.depth(), 1, "Depth should be 0");

        // Go 2 calls deeper
        uint256 two_calls_deep = this.exposed_depth(2, vm.depth());
        assertEq(two_calls_deep, 3, "Depth should be 2");
    }

    function exposed_depth(uint256 desiredDepth, uint256 currDepth) external returns (uint256) {
        if (currDepth == desiredDepth) {
            return vm.depth();
        }

        this.exposed_depth(desiredDepth, currDepth + 1);
    }
}
