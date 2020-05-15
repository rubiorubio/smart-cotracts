pragma solidity ^0.6.1;

contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
// The Ownable constructor sets the original 'owner'of the  contract to sender account
    constructor() internal{
        _owner = msg.sender;
        emit OwnershipTransferred(address(0),_owner);
    }
    function owner() public view returns (address) { // return owner address
        return _owner;
    }
    // thorws if called by an any other account other than owner.
    modifier onlyOwner() {
        require(isOwner(),"Ownable: caller is not owner");
        _;
    }
    // return true if is the owner contract.
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }
// Allows  current owner  to relinquish control of the contract
//It will not be possible to call functions with  the onlyOwner modifier anymore
//Renouncing ownership will leave  the contract without an owner,
//thereby removing any functionality that is only available to the owner.
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    function transferOwnership(address newOwner) public onlyOwner { // to allow to transfer
        _transferOwnerShip(newOwner);
    }
    function _transferOwnerShip(address newOwner) internal { // to transfer
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

}