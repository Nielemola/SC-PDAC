// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ISigContract{
    function getSigInfo() external view returns (bytes32 ethSignedMessageHash1,bytes32 R1,bytes32 S1,uint8 V1);
}

contract RequestContract{
    
    function getInfo() external virtual returns (address con,address cli,address fro){
            address _contractAdd = 0x****************************************************;//use the DelegationContract address which deployed by delegator to change the *.
            address _client = 0x****************************************************;// use the client-side address to change the *.    
            address _from =  0x****************************************************;// use the delegator address to change the *. 
            return (_contractAdd,_client,_from);

    }
    address public y;
    function getSigInfo(address contractAdd1) external returns (address){
        (bytes32 ethSignedMessageHash1,bytes32 R1,bytes32 S1,uint8 V1) = ISigContract(contractAdd1).getSigInfo();
        
        y = ecrecover(ethSignedMessageHash1,V1,R1,S1);
        require(y != address(0));
        return y;
    }
    
    address payable owner =payable(msg.sender);
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    constructor() payable{}
    receive() external payable {}
    function sendTransfer(address payable to) external payable onlyOwner{
        require(to != address(0));
        to.transfer(1000);
    }
}