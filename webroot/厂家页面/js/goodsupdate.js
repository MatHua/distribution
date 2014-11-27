function Goodsupdate() {
    var SubmitOrHidden = function(evt){
        evt = window.event || evt;
        if(evt.keyCode==13){//如果取到的键值是回车
            $("#go").click();
        }
    }
    window.document.onkeydown=SubmitOrHidden;
    var key="id",order="asc";//排序值以及升降序
    var keyword='';
    /*
     allpage:全部的界面数
     curpage:当前的页码
     groupsize:页码组的大小*/
    var allpage,curpage=1,groupsize=6;
    reloadgoods();
    $(document).on("click","input[type=checkbox]", function () {
        console.log(select_id);
    })
    function createpagenum(){
            var pagehtml="";
            pagehtml+='<a class="pre_page" title="上一页">上一页</a>';
            for(var i= 1,j=0;i<=allpage;i++,j++)
            {
                if(i==curpage)
                    pagehtml+='<a class="cur">'+i+'</a>';
                else
                pagehtml+='<a class="page_i">'+i+'</a>';
                if(j==1&&allpage>=5){
                    pagehtml+='<span>...</span>';
                    pagehtml+='<a class="page_i">'+allpage+'</a>';
                    break;
                }
            }
        pagehtml+='<a class="next_page" title="下一页">下一页</a>';
        $(".pagenum").html(pagehtml);
        var pagelist=document.getElementsByClassName("pagenum");
        var list_a=pagelist[0].getElementsByTagName("a");
        var list_span=pagelist[0].getElementsByTagName("span");
        var O_WIDTH=2;
        for(var i=0;i<list_a.length;i++)
            O_WIDTH+=list_a[i].offsetWidth+10;
        O_WIDTH+=list_span[0]?list_span[0].offsetWidth+20:0;
        pagelist[0].style.width=O_WIDTH+'px';
    }
   $("#go").click(function () {
       if($("#searchkey").val()!=''){
           keyword=$("#searchkey").val();
           reloadgoods();
           createpagenum();
       }
   })
    $("#creat_new_good").click(function () {
        $("#Menuarea").load("new_goods.html #goods_edit_area",newgoods);
    })
    $("#sort_cb,#sort_fx,#sort_ls,#sort_sj#sort_sj,#sort_lb").click(function () {
        $("#sort_cb,#sort_fx,#sort_ls,#sort_sj#sort_sj,#sort_lb").find("span").css("background-image",'url("images/Sort_up.png")');
        if($(this).attr("data-status")=='up')
        {
            $(this).find("span").css("background-image",'url("images/Sort_down.png")');
            $(this).attr("data-status","down");
            order="desc";
            key=$(this).attr("name");
            curpage=1;
            reloadgoods();
            createpagenum();
        }
        else if($(this).attr("data-status")=='down')
        {
            $(this).find("span").css("background-image",'url("images/Sort_up.png")');
            $(this).attr("data-status","up");
            order="asc";
            curpage=1;
            key=$(this).attr("name");
            reloadgoods();
            createpagenum();
        }
    })
    $(document).on('click','#good-detailchange',function () {
        $("#Menuarea").load("new_goods.html #goods_edit_area",newgoods);
    })
   $(document).on('click','.next_page',function () {
      if(curpage!=allpage)
      {
          curpage++;
          reloadgoods();
          createpagenum();
      }
   })
   $(document).on('click','.pre_page',function () {
        if(curpage>1)
        {
            curpage--;
            reloadgoods();
            createpagenum();
        }
    })
    $(document).on('click','.page_i',function(){
        curpage=parseInt(this.innerHTML);
        reloadgoods();
        createpagenum();
    })
    $(document).on('click','#good-change', function () {
        var url=LOCALHOST+'/index.php/Factory/editProduct';
        if($(this).html()=="修改")
        {
            $(this).parent().prev().find("input[name!=id]").removeAttr("disabled").css("background-color","#FFF").css("border","1px solid #ccc");
            $(this).html("保存");
        }
        else if($(this).html()=="保存")
        {
            var input=$(this).parent().prev().find("input");
            input.removeAttr("disabled").css("background-color","#e0e0e0").css("border","none");
            $(this).html("修改");
            var name=input[0].value;
            var id=parseInt(input[1].value);
            var cost_price=parseInt(input[2].value);
            var distribution_price=parseInt(input[3].value);
            var salesman_price=parseInt(input[4].value);
            var left=parseInt(input[5].value);
            var json = '{"productInfo": { "id": id, "name": name, "model": "贺卡", "introduction": "描述", "cost_price":cost_price, "distribution_price": distribution_price, "salesman_price": salesman_price, "producer": "某地", "has_sale": "10", "left": left, "status": "1"}, "specImage": [ { "id": "4", "product_id": "5", "spec_1": "黄色", "spec_2": "10寸", "image_1": "42422223.png" }, { "id": "5", "product_id": "6", "spec_1": "蓝色", "spec_2": "11寸", "image_1": "43245532.png" } ] }';
            var url=LOCALHOST+"/index.php/Factory/editProduct";
            $.post(url,
                {
                    json:json
                },
                function(data){
                    alert("修改成功");
                });
        }
    })
    function reloadgoods() {
        var str="",str1,str2="",str3;
        $("#List_goodsarea").html("");
        str1='';
        select_id=[];
        str3='</div></div><div class="Goods_oprate"><a id="good-detailchange">详情修改</a><a id="good-change">修改</a></div></div></div>';
        var url = LOCALHOST+"/index.php/Factory/getAllProduct";
        $.ajax(url, {
            data: {
                "keyword":keyword,
                "key":key,
                "order":order,
                "current_page":curpage,
                "page_size":groupsize
            },
            type:"POST",
            dataType: 'json',
            crossDomain: true,
            success: function (json){
                allpage=json.data.page_amount;
                for(var j= 0,i=0;json.data[j]!=null;i++,j++){
                        str2+='<div class="Goodsbox clearfix"><div class="checkbox"><input type="checkbox" name="sp" onclick="checkItem(this, this.name)" value="'+json.data[j].id+'" /></div><div class="boxborder"><div class="Goods_img"><img src="images/'+json.data[j].specImage[0].image_1+'"/><span>销量：'+json.data[j].has_sale+'</span></div><div class="Goods_detail"><div class="row"><label>商品名：</label><input id="good_name_'+i+'"'+' type="text"'+'value="'+json.data[j].name+'"><label>商品ID：</label><input name="id" id="good_id_'+i+'"'+' type="text"'+'value="'+json.data[j].id+'"></div><div class="row"><label>成本价：￥</label><input id="goods_cb_'+i+'"'+' type="text"'+'value="'+json.data[j].cost_price+'"><label>分销价：￥</label><input id="goods_fx_'+i+'"'+' type="text"'+'value="'+json.data[j].distributor_price+'"><label>零售价：￥</label><input id="goods_ls_'+i+'"'+' type="text"'+'value="'+json.data[j].salesman_price+'"><label>库存：</label><input id="goods_kc_'+i+'"'+' type="text"'+'value="'+json.data[j].left+'">';
                        str+=str1+str2+str3;
                        str2="";
                    }
                $("#List_goodsarea").html(str);
                $(".row input").attr("disabled","disabled");
                $("#Allselect").click(function(){
                var all=document.getElementsByName('sp');
                    all[0].click();
                })
                createpagenum();
            }
        })
    }
}
