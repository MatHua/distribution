<?php
//厂商的控制器
class FactoryAction extends Action {
    /**
     * 获取所有的商品列表
     * [get]
     */
	public function getAllProduct(){
		
		$key = !empty($_GET['key']) ? $_GET['key'].' ' : null;	//排序的字段
		$order = !empty($_GET['order']) && !empty($key) ? $key.$_GET['order'] : null;	//将字段以及排序的方式组合起来
	
		$ret = D('Product_info')->relation('specImage')->order( $order )->select();
		
		$this->ajaxReturn($ret,"获取成功",1);
    }
    
    /**
     * 获取指定商品ID的详细信息
     * [get]
     */
    public function getProductDetail(){
    	if(!isset($_GET['id']) || $_GET['id'] == '')
    		$this->ajaxReturn(0, '没有指定商品ID', 0);
    	$ret = D('Product_info')->relation('specImage')->find($_GET['id']);
    	$this->ajaxReturn($ret, '获取成功', 1);
    }
    
    /**
     * 删除产品信息
     * [post]
     * @param  id: json格式(如：["12","13"])
     */
    public function delProduct(){
	    if( $_POST['id'] != null && $_POST['id'] != '' ){
	    	$ids = json_decode($_POST['id'],true);
			if( M('Product_info')->where(array('id'=>array('in',$ids)))->delete() )
	    		$this->ajaxReturn( 0,'删除成功',1 );
	    	else
	    		$this->ajaxReturn( 0,'删除失败',0 );
	    }
	    else{
	    	$this->ajaxReturn( 0,'没有指定删除的商品ID',0 );
	    }
    } 
   
    /**
     * 增加或者修改产品信息
     */
    public function editProduct(){
    	
	 	if(!isset($_POST['json']) || $_POST['json'] == ''){
	 		$this->ajaxReturn(0,"数据格式不正确",0);
	 	}
	 	
	 	$jsonArr = json_decode($_POST['json'],true);
	 	$productInfo = $jsonArr['productInfo'];
	 	$specImage = $jsonArr['specImage'];
	 	
    	//增加商品基础信息以及规格照片
    	if(!isset($productInfo['id']) || $productInfo['id'] == ''){		
    		$lastId = M('Product_info')->add($productInfo);
    		if($lastId){
    			foreach ($specImage as $vo){
    				$vo['product_id'] = $lastId;
    				
    				$ret = M('Spec_image')->add($vo);
    				if(!$ret){
    					$this->ajaxReturn(0,"增加商品信息失败！",0);	//使用回调函数
    				}
  					//事务处理
    			}
    			$this->ajaxReturn(0,"增加商品信息成功！",1);
 
    		}else{
    			$this->ajaxReturn(0,"增加商品信息失败！",0);
    		}
    	}
    	
    	//修改商品信息
    	$flag = 0;	//标志是否成功！
    	$ret = M('Product_info')->save($productInfo);
    	if($ret)	$flag = 1;
    	foreach ($specImage as $vo){	
    		$ret = M('Spec_image')->save($vo);
    		if ($ret) {
    			$flag = 1;
    		}
    	} 
    	if ($flag) {
    		$this->ajaxReturn(0,"修改商品信息成功！",1);
    	}else{
    		$this->ajaxReturn(0,"修改商品信息失败！",0);
    	}
    	
    }
    
    /**
     * 实现post数据自动验证，自动完成插入或者修改
     * @param  $model 模型名
     * @param  $returnInfo 错误或成功返回的信息
     * @param  $return 返回新增或者修改时是否直接输出还是返回，默认不返回
     */
    public function addOrEdit($model,$returnInfo,$return=FALSE){
    	$ret = D($model);
    	
    	if( !isset($_POST['id']) || $_POST['id'] == '' ){
			
    		if( !$ret->create() ){
    			if($return)	return false;
    			$this->ajaxReturn(0, $ret->getError(), 0);
    		}
    
    		$lastId = $ret->add();
    
    		if( $lastId != false ){
    			if($return)	return true;
    			$this->ajaxReturn(0,'添加'.$returnInfo.'成功！',1);
    		}else{
    			if($return)	return false;
    			$this->ajaxReturn(0,'添加'.$returnInfo.'失败！',0);
    		}
    	}else{
    
    		if( !$ret->create() ){
    			if($return)	return false;
    			$this->ajaxReturn(0, $ret->getError(), 0);
    		}
    			
    		$lastId = $ret->save();
    
    		if( $lastId != false ){
    			if($return)	return true;
    			$this->ajaxReturn(0,'修改'.$returnInfo.'成功！',0);
    		}else{
    			if($return)	return false;
    			$this->ajaxReturn(0,'修改'.$returnInfo.'失败！',0);
    		}
    	}
    }
    
    
  	/**
  	 * 单个上传图片
  	 * 返回：图片的存储名字
  	 */
    public function uploadImg(){
    	$result = $this->upload();
    	if($result['status']){	//上传成功
	    	$this->ajaxReturn($result['info'][0]['savename'],"图片上传成功",1);
    	}else{
    		$this->ajaxReturn(0,$result['info'],0);
    	}
    }
    
