// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./DeploymentFeeContract.sol";

contract DeploymentFeeFactory {
    address payable public feeRecipient = payable(0x7500A83DF2aF99B2755c47B6B321a8217d876a85);
    uint256 public constant DEPLOYMENT_FEE = 0.000035 ether;

    DeploymentFeeContract[] public deployedContracts;

    event ContractDeployed(address contractAddress, address owner);

    function deploy() external payable {
        require(msg.value >= DEPLOYMENT_FEE, "Insufficient deployment fee");

        // Fee transfer
        feeRecipient.transfer(DEPLOYMENT_FEE);

        // Deploy new contract instance
        DeploymentFeeContract newContract = new DeploymentFeeContract(msg.sender, feeRecipient);

        deployedContracts.push(newContract);

        emit ContractDeployed(address(newContract), msg.sender);
    }

    function getDeployedContracts() external view returns (DeploymentFeeContract[] memory) {
        return deployedContracts;
    }
}
