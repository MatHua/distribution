<?php
class Product_infoModel extends RelationModel{

	protected $_link=array(
		
			'spec_image'=> array(  
     			'mapping_type'=>HAS_MANY,
          		'class_name'=>'spec_image',
          		'foreign_key'=>'product_id',		
			)
			 
	);
	
}