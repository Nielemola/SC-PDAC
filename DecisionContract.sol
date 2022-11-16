// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


interface ICertificationContract{
    function certify(address _client,address _from) external returns(bool);
}

interface ISigContract{
    function getSigInfo() external view returns (bytes32 _ethSignedMessageHash,bytes32 R,bytes32 S,uint8 V);
}

interface IRequestContract{
    function getInfo() external returns (address,address,address);
}

contract DecisionContract{
    bool public x;
    address public contractAdd;
    address public client;
    address public from;
    function getInfo(address reconAdd)external returns (address,address,address){
        (contractAdd,client,from) = IRequestContract(reconAdd).getInfo();
        return (contractAdd,client,from);
    }
    function certify(address contractAdd1,address client1,address from1) external returns(bool){
        x = ICertificationContract(contractAdd1).certify(client1,from1);
        return x;
    }
    address public y1;
    function getSigInfo(address contractAdd2) external returns (address){
        (bytes32 ethSignedMessageHash,bytes32 R,bytes32 S,uint8 V) = ISigContract(contractAdd2).getSigInfo();
        y1 = ecrecover(ethSignedMessageHash,V,R,S);
        require(y1 != address(0));
        return y1;
    }
    bool public y;
    function isSigned() external returns(bool __y){
        if(msg.sender == y1){
            y = true;
            return y;
        }
    }
    event Log(address,uint amount,uint gas);
    receive() external payable{
        emit Log(msg.sender,msg.value,gasleft());
    }
    bool public z;
    function getBalance() external returns (bool) {
        if(address(this).balance>=1000){
            return z=true;
        }
        else{
            return z=false;
        }
    }
    event Logs(string message);
    function access() external{
        if (x  && y  && z){
            emit Logs("Access confirm");
        }
        else{
            emit Logs("Access deny");
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