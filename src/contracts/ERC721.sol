// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';


  contract ERC721 is ERC165,IERC721 {
  
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
 mapping(uint256=>address) private _tokenApprovals;

   //  / @notice Count all NFTs assigned to an owner
   //  / @dev NFTs assigned to the zero address are considered invalid, and this
   //  /  function throws for queries about the zero address.
   //  / @param _owner An address for whom to query the balance
   //  / @return The number of NFTs owned by `_owner`, possibly zero


       //1.Register the interdace for ERC721 contract so that it includes the follwing functions : balanceOf,ownerOf,transferFrom
       // by register the interface :write the constructors with the according byte conversions

       //2. Register the interface for ERC721Enumerable contract so that it includes totalSupply,
       //tokenByIndex,tokenOfOwnerByIndex fxns

        //3. Register the interdace for the ER721MEtadata contract so that it includes name and symbol fxns
  

  
 constructor(){
    _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
    keccak256('ownerOf(bytes4)')^
    keccak256('transferFrom(bytes4)')));
  }

 function balanceOf(address _owner) public view override returns (uint256){
     require(_owner != address(0),'Owner query for non-existent token');
     return _OwnedTokensCount[_owner];
 }

   //  / @notice Find the owner of an NFT
   //  / @dev NFTs assigned to zero address are considered invalid, and queries
   //  /  about them do throw.
   //  / @param _tokenId The identifier for an NFT
   //  / @return The address of the owner of the NFT

   function ownerOf(uint256 _tokenId) public view override returns (address){
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

   // / @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
   //  /  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
   //  /  THEY MAY BE PERMANENTLY LOST
   //  / @dev Throws unless `msg.sender` is the current owner, an authorized
   //  /  operator, or the approved address for this NFT. Throws if `_from` is
   //  /  not the current owner. Throws if `_to` is the zero address. Throws if
   //  /  `_tokenId` is not a valid NFT.
   //  / @param _from The current owner of the NFT
   //  / @param _to The new owner
   //  / @param _tokenId The NFT to transfer
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal{
      // Exercise -
      //  1.add the token id to the address recieving the token
      //  2.update the balance of the address _from token
      //  3.update the balance of the address _to
      //  4.add the safe functionality 
      //  5.require that the address receiving a token is not a zero address
      //  6.require the address transfering the token actually owns the token
       
       require(_to!=address(0),"Error - ERC721 Transfer to the zero address");
       require(ownerOf(_tokenId)==_from,"Error - Trying to transfer a token the address doest not own");
       _OwnedTokensCount[_from]-=1;
       _OwnedTokensCount[_to]++;
       _tokenOwner[_tokenId]=_to;
       emit Transfer (_from,_to,_tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override public{
         _transferFrom(_from,_to,_tokenId);
    }
    

}