pragma solidity 0.4.25;

contract Owned {

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    address public owner;

    function Owned() {
        owner = msg.sender;
    }
}


contract Marriage is Owned {
    string public partner1;
    string public partner2;
    uint public marriageDate;
    string public marriageStatus;
    string public vows;

    Event[] public majorEvents;

    struct Event {
        uint date;
        string name;
        string description;
    }

    modifier areMarried {
        require(keccak256(marriageStatus) == keccak256("Married"));
        _;
    }

    //Set Owner
    function Marriage(address _owner) {
        owner = _owner;
    }

    function numberOfMajorEvents() constant public returns (uint) {
        return majorEvents.length;
    }

    // Create initial marriage contract
    function createMarriage(string _partner1, string _partner2, string _vows) onlyOwner {
        require(majorEvents.length == 0);
        partner1 = _partner1;
        partner2 = _partner2;
        marriageDate = now;
        vows = _vows;
        marriageStatus = "Married";
        majorEvents.push(Event(now, "Marriage", vows));
        MajorEvent("Marrigage", vows);
    }

    // Set the marriage status if it changes
    function setStatus(string status) onlyOwner {
        marriageStatus = status;
        setMajorEvent("Changed Status", status);
    }

    // Set the IPFS hash of the image of the couple
    function setMajorEvent(string name, string description) onlyOwner areMarried {
        majorEvents.push(Event(now, name, description));
        MajorEvent(name, description);
    }

    // Declare event
    event MajorEvent(string name, string description);
}
