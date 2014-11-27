function Goodsupdate() {
    var key="id",order="asc";//排序值以及升降序
    var keyword='';
    /*
     allpage:全部的界面数
     curpage:当前的页码
     groupsize:页码组的大小*/
    var allpage,curpage=1,groupsize=6;
    reloadgoods();
    $("#good-detailchange").click(function(){
        if(confirm("是否要下架此商品？")){

        }
    })
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
    $("#Partner_yj").click(function () {
        $("#Partner_yj").addClass('Partner_click');
        $("#Partner_xx").removeClass('Partner_click');
        $("#List_sc_goodsarea").hide();
        $("#List_goodsarea").show();
    })
    $("#Partner_xx").click(function () {
        $("#Partner_xx").addClass('Partner_click');
        $("#Partner_yj").removeClass('Partner_click');
        $("#List_goodsarea").hide();
        $("#List_sc_goodsarea").show();
    })
   $("#go").click(function () {
       if($("#searchkey").val()!=''){
           keyword=$("#searchkey").val();
           reloadgoods();
           createpagenum();
       }
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
    function reloadgoods() {
        var str="",str1,str2="",str3;
        $("#List_goodsarea").html("");
        str1='';
        select_id=[];
        str3='</div></div><div class="Goods_oprate"><a id="good-detailchange">上架</a><a id="good-change">详情</a></div></div></div>';
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
                console.log(json);
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
