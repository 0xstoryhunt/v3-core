// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

interface IStoryHuntV3LmPool {
    function accumulateReward(uint32 currTimestamp) external;

    function crossLmTick(int24 tick, bool zeroForOne) external;
}
