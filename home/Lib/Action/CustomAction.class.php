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
		$ret = D('Product_info')->relation('specImage')->field('id,name,stock,has_sale,introduction,description')->where($map)->find();
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
	 	$orderBI['custom_id'] = $_SESSION['userId'];

	 	$model = D('Order_list');
	 	$productModel = M('Product_info');
	 	$model->startTrans();	//开启事务模式
	 	$productModel->startTrans();
	 	
	 	foreach ($orderPt as $key => $vo){
		 	//过滤值
		 	unset($orderBI['unit_price']);
		 	unset($orderBI['total_price']);
			unset($orderPt['unit_price']);
			unset($orderPt['total_price']);
			$_POST = array_merge($orderBI,$vo);

			if(!$model->create()){
				$model->rollback();
				$productModel->rollback();
				$this->ajaxReturn(0,$model->getError(),0);
			}
			if(!($model->add())){
				$model->rollback();
				$productModel->rollback();
				$this->ajaxReturn(0,'由于某些未知原因，下单失败！',0);
			}
			
			//更新该商品的库存以及销售量
			$data['has_sale'] = array('exp','has_sale+'.$vo['amount']);
			$data['stock'] = array('exp','stock-'.$vo['amount']);
			$ret = $productModel->where(array('id'=>$vo['product_id']))->save($data);
	
			if(!$ret){
				$model->rollback();
				$productModel->rollback();
				$this->ajaxReturn(0,'由于某些未知原因，下单失败！',0);
			}
	 	}
	 	$productModel->commit();
	 	$model->commit();
	 	$this->ajaxReturn(0,'下单成功！',1);
	} 
	
	/**
	 * 获取客户自己的订单
	 * 【POST】
	 * @param $status(可选) 订单状态：0：失败、1：未付款、2：已付款、3：货到付款、4：已付款、5、配送中、6：成功
	 * 
	 * @param $searchTime(可选) ： 查询几个月的订单    1：一个月的订单、3：三个月的订单、6：半年的订单
	 *
	 * @param $current_page（可选） ： 第几页
     * @param $page_size（可选）：每页显示数
	 */
	public function getOrder(){
		
		$limit = null;
		$page = 0;   //是否分页
		$where['custom_id'] = $_SESSION['userId'];
		
		//组合显示条数limit,分页
    	if( isset($_POST['current_page']) && $_POST['current_page'] != '' && isset($_POST['page_size']) && $_POST['page_size'] != '' ){
    		$offset = ($_POST['current_page']-1)*$_POST['page_size'];
    		$length = $_POST['page_size'];
    		$page = 1;
    	}
		
		if( isset($_POST['status']) && $_POST['status'] != '')
			$where['status'] = $_POST['status'];
		
		if( $_POST['searchTime'] != '' || isset($_POST['searchTime']) ){
			$where['cTime'] = array('between',array(strtotime(date('Y-m-d'))-$_POST['searchTime']*2592000+86400,strtotime(date('Y-m-d'))+86400 ));
		}
		
		$amount = D('Order_list')->where( $where )->getField('count(*)');
		$ret = D('Order_list')->relation('productInfo,specImage')->field('amount,id,unit_price,total_price,address,phone,name,status,cTime,order_id')->where( $where )->select();
		
		$arr = array();
		foreach ($ret as $key => $value){
			$orderId = $value['order_id'];
			$arr[$orderId][] = $value;
		}
		$data = array_slice($arr,$offset,$length,true);
		
		//获取页数
		if($page)			$data['page_amount'] = ceil($amount/$_POST['page_size']);	//有符合条件的商品,分页
		else if($amount)	$data['page_amount'] = 1;	//有符合条件的商品,但不分页
		else				$data['page_amount'] = 0;	//没有符合条件的商品
		
		$this->ajaxReturn($data,"获取成功",1);
	}
	
}