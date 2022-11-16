// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SigContract {
    
    string[] private P = ["operate","control1","control2","control3"];


    bytes32 private PHash = keccak256(abi.encode(P));
    bytes32 private ethSignedMessageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",PHash));
                                            
    bytes32 private constant r = 0x491905b2e1ea6e6208e0d57e8820d08129a0005c8e3bbf34330a947c42322d30;
    bytes32 private constant s = 0x0b37d942cad09a64f9b62a12a0673080918e4d37ad1fc7acd675a1accb1ea562;
    uint8 private constant v = 27;//0x1b=27     0x1c=28

    function getSigInfo() external virtual returns (bytes32 ethSignedMessageHash1,bytes32 R1,bytes32 S1,uint8 V1){
        return (ethSignedMessageHash,r,s,v);
    }
    function getControls(string memory o) external view returns (string[] memory p1){
        bytes32 oHash = keccak256(abi.encode(o));
        bytes32 PoHash = keccak256(abi.encode(P[0]));
        if(oHash == PoHash){
            return P;
        }
    }

}