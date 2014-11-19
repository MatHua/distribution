<?php 
class LoginAction extends Action{
    public function  login(){
        $this->display();  
    }
    public function dologin(){
        $username=$_POST['username'];
    	$password=$_POST['password'];
        $level=$_POST['level'];
        if(!isset($_POST['username']) || $_POST['username'] ==''
			||!isset($_POST['password']) || $_POST['password'] ==''
			||!isset($_POST['level']) || $_POST['level'] =='')
        {		
        	$this->ajaxReturn('','Input is NULL',0);
        }
        else {
           switch ($level){     		
        	  	case 1:$manager=M('factory_info');	 break;
        	  	case 2:$manager=M('disributor_info');break;
        	  	case 3:$manager=M('salesman_info');  break;
       	      	case 4:$manager=M('custom_info');	 break;	
               }	
         		
               $where['username']=$username;
         	   $where['password']=$password;
        
         	   $arr=$manager->field('id')->where($where)->find();
         
        	   if($arr){
         	 		$_SESSION['username']=$username;
         			$_SESSION['id']=$arr['id']; 
         			$this->ajaxReturn('','success',1);
             
         		   } 
        		 else{
         			$this->ajaxReturn('','faile',0);
         		} 
            }   
     }
         
}
?>