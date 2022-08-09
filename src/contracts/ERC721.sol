// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ERC721{
    
    event Transfer (address indexed from, address indexed to, uint256 indexed tokenId);
    


    /*
             steps to building out the minting function-
        a. nfts to point an address
        b.keep track of token ids
        c.keep track of token owners address to token id mapping
        d.keep track of how many tokens are owned by an address 
        e.create an event that emits a transfer log (contract address, from, to, token id)

        requirements--
        1.require that the minting address isnt 0
        2.require that the token has not been minted before
    */
 
 mapping(uint256 => address) public _tokenOwner;
 mapping(address => uint256[]) public _OwnedTokensCount;

 function _exists(uint256 tokenId) internal view returns(bool){
    address owner = _tokenOwner[tokenId];
    return owner !=address(0);
 }
   function _mint(address to,uint256 tokenId) internal {
      //we need to write a function to check whether a token has been minted or not then we'll use it in require

     require(to!=address(0));
     require(!_exists(tokenId)); //should be false
    //who owns which token 
       _tokenOwner[tokenId] = to;
        _ownedTokensCount[to]++;

       emit Transfer(address(0),to,tokenId); 
   }
}