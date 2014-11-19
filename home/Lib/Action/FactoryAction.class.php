<?php
//厂商的控制器
class FactoryAction extends Action {
    /**
     * 获取所有的商品列表
     * [POST]
     * @param $key（可选） : 排序的字段
     * @param $order （可选）: 升序或者降序
     * 
     * @param $page（可选） ： 第几页
     * @param $page_size（可选）：每页显示数
     * 
     * @param $keyword（可选）：关键字 
     */
	public function getAllProduct(){
		
		$order = $limit = $where = null;
		$page = 0;   //是否分页
		//组合字段升降序order
		if( isset($_POST['key']) && $_POST['key'] != '' && isset($_POST['order']) && $_POST['order'] != '' ){
			$order = $_POST['key'].' '.$_POST['order'];
		}
	    
		//搜索关键字
		if( isset($_POST['keyword']) && $_POST['keyword'] != ''){
			$where['id'] = array('like','%'.$_POST['keyword'].'%');
			$where['name'] = array('like','%'.$_POST['keyword'].'%');
		}
		
		//组合显示条数limit
		if( isset($_POST['current_page']) && $_POST['current_page'] != '' && isset($_POST['page_size']) && $_POST['page_size'] != '' ){
			$limit = ($_POST['current_page']-1)*$_POST['page_size'].','.$_POST['page_size'];
			$page = 1;
		}
		
		$ret1 = D('Product_info')->relation('specImage')->where( $where )->order( $order )->select();
		$ret = D('Product_info')->relation('specImage')->where( $where )->order( $order )->limit( $limit )->select();
	
		//获取页数
		if($page)		$ret['page_amount'] = ceil(count($ret1)/$_POST['page_size']);
		else 			$ret['page_amount'] = 1;
 		
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
     * [get]
     * @param status : 订单的状态
     * 			值	   ：  0：已下单、1：未付款、2：已付款、3：货到付款、4：配送中、5：成功
     */
    public function getAllOrder(){
    	$map = array();
    	if(!isset($_GET['status']))	//没有status参数说明要获取所有的分销商（包括未审核以及已经审核通过的）
    		$map = null;
    	else
    		$map['status'] = $_GET['status'];	//获取指定未审核的或者已经审核的
    	$ret = D('Order_list')->relation(array('distributorInfo','customInfo'))->where($map)->select();
    	$this->ajaxReturn($ret,'获取订单成功',1);
    }
    
    /**
     * 增加或者修改订单信息
     */
    public function editOrder(){
    		
    }
    
    /**
     * 删除订单
     * [get]
     * @param $id : 订单ID
     */
    public function delOrder(){
    	if ($_POST['id'] == '' || !isset($_POST['id'])) {
    		$this->ajaxReturn(0,'参数不正确',0);
    	}
    	$ids = json_decode($_POST['id'],true);
    	$ret = M('Order_list')->where(array('id'=>array('in',$ids)))->delete();
    	if( $ret )
	    	$this->ajaxReturn( 0,'删除成功',1 );
	    else
	    	$this->ajaxReturn( 0,'删除失败',0 );
    }
    
    /**
     *	获取某个时间段总体销售额业绩
     *  [post]
     *  @param $unit : 统计单位
     *  		       值    ： month（月）、day（天）
     *  @param $start  : 选择查询开始日期(2014-09、2014-09-10)
     *  @param $end    : 选择查询结束日期
     */
    public function getAllSale(){
    	
    	if(($_POST['unit'] != 'day' && $_POST['unit'] != 'month') || $_POST['start'] == '' || !isset($_POST['start']) || $_POST['end'] == '' || !isset($_POST['end'])){
    		$this->ajaxReturn(0, '参数不正确', 0);
    	}
    	
    	$map['confirm'] = array('eq',1);	//订单厂家已经确认
    	$map['cTime'] = array('between',array(strtotime($_POST['start']),strtotime($_POST['end'])+86400));
    	
    	if($_POST['unit'] == 'day'){		//以周为单位
    		$ret = D('Order_list')->field('SUM(total_price) sale_price,FROM_UNIXTIME(cTime, "%Y-%m-%d") day')->where($map)->order('sale_price desc')->group('day')->select();
    	}else{		//以月为单位
    		$ret = D('Order_list')->field('SUM(total_price) sale_price,FROM_UNIXTIME(cTime, "%Y-%m") month')->where($map)->order('sale_price desc')->group('month')->select();
    	}
    	  	
    	$this->ajaxReturn($ret,'获取总销售额业绩成功',1);
    }
    
    /**
     * 获取各个商品某个时间段的总销售额和件数(月业绩、日业绩)
     *  [post]
     *  
     *  @param $start  : 选择查询开始日期(2014-09、2014-09-10)
     *  @param $end    : 选择查询结束日期
     */
    public function getProductSale(){
    	if( $_POST['start'] == '' || !isset($_POST['start']) || $_POST['end'] == '' || !isset($_POST['end'])){
    		$this->ajaxReturn(0, '参数不正确', 0);
    	}
   
    	$map['confirm'] = array('eq',1);	//订单厂家已经确认
    	$map['cTime'] = array('between',array(strtotime($_POST['start']),strtotime($_POST['end'])+86400));
    	 
  		$ret = D('Order_list')->relation('productInfo')->field('SUM(total_price) sale_price,SUM(amount) sale_amount,product_id')->where($map)->order('sale_amount desc')->group('product_id')->select();
    	
    	$this->ajaxReturn($ret,'各个商品的总销售情况成功',1);
    }
    
    /**
     *	获取某个商品   各个分销商的总销售额以及总销售件数 
     *  获取各个分销商的总销售情况
     *	[post]
     *  @param $product_id（可选） : 商品的ID
     *  @param $start  : 选择查询开始日期(2014-09、2014-09-10)
     *  @param $end    : 选择查询结束日期
     */
    public function getDistributorSale(){
    	if( $_POST['start'] == '' || !isset($_POST['start']) || $_POST['end'] == '' || !isset($_POST['end'])){
    		$this->ajaxReturn(0, '参数不正确', 0);
    	}
    	
    	//获取某商品在各个分销商的总销售额以及销售件数
    	if( $_POST['product_id'] != '' && isset($_POST['product_id']) ){
    		$map['product_id'] = $_POST['product_id'];
    		$map['confirm'] = array('eq',1);	//订单厂家已经确认
    		$map['cTime'] = array('between',array(strtotime($_POST['start']),strtotime($_POST['end'])+86400));
    		
    		$ret = D('Order_list')->relation(array('distributorInfo','productInfo'))->field('SUM(total_price) sale_price,SUM(amount) sale_amount,distributor_id,product_id')->where($map)->order('sale_amount desc')->group('distributor_id')->select();
    		$this->ajaxReturn($ret,'获取该商品在各个分销商的销售情况成功',1);
    	}
    	
    	//获取各个分销商的总销售情况
    	$map['confirm'] = array('eq',1);	//订单厂家已经确认
    	$map['cTime'] = array('between',array(strtotime($_POST['start']),strtotime($_POST['end'])+86400));
    	
    	$ret = D('Order_list')->relation('distributorInfo')->field('SUM(total_price) sale_price,distributor_id')->where($map)->group('distributor_id')->order('sale_price desc')->select();
    		 
    	$this->ajaxReturn($ret,'获取各个分销商的销售情况成功',1);
    	
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
