// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DelegationContract {
    
    address constant client2 = 0x*****************************************************;use the client-side address to change the *.
    address public from = msg.sender;

    function certify(address client1,address from1) external view returns (bool){
        if(client2 == client1 && from == from1){
            return true;
        }
        else{
            return false;
        }
    }
    modifier onlyOwner {
        require(from == msg.sender,"not owner");
        _;
    }
    function kill() external onlyOwner{
        selfdestruct(payable(msg.sender));
    }
}