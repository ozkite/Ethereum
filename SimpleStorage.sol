// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MyStorage
 * @dev A simple storage contract with events and access control
 */
contract MyStorage {
    uint256 public number;
    address public owner;

    event NumberStored(address indexed sender, uint256 value);
    event Upgraded(address indexed newImplementation);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Store a number (only owner)
     * @param num Value to store
     */
    function store(uint256 num) public onlyOwner {
        number = num;
        emit NumberStored(msg.sender, num);
    }

    /**
     * @dev Retrieve the current number
     * @return The stored value
     */
    function retrieve() public view returns (uint256) {
        return number;
    }

    /**
     * @dev Upgrade to a new contract (for future use with proxies)
     */
    function upgrade() external onlyOwner {
        emit Upgraded(address(this));
    }
}
