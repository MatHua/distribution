<?php
class Factory_infoModel extends RelationModel{

	protected $_link=array(
			
	);
	protected $_validate=array(
	
			array('truename','require','厂家负责人必须填写!',1),
			array('sex','require','性别必须填写!',1),
			array('phone','require','联系方式必须填写!',1),
			array('company','require','公司必须填写!',1),
			array('address','require','厂家地址必须填写!',1),
			array('username','^[a-zA-Z][a-zA-Z0-9_]{4,15}$','只允许字母开头，由下划线、字母、数字组成',0,'regex',3),
			array('password','/^[A-Za-z0-9]+$/','密码格式错误',0,'regex',3),
			array('phone','/^(1(([35][0-9])|(47)|[8][0126789]))\d{8}$/','联系方式格式不正确',0,'regex',3),
			array('truename','/[\u4e00-\u9fa5]/','姓名格式错误',0,'regex',3)
			
			
	);
	
}