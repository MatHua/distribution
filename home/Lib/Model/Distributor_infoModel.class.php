<?php
class Distributor_infoModel extends RelationModel{

	protected $_link=array(
			
	);
	protected $_validate=array(
			array('username','require','用户名必须填写!',0),
			array('password','/^[A-Za-z0-9]+$/','密码格式错误',0,'regex',0),
			array('truename','require','姓名必须填写!',1),
			array('sex','require','性别必须填写!',0),
			array('QQ','require','QQ必须填写!',0),
			array('identify','require','身份证必须填写!',0),
			array('bank_card','require','银行卡号必须填写!',1),
			array('phone','require','联系方式必须填写!',1),
			array('company','require','分销商单位必须填写!',1),
			array('address','require','所在地必须填写!',1),
			array('username','/^[a-zA-Z][a-zA-Z0-9_]{4,15}$/','用户名只允许字母开头，由下划线、字母、数字组成',0,'regex',3),
			array('password','/^[A-Za-z0-9]+$/','密码格式错误',0,'regex',3),
			array('phone','/^(1(([35][0-9])|(47)|[8][0126789]))\d{8}$/','联系方式格式不正确',0,'regex',3),
			array('truename','/^[\x{4e00}-\x{9fa5}]+$/u','姓名格式错误',0,'regex',3)
			
	);
	
}