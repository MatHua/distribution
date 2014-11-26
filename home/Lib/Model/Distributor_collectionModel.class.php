<?php
class Distributor_collectionModel extends RelationModel{

	protected $_link=array(
			'productInfo'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'Product_info',
					'foreign_key'=>'product_id',
					'mapping_fields'=>'name,salesman_price,distributor_price,has_sale,left',
					'as_fields'=>'name:product_name,salesman_price,distributor_price,has_sale,left',
			),
			'specImage'=> array(
					'mapping_type'=>BELONGS_TO,
					'class_name'=>'spec_image',
					'foreign_key'=>'spec_id',
					'mapping_fields'=>'spec_1,spec_2,spec_3,image_1',
					'as_fields'=>'spec_1,spec_2,spec_3,image_1',
			)
	);
	
}