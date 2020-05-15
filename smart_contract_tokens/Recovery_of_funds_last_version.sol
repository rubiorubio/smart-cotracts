pragma solidity ^0.6.1;

import "./math.sol";
import "./Ownable.sol";
import "./ballot_test.sol";

contract MyFirstToken is Ownable{
    using SafeMath for uint;
    string public constant name    = "RubioToken";
    string public constant symbol  = "RUB";
    uint8 public constant decimals = 0;
    
    uint public totalSupply; //переменная храниет всё колличесвто токенов

    mapping(address => uint) balances; // массивв всех баллансов (адрес и колл.токенов)

    mapping(address => mapping(address => uint)) allowed; //разрешение на снятие указанной суммы денег (двухмерный)

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _from, address indexed _to, uint _value);

    function mint(address _to,uint _value) public onlyOwner {
        require(totalSupply + _value >= totalSupply && balances[_to]+_value >= balances[_to]);// проверка на переполнение
        balances[_to] = balances[_to].add(_value); // добавляем к адресу указываемое значение
        totalSupply = totalSupply.add(_value); // увеличиваем также общий балланс всех токенов
    }

    function balanceOf(address _owner) external view returns(uint) { // чекнуть баланс указаннового адреса
        return balances[_owner];
    }

    function allowance(address _owner, address _spender) public view returns(uint){
        return allowed[_owner][_spender];
    }
    function transfer(address _to,uint _value) external {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
    }
        
    address addressBallot;
    function setAddress(address _addressBallot) external onlyOwner {
        addressBallot = _addressBallot;
    }
    
    function callWinnerName() public view returns(address) {
        Ballot b = Ballot(addressBallot);
        return b.winnerName();
    }
    

    function transferFrom(address _from, address _to, uint _value) external {
        Ballot b = Ballot(addressBallot);
        require(balances[_from] >= _value && allowed [_from][msg.sender] >= _value);
        require(_to == b.winnerName(),"The candidate should be elected in ballot contract");
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
    }
    
    function approve(address _spender, uint _value) public { // создаёт разрешение на снятие
        // Ballot b = Ballot(addressBallot);
        // require(_spender == b.winnerName(),"The candidate should be elected in ballot contract");
        allowed[msg.sender][_spender] = _value;// адрес отправителя и аргумент
        emit Approval(msg.sender, _spender, _value);
    }

}