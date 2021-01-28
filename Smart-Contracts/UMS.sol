pragma solidity 0.6.6;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";


contract Amrita_University_Managment is ERC721 {
    
     address private owner; // varaible declaration for storing address of the owner
    uint256 private fileId;// varaible declaration for storing  file id 
    uint private randNonce = 3000000000; // varaible declaration for randNonce
    uint private Token; // varaible declaration for token storing
    
     struct  student_details{ //structure declaration for student
         string  ipfsHash;  // varaible declaration for ipfsHash in structure
         string  filetype; // varaible declaration for filetype
         string student_name; // varaible declaration for student name
         string student_course; // varaible declaration for course
         string student_branch; // varaible declaration for branch
         //string student_section; // varaible declaration for section
         string student_id; // varaible declaration for id
         string subject_name; // varaible declaration for subject name
    }student_details private sm;
 mapping (uint256 => student_details) files; //mapping student_details
 
 struct teacher_details{ //structure declaration for teacher
         string ipfsHash; // varaible declaration for ipfsHash in structure
         string filetype;  // varaible declaration for filetype
         string teacher_name; // varaible declaration for teacher_name
         string course;    // varaible declaration for course
         string branch;    // varaible declaration for branch
         //string section;    // varaible declaration for section
         string subject_name;  // varaible declaration for subject_name
    }teacher_details private tm;   
 mapping (uint256 => teacher_details) filet; //mapping teacher_details
 
 // constructor for the contract with token name and symbol
 constructor() ERC721("AMRITA-UNIVERSITY-MANAGMENT","AUM") public {
        owner=msg.sender;
        
    }   
    
    
    //modifier declaration
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }
    
    
     function randModulus() internal view returns(uint)
    {
        	return uint(keccak256(abi.encodePacked(now,block.difficulty,msg.sender)))%randNonce;
    }
    
     
     //function Calling for minting
     function mintMyToken(uint256 _Fileid) internal  returns (uint256)   {
        //Fl.fileowner=msg.sender;
        //Calling the Built-in function in ERC721
        _mint(msg.sender,_Fileid);
        return(_Fileid);
        
        
    }
    //function Calling for burning
      function burnMyToken(uint256 _FileID) external {
          if((ownerOf(_FileID)== msg.sender||msg.sender == owner))
         {
         //Calling the Built-in function in ERC721
        _burn(fileId);
         }
        
    }
    
//function Calling for getting fileid
    function getfileId()external view returns(uint){
        return Token;
    }
   
 //function Calling for sending student details
 function sendStudentDetails(string calldata hash,string calldata filetype,string calldata name,string calldata stdid,string calldata course ,string calldata branch,string calldata subname) external {
   sm.ipfsHash = hash;
   sm.filetype=filetype;
   sm.student_name=name;
   sm.student_id=stdid;
   
   sm.student_course=course;
   sm.student_branch=branch;
   sm.subject_name=subname;
   fileId=randModulus();
   Token=mintMyToken(fileId);
   files[Token]=sm;
 }
//function Calling for geting student details
 function getStudentDetails(uint256 _FID) external view returns (string memory,string memory,string memory,string memory,string memory,string memory,string memory) {
     if(_exists(_FID)&&(ownerOf(_FID)== msg.sender||msg.sender == owner)){
     
     student_details memory ssm = files[_FID];
        return (ssm.ipfsHash,ssm.filetype,ssm.student_name,ssm.student_id,ssm.student_course,ssm.student_branch,ssm.subject_name);
     }
     else
     {
            string memory ipfsHash='No-Data';
            string memory filetype='No-Data';
            string memory student_name='No-Data';
            string memory student_id='No-Data';
            string memory student_course='No-Data';
            string memory student_branch='No-Data';
            string memory subject_name='No-Data';
            
            
            return(ipfsHash,filetype,student_name,student_id,student_course,student_branch,subject_name);
     }
   
 }
 //function Calling for sending teacher details
 
  function sendTeacherDetails(string calldata hash,string calldata filetype,string calldata teacher,string calldata course ,string calldata branch,string calldata subname) external {
        
        
        tm.ipfsHash = hash;
        tm.filetype=filetype;
        tm.teacher_name=teacher;
        
        tm.course=course;
        tm.branch=branch;
        tm.subject_name=subname;
        fileId=randModulus();
        Token=mintMyToken(fileId);
        filet[Token]=tm;
        
      
  }
  
  //function Calling for get teacher details
   function getTeacherDetails(uint256 _fileId) external view returns (string memory,string memory,string memory,string memory,string memory,string memory) {
     if(_exists(_fileId)&&(ownerOf(_fileId)== msg.sender||msg.sender == owner)){
     
     teacher_details memory ttm = filet[_fileId];
        return (ttm.ipfsHash,ttm.filetype,ttm.teacher_name,ttm.course,ttm.branch,ttm.subject_name);
     }
     else
     {
            string memory ipfsHash='No-Data';
            string memory filetype='No-Data';
            string memory teacher_name='No-Data';
            string memory course='No-Data';
            string memory branch='No-Data';
            string memory subject_name='No-Data';
            
            
            return(ipfsHash,filetype,teacher_name,course,branch,subject_name);
     }
   
 }
  
  
  
}
