<?php 
class LoginAction extends Action{
    public function  login(){
        $this->display();
    }
    public function dologin(){
        $username=$_POST['username'];
    	$password=$_POST['password'];
        $level = $_POST['level'];
    	
         $manager=M('custom_info');
         $where['username']=$username;
         $where['password']=$password;
        
         $arr=$manager->field('id')->where($where)->find();
         
         if($arr){
         	$_SESSION['username']=$username;
         	$_SESSION['id']=$arr['id']; 
         	$this->ajaxReturn('','success',1);
             
         } 
         else{
         	$this->error('数据库连接失败，用户不存在或密码错误！');
         } 
         } 
}
?>