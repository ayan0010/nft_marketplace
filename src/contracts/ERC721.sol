// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
 mapping(uint256 => address) private _tokenOwner;
 mapping(address => uint256) private _OwnedTokensCount;

   

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero

 
 function balanceOf(address _owner) public view returns (uint256){
     require(_owner != address(0),'Owner query for non-existent token');
     return _OwnedTokensCount[_owner];
 }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT

   function ownerOf(uint256 _tokenId) external view returns (address){
      address owner=_tokenOwner[_tokenId];
      require(owner != address(0),'Owner query for non-existent token');
      return owner;

   }


 function _exists(uint256 tokenId) internal view returns(bool){
    address owner = _tokenOwner[tokenId];
    return owner !=address(0);
 }
   function _mint(address to,uint256 tokenId) internal virtual{
      //we need to write a function to check whether a token has been minted or not then we'll use it in require

     require(to!=address(0));
     require(!_exists(tokenId)); //should be false
    //who owns which token 
        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to]++;

       emit Transfer(address(0),to,tokenId);
   }
}