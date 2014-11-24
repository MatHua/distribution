<?php
class CustomAction extends Action{
	/**
	 * 客户获取商品信息
	 * 【post】
	 * @param $id 商品ID
	 */
	public function getProductDetail(){
		if(!isset($_POST['id']) || $_POST['id'] == '')
			$this->ajaxReturn(0,'没有选择查看那个商品',0);
		$map['id'] = $_POST['id'];
		$ret = D('Product_info')->relation('specImage')->field('id,name,left,has_sale,introduction,description')->where($map)->find();
		if($ret)
			$this->ajaxReturn($ret,'获取商品信息成功！',1);
		else
			$this->ajaxReturn(0,'没有改商品信息！',0);
	}
	
	/**
	 * 客户购买接口
	 * 【post】	  
	 * @param $json:
	 * baseInfo:custom_id、distributor_id、salesman_id、address、phone、name、status
	 * productList:product_id、spec_id、amount
	 *
	 */
	public function purchase(){
		if(!isset($_POST['json']) || $_POST['json'] == '')
			$this->ajaxReturn(0,'数据有误！',0);

		$jsonArr = json_decode($_POST['json'],true);
	 	$orderBI = $jsonArr['baseInfo'];
	 	$orderPt = $jsonArr['productList'];
	 	if(!isset($orderBI) || !isset($orderPt))
	 		$this->ajaxReturn(0,'数据有误！！',0);
	 	
	 	if($orderBI['status'] != 0 && $orderBI['status'] != 2)	//下单时订单一定要是未付款或者货到付款
			$this->ajaxReturn(0,'非法传值!',0);
	 	
	 	$orderBI['cTime'] = time();
	 	$orderBI['order_id'] = time();

	 	$model = D('Order_list');
	 	$model->startTrans();	//开启事务模式
	 	
	 	foreach ($orderPt as $key => $vo){
		 	//过滤值
		 	unset($orderBI['unit_price']);
		 	unset($orderBI['total_price']);
			unset($orderPt['unit_price']);
			unset($orderPt['total_price']);
			$_POST = array_merge($orderBI,$vo);

			if(!$model->create()){
				$model->rollback();
				$this->ajaxReturn(0,$model->getError(),0);
			}
			if(!($model->add())){
				$model->rollback();
				$this->ajaxReturn(0,'由于某些未知原因，下单失败！',0);
			}
	 	}
	 	
	 	$model->commit();
	 	$this->ajaxReturn(0,'下单成功！',1);
	} 
}