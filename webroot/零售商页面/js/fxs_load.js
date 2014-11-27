//服务器地址
var LOCALHOST="http://localhost/bowen/bowen";
var select_id=[];
function checkAll(e, itemName)
{
    var aa = document.getElementsByName(itemName);    //获取全选复选框
    for (var i=0; i<aa.length; i++){
        aa[i].checked = e.checked;    //改变所有复选框的状态为全选复选框的状态
        select_id.push(aa[i].value);
    }
}
function checkItem(e, allName)
{
    var all = document.getElementsByName(allName)[0];    //获取全选复选框
    if(!e.checked){
        //没被选中全选复选框置为false;
        all.checked = false;
    } else {
        select_id.push(e.value);
        //选中，遍历数组
        var aa = document.getElementsByName(e.name);
        for (var i=1; i<aa.length; i++)
            //只要数组中有一个没有选中返回。假如所有的都是选中状态就将全选复选框选中;
            if(!aa[i].checked) return;
        all.checked = true;
    }
}
$(document).ready(function(){
    var menu=document.getElementById('Menu');
    var menu_list=menu.getElementsByTagName('a');
    for(var i=0;i<menu_list.length;i++) {
        menu_list[i].onclick = function () {
            menu_select = this;
            for (var j = 0; j < menu_list.length; j++) {
                menu_list[j].style.backgroundImage = "url(images/Menu_unclick.png)";
                menu_list[j].parentNode.style.backgroundImage = "url(images/Menu_unclick.png)";
            }
            menu_select.style.backgroundImage = "url(images/Menu_click.png)";
            menu_select.parentNode.style.backgroundImage = "url(images/Menu_click.png)";
        }
        menu_list[i].onmouseover = function () {
            this.style.backgroundImage = "url(images/Menu_hover.png)";
            menu_select.style.backgroundImage = "url(images/Menu_click.png)";
        }
        menu_list[i].onmouseout = function () {
            if (this != menu_select)
                this.style.backgroundImage = "url(images/Menu_unclick.png)";
        }
    }
    $.ajaxSetup ({cache: false});
        $("#Menu a").click(function(){
            var source=("fxs_"+this.id+".html").toLowerCase();
            var part=('#'+this.name);
            //load the change.html into the source page
            if(part=="#Partnerarea")
                $("#Menuarea").load(source+' '+part,Partnerupadate);
            else if(part=="#Orderarea")
                $("#Menuarea").load(source+' '+part,Orderupadate);
            else if(part=="#Reportarea")
                $("#Menuarea").load(source+' '+part,Reportupadate);
            else if(part=="#Countarea")
                $("#Menuarea").load(source+' '+part,Countupadate);
            else
                $("#Menuarea").load(source+' '+part,Goodsupdate);
        })
         $("#Goods_Management").click();
       // $("#Partner_Management").click();
         // $("#Order_Detail").click();
//        $("#Sales_Report").click();
         // $("#Count_Management").click();
})