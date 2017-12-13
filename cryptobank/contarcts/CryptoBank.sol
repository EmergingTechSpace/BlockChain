pragma solidity ^0.4.18;


import "./SafeMath.sol";

contract CryptoBank {
    using SafeMath for uint256;
    
    //Global Variables (can be public, private, internal)
    uint256 public totalAmount;
    
    mapping(address => uint256) public balances;
    address[] public accounts;
    
    address public owner;
    
    //Modifiers
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    //Events
    event EDeposit(address _accHolder, uint256 _value);
    event ETransfer(address _from, address _to, uint256 _value);
    
    // Constructor
    function CryptoBank() public {
        totalAmount = 0;
        owner = msg.sender;
    }
    
    //Functions private
    //Functions internal
    //Functions public
    function listAccounts() public view returns (address[]) {
        return accounts;
    }
    
    function balanceOf(address _accHolder) public view returns (uint256) {
        return balances[_accHolder];
    }
    
    function IssueEther(address _accholder, uint256 _amount) public  onlyOwner {
        require(_accholder!= 0x0);
        require(_amount != 0);  
        
        balances[_accholder] = balances[_accholder].add(_amount);
        accounts.push(_accholder);
        totalAmount = totalAmount.add(_amount);
        
        //fire the Events 
        EDeposit(_accholder, _amount);
    } 
    
    function Transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] > 0);
        require(_to != 0x0);
        require(_amount > 0);
        
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount); 
        accounts.push(_to);
        
        ETransfer(msg.sender, _to, _amount);
    }
    
}