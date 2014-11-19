<?php
class Order_listModel extends RelationModel{

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
			
			'customInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Custom_info',
					'foreign_key'=>'custom_id',
					'mapping_fields'=>'truename,phone',
					'as_fields'=>'truename:custom_name,phone:custom_phone',
			),
			'productInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Product_info',
					'foreign_key'=>'product_id',
					'mapping_fields'=>'name,salesman_price,distributor_price,cost_price',
					'as_fields'=>'name:product_name',
			),
	
	);
	
	protected $_validate=array(		
			
	);
	
}