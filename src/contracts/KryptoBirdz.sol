// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Kryptobird {
    // this contract gonna hold all our ERC721 functionality,interfaces,metadata,etc.
    string public name;
    string public symbol;

    constructor(){
        name='KryptoBird';
        symbol='KBIRDZ';
    }

}