// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./NEX.sol";
import "./NexionProfile.sol";

contract NexionFeedV2 {
    NEX public nexToken;
    NexionProfile public profiles;
    uint256 public postCost = 0.01 * 10**18;
    uint256 public nextPostId;
    struct Post { address author; string contentHash; uint256 createdAt; uint256 rewardPool; bool claimed; }
    mapping(uint256 => Post) public posts;
    mapping(uint256 => mapping(address => bool)) public hasShared;
    constructor(address _nex, address _profiles) { nexToken = NEX(_nex); profiles = NexionProfile(_profiles); }
    function createPost(string memory _contentHash) external { nexToken.transferFrom(msg.sender, address(this), postCost); posts[nextPostId] = Post(msg.sender, _contentHash, block.timestamp, postCost, false); nextPostId++; }
    function sharePost(uint256 _postId) external { require(!hasShared[_postId][msg.sender], "Already shared"); hasShared[_postId][msg.sender] = true; }
}