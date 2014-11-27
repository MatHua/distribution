window.onload=function() {
var input = document.getElementById('userpassword');
input.onfocus = function () {
if (this.value == '密码/Password') {
this.value = '';
this.type = 'password';
       }
    }
input.onblur = function () {
   if (!this.value) {
    this.type = 'text';
    this.value = '密码/Password';
        }
    }
var loginuserid=document.getElementById('username');
loginuserid.onfocus=function(){
if(this.value=='用户名/Username'){
this.value='';
  }
 };
loginuserid.onblur=function(){
if(!this.value){
this.value = '用户名/Username';
  }
 }
}