    /**
     * 新增分销商
     */
    public function editDistributorInfo(){
    	//新增分销商信息
    	if($_POST['id'] == '' || !isset($_POST['id'])){
    		$_POST['username'] = $_POST['password'] = 'user'.time();	//默认时间戳
    		$_POST['status'] = '1';	  //厂家新增分销商默认审核通过
    	}
   		//修改分销商信息
   		$this->addOrEdit('Distributor_info', '分销商');
    	
    }
    
    /**
     * 获取所有分销商
     * [get]
     * @param $status： 是否审核通过（可选）    
     * 				值：0（未审核） 1（审核通过） null（所有）
     */
    public function getAllDistributor(){
    	$where = array();
    	if(!isset($_GET['status']))	//没有status参数说明要获取所有的分销商（包括未审核以及已经审核通过的）
    		$where = null;
    	else 
    		$where['status'] = $_GET['status'];	//获取指定未审核的或者已经审核的
    	
    	$ret = M('Distributor_info')->where($where)->select();
    	$this->ajaxReturn($ret,'获取所有分销商信息成功！',1);
    }
    
    /**
     * 获取厂家信息
     */
    public function getFactoryInfo(){
    	$ret = M('factory_info')->select();
    	$this->ajaxReturn($ret,"获取厂家信息成功",1);
    }
    
    /**
     * 修改厂家信息
     */
    public function editFactoryInfo(){
    	if($_POST['id'] == '' || !isset($_POST['id'])){
    		$this->ajaxReturn(0, '数据有误，请正确填写！', 0);
    	}
    	$this->addOrEdit('Factory_info', '厂家信息');
    }
    
    /**
     * 获取所有的订单
     */
    public function getAllOrder(){
    	$ret = D('Order_list')->relation(array('distributorInfo','customInfo'))->select();
    	$this->ajaxReturn($ret,'获取订单成功',1);
    }
    
    /**
     * 增加或者修改订单信息
     */
    public function editOrder(){
    		
    }
    
    /**
     *	获取所有分销商的业绩(包括总销售价钱、总销售数量)
     */
    public function getDistributorSale(){
    	
    	if($_POST['start'] != '' && isset($_POST['start']) && $_POST['end'] != '' && isset($_POST['end'])){
    		$map['cTime'] = array('between',array($_POST['start'],$_POST['end']));
    	}
    	$map['status'] = array('gt',1);	//说明订单已经付款或者选择货到付款
    	$ret = D('Order_list')->relation('distributorInfo')->field('SUM(total_price) sale_price,SUM(amount) sale_amount,distributor_id')->where($map)->group('distributor_id')->select();
    	$this->ajaxReturn($ret,'获取分销商业绩成功',1);
    }
    
    /**
     * 上传
     */
    Public function upload($maxSize="3145728", $allowExts=array('bmp','jpg','jpeg','png','gif'),$savePath="./Public/Uploads/",$uploadReplace=true){
    	import('ORG.Net.UploadFile');
    	$upload = new UploadFile();// 实例化上传类
    	$upload->maxSize  = $maxSize ;// 设置附件上传大小
    	$upload->allowExts  = $allowExts;// 设置附件上传类型
    	$upload->savePath =  $savePath;// 设置附件上传目录
    	$upload->uploadReplace = $uploadReplace;	//同名覆盖
    	if(!$upload->upload()) {// 上传错误提示错误信息
    		$result = array('status'=>0,'info'=>$upload->getErrorMsg());
    		return $result;
    	}else{	// 上传成功 获取上传文件信息
    		$result = array('status'=>1,'info'=>$upload->getUploadFileInfo());
    		return $result;
    	}
    }
    
}
