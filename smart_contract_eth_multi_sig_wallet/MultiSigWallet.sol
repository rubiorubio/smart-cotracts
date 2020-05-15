pragma solidity >=0.4.22 <0.7.0;

import "./ballot_test.sol";
import "./Ownable.sol";

contract MultiSigWallet is Ownable{

    address private _owner;
    mapping(address => uint8) private _owners;


    event DepositFunds (address from, uint amount);
    event WithdrawFunds(address to, uint amount);
    event TransferFunds(address from, address to, uint amount);

    function MultiSigWallet_() public {
        _owner = msg.sender;
    }

    function () public payable {
        emit DepositFunds(msg.sender, msg.value);

    }
    function payMe() public payable returns(bool success) {
        return true;
    }

    function withdraw(uint amount) public onlyOwner{
        require(address(this).balance >= amount,"insufficient funds");
        msg.sender.transfer(amount);
        emit WithdrawFunds(msg.sender, amount);
    }
    address addressBallot;
    function setAddress(address _addressBallot) external onlyOwner {
        addressBallot = _addressBallot;
    }
    function transferTo(address to,uint amount) public{
        Ballot b = Ballot(addressBallot);
        require(address(this).balance >= amount,"insufficient funds");
        // require(to == b.winnerName(),"The candidate should be elected in ballot contract");
        require(msg.sender == b.winnerName(),"The candidate should be elected in ballot contract");
        to.transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
    }
    function transferToFromOwn(address to,uint amount) public onlyOwner{
        require(address(this).balance >= amount,"Not enough resources");
        to.transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
    }
    function walletBalance()
      public
      view
      returns (uint256) {
      return address(this).balance;
    }
}