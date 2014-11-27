WINDOWWIDTH=1000;
//    兼容IE操作
if(!document.getElementsByClassName)//判断浏览器是否支持这个方法
{
    document.getElementsByClassName=function(cname){
        var selected=new Array();
        var alltag=document.getElementsByTagName("*");//获取所有标签
        for(var i=0;i<alltag.length;i++)
        {
            var t=alltag[i];
            alert(t.className);
            if(t.className==cname)    //比较标签的class与所要查找的class是否相同
            {
                selected.push(t);          //将相同的存入数组
            }
        }
        return selected;
    }
}
$(document).ready(function(){
    var container=document.getElementById('Container');
    var header=document.getElementById('Header');
    var footer=document.getElementById('Footer');
    var menu=document.getElementById('Menu');
    var menu_list=menu.getElementsByTagName('a');
    var menu_select=null;
    container.style.width=WINDOWWIDTH+'px';
    header.style.width=WINDOWWIDTH+'px';
    footer.style.width=WINDOWWIDTH+'px';
    menu.style.width=(WINDOWWIDTH-2)+'px';
    for(var i=0;i<menu_list.length;i++)
    {
        menu_list[i].style.width=(WINDOWWIDTH-7)/5+'px';
        menu_list[i].onclick=function(){
            menu_select=this;
            for(var j=0;j<menu_list.length;j++)
            {
                menu_list[j].style.backgroundImage="url(images/Menu_unclick.png)";
                menu_list[j].parentNode.style.backgroundImage="url(images/Menu_unclick.png)";
            }
            menu_select.style.backgroundImage="url(images/Menu_click.png)";
            menu_select.parentNode.style.backgroundImage="url(images/Menu_click.png)";
        }
        menu_list[i].onmouseover= function () {
            this.style.backgroundImage="url(images/Menu_hover.png)";
            menu_select.style.backgroundImage="url(images/Menu_click.png)";
        }
        menu_list[i].onmouseout= function () {
            if(this!=menu_select)
            this.style.backgroundImage="url(images/Menu_unclick.png)";
        }
    }

})