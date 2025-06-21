// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DeploymentFeeContract {
    address public owner;
    address payable public feeRecipient;

    constructor(address _owner, address payable _feeRecipient) {
        owner = _owner;
        feeRecipient = _feeRecipient;
    }
}
