<?php if (!defined('THINK_PATH')) exit();?>

<html>
<head>
<script type="text/javascript" src="__PUBLIC__/admin/js/jquery.js"></script>
 <SCRIPT src="http://code.jquery.com/jquery-1.10.2.min.js"></SCRIPT> 
<!-- <script type="text/javascript" src="__PUBLIC__/js/jquery-1.9.1.js"></script> -->
<script>
  $(document).ready(function(){
  $("button").click(function(){
	 var productInfo = new Array();
	 productInfo['name'] = "商品3";
	 productInfo['model'] = "贺卡";
	 productInfo['introduction'] = "描述";
	 productInfo['cost_price'] = "10";
	 productInfo['distribution_price'] = "12";
	 productInfo['salesman_price'] = "20";
	 productInfo['producer'] = "某地";
	 productInfo['has_sale'] = "10";
	 productInfo['left'] = "0";
	 productInfo['status'] = "1";
	 
	 
	 	var specImage = new Array();
		
		var specImage1 = new Array(); 
		 specImage1['spec_1'] = "黄色";
		 specImage1['spec_2'] ="10寸";
		 specImage1['image_1'] = "12433253.png";
		 specImage[0] = specImage1;
	 
	/*  var specImage = new Array();
	
	 specImage[0]['spec_1'] = "黄色";
	 specImage[0]['spec_2'] ="10寸";
	 specImage[0]['image_1'] = "12433253.png";

	 specImage[1]['spec_1'] = "黑色";
	 specImage[1]['spec_2'] ="11寸";
	 specImage[1]['image_1'] = "324242.png"; */
	
	 var data = '{"productInfo":{"id":"13","name":"u5546u54c113","model":"u8d3au5361","introduction":"u63cfu8ff0","cost_price":"10","distribution_price":"12","salesman_price":"20","producer":"u67d0u5730","has_sale":"10","left":"0","status":"1"},"specImage":[{"id":"19","spec_1":"u84ddu8272","spec_2":"10u5bf8","image_1":"42422223.png"},{"id":"20","spec_1":"u9ed1u8272","spec_2":"11u5bf8","image_1":"43245532.png"}]}';
    $.post("http://3.xiong607.sinaapp.com/index.php/Factory/getAllProduct",
    {
       
    },
    function(data){
    	//alert(data);
    });
  });
});  
/* function ajax(url, fnSucc, fnFaild)
{
    //1.创建Ajax对象
    if(window.XMLHttpRequest)
    {
        var oAjax=new XMLHttpRequest();
    }
    else
    {
        var oAjax=new ActiveXObject("Microsoft.XMLHTTP");
    }
    
    //2.连接服务器（打开和服务器的连接）
    oAjax.open('GET', url, true);
    
    
    //3.发送
    oAjax.send();
    
    //4.接收
    oAjax.onreadystatechange=function ()
    {
        if(oAjax.readyState==4)
        {
            if(oAjax.status==200)
            {
                //alert('成功了：'+oAjax.responseText);
                fnSucc(oAjax.responseText);
            }
            else
            {
                //alert('失败了');
                if(fnFaild)
                {
                    fnFaild();
                }
            }
        }
    };
}


$("button").click(function(){
    ajax("test?t=" + new Date().getTime(),function(str){
        alert(str);
    },function(){
        alert("bai");
    });
}); */
</script>

</head>
<body>

  <div ><h2>Let AJAX change this text</h2></div>
<button >通过 AJAX 改变内容</button>  
<form method="post"  enctype="multipart/form-data" action="__APP__/Factory/test">
<input type="file"  name="test">
<input type="text" name="text1">
<input type="file"  name="files">
<input type="submit"  value="提交">
</form>
			
			      
</body>
</html>