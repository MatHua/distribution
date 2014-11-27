function Reportupadate(){
    var url=LOCALHOST+"/index.php/Factory/getProductSale";
    var Report_title=document.getElementById('Report_title').getElementsByTagName('a');
    var cell=document.getElementById('Report_list').getElementsByClassName('cell');
    var cur_page=1,page_amount=1,page_size=29;
    for(var i=0;i<Report_title.length;i++)
        for(var j=0;j<cell.length/Report_title.length;j++)
        {
            var TITLEWIDTH=Report_title[i].offsetWidth;
            if(i<Report_title.length-1)
                TITLEWIDTH--;
            cell[(i+j*Report_title.length)].style.width=TITLEWIDTH+'px';
        }
    function reloadreport(){
    $.post(url,
        {
                "start":"2014-11-10",
                "end":"2014-11-22"
        },
        function(json){
            var k=0;
            var cell=$("#Report_list .cell");
                for(var j=0;j<json.data.length&&k<page_size;j++,k++){
                    cell[k*8+0].innerHTML=json.data[j].id;
                    cell[k*8+1].innerHTML=json.data[j].product_name;
                    cell[k*8+2].innerHTML=json.data[j].sale_amount;
                    cell[k*8+3].innerHTML=json.data[j].sale_price;
                    cell[k*8+4].innerHTML=json.data[j].salesman_price;
                    cell[k*8+5].innerHTML=json.data[j].sale_price*json.data[j].sale_amount;
                    cell[k*8+6].innerHTML=json.data[j].salesman_price*json.data[j].sale_amount;
                    cell[k*8+7].innerHTML=json.data[j].salesman_price*json.data[j].sale_amount-json.data[j].sale_price*json.data[j].sale_amount;
                }
            }
        );
    }
    reloadreport();
    createpagenum();
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
    $(".cell").mouseover(function(){
        var that=this;
        var txt=$(this).html();
        this.setAttribute('title',txt);
    })
}