// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Migrations {
  address public owner = msg.sender; //owner (current caller)
  uint public last_completed_migration; 

  modifier restricted() { 
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _; // else continue running the function
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  // Upgrade smart contract 

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
  // we created a fxn called upgraded , upgraded takes an address and set the address to a new contract of migrations 
  // and we put it in upgraded , and then in upgraded we call function setCompleted and we pass the last_completed_migration
}
