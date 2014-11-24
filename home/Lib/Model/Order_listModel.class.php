<?php
class Order_listModel extends RelationModel{
	
	protected $cost_price;	//成本价
	protected $distributor_price;	//分销商价格
	protected $salesman_price;	//销售员价格
	protected $left; //库存量
	
	protected $_link=array(
	
			'distributorInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Distributor_info',
					'foreign_key'=>'distributor_id',
					'mapping_fields'=>'truename,address,phone,company',
					'as_fields'=>'truename:distributor_name,address:distributor_address,phone:distributor_phone,company:distributor_company',
			),
			 
			'salesmanInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Salesman_info',
					'foreign_key'=>'salesman_id',
					'mapping_fields'=>'truename,address,phone',
					'as_fields'=>'truename:salesman_name,address:salesman_address,phone:salesman_phone',
			),
			
			/* 'customInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Delivery_info',
					'foreign_key'=>'delivery_id',
					'mapping_fields'=>'name,phone',
					'as_fields'=>'name:custom_name,phone:custom_phone',
			), */
			
			'productInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Product_info',
					'foreign_key'=>'product_id',
					'mapping_fields'=>'name,salesman_price,distributor_price,cost_price',
					'as_fields'=>'name:product_name',
			),
			
			'specImage'=> array(  
     			'mapping_type'=>BELONGS_TO,
          		'class_name'=>'spec_image',
          		'foreign_key'=>'spec_id',
				'mapping_fields'=>'spec_1,spec_2,spec_3,image_1',
				'as_fields'=>'spec_1,spec_2,spec_3,image_1',
			)
	);
	
	protected $_validate=array(		
		
		 	array('id','require','没有标识符!',1,'regex',2),	//修改时需要
			
			array('order_id','require','没有订单ID!',1,'regex',1),
			array('custom_id','require','没有客户ID!',1,'regex',1),
			array('distributor_id','require','没有分销商ID!',1,'regex',3),
			array('salesman_id','require','没有销售员ID!',1,'regex',3),
			array('product_id','require','没有商品ID!',1,'regex',3),
			array('spec_id','require','没有商品规格!',1,'regex',3),
			array('amount','require','没有填商品件数!',1,'regex',3),
			//array('unit_price','require','没有商品单价!',1,'regex',3),
			//array('total_price','require','没有商品总价!',1,'regex',3),
			array('address','require','没有送货地址!',1,'regex',1),
			array('phone','require','没有送货地址!',1,'regex',1),
			array('name','require','没有送货地址!',1,'regex',1),
			array('status','require','没有订单状态!',1,'regex',1),
			array('cTime','require','没有下单时间!',1,'regex',1),
			
		  	array('product_id','checkProductId','没有此商品ID!',1,'callback',3),
 		  	array('amount','checkAmount','没有库存了!',1,'callback',3),   
 		
			array('salesman_profit','checkFactoryProfit','恶意传值!',0,'callback',3),		//不能传值
			array('distributor_profit','checkDistributorProfit','恶意传值!',0,'callback',3),   	  //不能传值
	
			
	);
	
	protected $_auto= array( 
		 	array('unit_price','getUnitPrice',3,'callback'),
			array('total_price','getTotalPrice',3,'callback'),
			
			array('factory_profit','getFactoryProfit',3,'callback'),
			array('distributor_profit','getDistributorProfit',3,'callback'), 
	);  
	
	protected function getUnitPrice(){
		if( isset($_POST['unit_price']) ){
			$this->salesman_price = $_POST['unit_price'];
		}	
		return $this->salesman_price; 
	}
	
	protected function getTotalPrice(){
		if( isset($_POST['total_price']) ){	
			return $_POST['total_price'];
		}								
		return $this->salesman_price*$_POST['amount'];
	}
	
	protected function checkProductId(){
		
		$ret = M('Product_info')->field('cost_price,distributor_price,salesman_price,left,status')->where(array('id'=>$_POST['product_id']))->find();
		$amount = 0;
		if (isset($_POST['id']) && $_POST['id'] != '') {
			$amount = M('Order_list')->where('id='.$_POST['id'])->getField('amount');
		}

		if ($ret) {
			if ($ret['status'] == 0) return false;	//检查商品是否下架
			$this->cost_price = $ret['cost_price'];
			$this->distributor_price = $ret['distributor_price'];
			$this->salesman_price = $ret['salesman_price'];
			$this->left = $ret['left']+$amount;
			return true;
		}else 
			
			return false;
	}

	protected function checkAmount(){
		if($this->left < $_POST['amount'])	return false;
		else	return true;
	}
	

	protected function checkSalesmanProfit(){
		if( isset($_POST['salesman_profit']) )	return false;
	}
	
	protected function checkdistributorProfit(){
		if( isset($_POST['distributor_profit']) )	return false;
	}
	
	protected function getFactoryProfit(){
		return ($this->distributor_price-$this->cost_price)*$_POST['amount'];
	}
	
	protected function getdistributorProfit(){
		if($_POST['distributor_id'] != ''){
			return ($this->salesman_price-$this->distributor_price)*$_POST['amount'];
		}else 
			return 0;
	}

}