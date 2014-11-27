function Orderupadate(){
    var selectid=new Array();
    var url=LOCALHOST+"/index.php/Factory/getAllOrder";
    var cur_page=1,page_size=29,page_amount,allrecord=0;
    function reloadorder(){
    $.post(url,
        {
            data:{
                "key":"id",
                "order":"desc",
                "current_page":cur_page,
                "page_size":page_size
            }
        },
        function(data){
            var json=data.data;
            var k=0;
            page_amount=parseInt(json.page_amount);
            var cell=$("#order_list .cell");
            for(var i in json)
            {
                for(var j=0;j<json[i].length&&k<page_size;j++,k++){
                    cell[k*8+0].innerHTML=json[i][j].order_id;
                    cell[k*8+1].innerHTML=json[i][j].product_name;
                    cell[k*8+1].id=json[i][j].product_id;
                    cell[k*8+2].innerHTML=json[i][j].amount;
                    cell[k*8+3].innerHTML=json[i][j].unit_price;
                    cell[k*8+4].innerHTML=json[i][j].total_price;
                    cell[k*8+5].innerHTML=json[i][j].distributor_address;
                    cell[k*8+6].innerHTML=getLocalTime(json[i][j].cTime);
                    cell[k*8+7].innerHTML="货到付款";
                }
            }
        });
    }
    console.log(allrecord);
    page_amount=allrecord/page_size+1;
    reloadorder();
    createpagenum();
    $(document).on('click','.next_page',function () {
        if(curpage!=allpage)
        {
            curpage++;
            reloadorder();
            createpagenum();
        }
    })
    $(document).on('click','.pre_page',function () {
        if(curpage>1)
        {
            curpage--;
            reloadorder();
            createpagenum();
        }
    })
    $(document).on('click','.page_i',function(){
        curpage=parseInt(this.innerHTML);
        reloadorder();
        createpagenum();
    })
    function createpagenum(){
        var pagehtml="";
        pagehtml+='<a class="pre_page" title="上一页">上一页</a>';
        for(var i=1,j=0;i<=page_amount;i++,j++)
        {
            if(i==cur_page)
                pagehtml+='<a class="cur">'+i+'</a>';
            else
                pagehtml+='<a class="page_i">'+i+'</a>';
            if(j==1&&page_amount>=5){
                pagehtml+='<span>...</span>';
                pagehtml+='<a class="page_i">'+page_amount+'</a>';
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
    var order_title=document.getElementById('order_title').getElementsByTagName('a');
    var cell=document.getElementById('order_list').getElementsByClassName('cell');
    for(var i=0;i<order_title.length;i++)
        for(var j=0;j<cell.length/order_title.length;j++)
        {
            var TITLEWIDTH=order_title[i].clientWidth||order_title[i].offsetWidth;
            if(i<order_title.length-1)
                TITLEWIDTH--;
            cell[(i+j*order_title.length)].style.width=TITLEWIDTH+'px';
        }
    $(".cell").mouseover(function(){
        var that=this;
        var txt=$(this).html();
        this.setAttribute('title',txt);
    })
    $("#order_sc").click(function () {
        if(selectid!=''){
            confirm('是否删除选择的订单？');
        }
        else
        {alert("请点击选择要操作的订单");}
    })
    $("#order_list .row").click(function () {
        var cell=$(this).find(".cell");
        if(cell[0].innerHTML!='') {
            cell.toggleClass("rowselect");
            if(cell.hasClass("rowselect")){
                selectid.push(cell[0].innerHTML);
                $("#order-id").val(cell[0].innerHTML);
                $("#order-name").val(cell[1].innerHTML);
                $("#order-num").val(cell[2].innerHTML);
                $("#order-partner-id").val(cell[3].innerHTML);
                $("#order-partner-name").val(cell[4].innerHTML);
                $("#order-partner-adress").val(cell[5].innerHTML);
                $("#order-time").val(cell[6].innerHTML);
                $("#order-status").val(cell[7].innerHTML);
                $(".Order_sc_btn ").show();
            }
            else{
                $("#order-id").val('');
                $("#order-name").val('');
                $("#order-num").val('');
                $("#order-partner-id").val('');
                $("#order-partner-name").val('');
                $("#order-partner-adress").val('');
                $("#order-time").val('');
                $("#order-status").val('');
                $(".Order_sc_btn ").hide();
                if(selectid.indexOf(cell[0].innerHTML)!=-1){
                    if(selectid.indexOf(cell[0].innerHTML)==0)
                        selectid.shift();
                    else
                        selectid.splice(selectid.indexOf(cell[0].innerHTML),1);
                }
            }
        }
    })
}
