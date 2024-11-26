// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import './pool/IStoryHuntV3PoolImmutables.sol';
import './pool/IStoryHuntV3PoolState.sol';
import './pool/IStoryHuntV3PoolDerivedState.sol';
import './pool/IStoryHuntV3PoolActions.sol';
import './pool/IStoryHuntV3PoolOwnerActions.sol';
import './pool/IStoryHuntV3PoolEvents.sol';

/// @title The interface for a StoryHunt V3 Pool
/// @notice A StoryHunt pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface IStoryHuntV3Pool is
    IStoryHuntV3PoolImmutables,
    IStoryHuntV3PoolState,
    IStoryHuntV3PoolDerivedState,
    IStoryHuntV3PoolActions,
    IStoryHuntV3PoolOwnerActions,
    IStoryHuntV3PoolEvents
{

}
