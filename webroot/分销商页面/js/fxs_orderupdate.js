function Orderupadate(){
    var selectid=new Array();
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
            confirm('是否删除选择的分销商？');
        }
        else
        {alert("请点击选择要操作的分销商");}
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
