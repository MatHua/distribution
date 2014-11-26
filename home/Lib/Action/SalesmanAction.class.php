<?php
class SalesmanAction extends Action{
	private $salesmanId = 1;
	private $distributorId = 1;

	public function getCustomInfo(){
		$ret = M('Salesman_info')->where(array('id'=>$this->salesmanId))->select();
		if($ret)
			$this->ajaxReturn($ret,'获取信息成功！',1);
		else 
			$this->ajaxReturn(0,'查无本用户相关信息',0);	
	}
	
	/**
     * 获取所有的商品列表
     * [POST]
     * @param $key（可选） : 排序的字段('salesman_price','distributor_price','has_sale','cTime')
     * @param $order （可选）: 升序或者降序('desc','asc')
     * 
     * @param $current_page（可选） ： 第几页
     * @param $page_size（可选）：每页显示数
     * 
     * @param $keyword（可选）：关键字 ('salesman_price'、'distributor_price'、'name')
     * 
     */
	public function getAllProduct(){
		
		$order = $limit = $where = null;
		$page = 0;   //是否分页
		//组合字段升降序order
		if( isset($_POST['key']) && $_POST['key'] != '' && isset($_POST['order']) && $_POST['order'] != '' ){
			$keyRange = array('salesman_price','distributor_price','has_sale','cTime');
			$orderRange = array('desc','asc');
			if(!in_array($_POST['key'],$keyRange) || !in_array($_POST['order'],$orderRange))
				$this->ajaxReturn(0,'排序错误！',0);
			$order = $_POST['key'].' '.$_POST['order'];
		}
	    
		$map['product_status'] = 1;
		$map['distributor_id'] = $this->distributorId;
		//搜索关键字
		if( isset($_POST['keyword']) && $_POST['keyword'] != ''){
			$where['product_info.salesman_price'] = array('like','%'.$_POST['keyword'].'%');
			$where['product_info.distributor_price'] = array('like','%'.$_POST['keyword'].'%');			
			$where['product_info.name'] = array('like','%'.$_POST['keyword'].'%');
			$where['_logic'] = 'or';
		}
		
		//组合显示条数limit,分页
		if( isset($_POST['current_page']) && $_POST['current_page'] != '' && isset($_POST['page_size']) && $_POST['page_size'] != '' ){
			$limit = ($_POST['current_page']-1)*$_POST['page_size'].','.$_POST['page_size'];
			$page = 1;
		}
		
		$amount = D('Distributor_collection')->where( $where )->getField('count(*)');
		$ret = D('Distributor_collection')->relation('productInfo')->field('distributor_collection.cTime,product_id,distributor_id')->where( $where )->order( $order )->limit( $limit )->select();
	
		//获取页数
	 	if($page)			$ret['page_amount'] = ceil($amount/$_POST['page_size']);	//有符合条件的商品,分页
		else if($amount)	$ret['page_amount'] = 1;	//有符合条件的商品,但不分页
		else				$ret['page_amount'] = 0;	//没有符合条件的商品 

		$this->ajaxReturn($ret,"获取成功",1);
    }
}