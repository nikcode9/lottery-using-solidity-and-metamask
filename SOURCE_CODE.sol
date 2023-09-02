//SPDX-License-Identifier: GPL-3.0
// created by nikhil
pragma solidity >=0.5.0 <0.9.0;// i am displaying the version range of solidity being used

contract Lottery{

    address payable[] public players;
    address public manager;



    constructor(){
        manager = msg.sender; 
    }

    receive () payable external{
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manage,”You are not the manager”r);  // fetching balance
        return address(this).balance;
    }

    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length))); //generating random number as it is lottery system
    }


    function pickWinner() public{

        require(msg.sender == manager);
        require (players.length >= 3); //atleast 3 players required

        uint r = random();
        address payable winner;


        uint index = r % players.length; // to make it come in <players.length range

        winner = players[index];

        winner.transfer(getBalance());


        players = new address payable[](0);
    }

}
