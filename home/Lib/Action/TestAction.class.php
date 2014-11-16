<?php
class TestAction extends Action{
	public function index(){
		$this->display();
	}
	
	public function test(){
		$arr = array('id'=>'1','name'=>'姓名');
		$this->ajaxReturn($arr,'测试',0);
	}
	
	public function arrToJson(){
		$productInfo = array();
		$productInfo['id'] = '11';
		$productInfo['name'] = "商品11";
		$productInfo['model'] = "贺卡";
		$productInfo['introduction'] = "描述";
		$productInfo['cost_price'] = "10";
		$productInfo['distribution_price'] = "12";
		$productInfo['salesman_price'] = "20";
		$productInfo['producer'] = "某地";
		$productInfo['has_sale'] = "10";
		$productInfo['left'] = "0";
		$productInfo['status'] = "1";
		 
		/* $specImage = array();
		$specImage[0]['id'] = "15";
		$specImage[0]['spec_1'] = "红色";
		$specImage[0]['spec_2'] = "10寸";
		$specImage[0]['image_1'] = "42422223.png";
		$specImage[1]['id'] = "16";
		$specImage[1]['spec_1'] = "黑色";
		$specImage[1]['spec_2'] = "11寸";
		$specImage[1]['image_1'] = "43245532.png"; 
		$json = array(
			'productInfo'=>$productInfo,
			'specImage'=>$specImage	
		);  */
		$json = array(
				'productInfo'=>$productInfo
		);
		echo json_encode($json);
		
	}
	
	public function test1(){
		$id[] = '12';
		$id[] = '13';
		echo json_encode($id);
	}
}