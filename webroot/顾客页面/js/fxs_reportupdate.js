function Reportupadate(){
    var Report_title=document.getElementById('Report_title').getElementsByTagName('a');
    var cell=document.getElementById('Report_list').getElementsByClassName('cell');
    for(var i=0;i<Report_title.length;i++)
        for(var j=0;j<cell.length/Report_title.length;j++)
        {
            var TITLEWIDTH=Report_title[i].offsetWidth;
            if(i<Report_title.length-1)
                TITLEWIDTH--;
            cell[(i+j*Report_title.length)].style.width=TITLEWIDTH+'px';
        }
    $(".cell").mouseover(function(){
        var that=this;
        var txt=$(this).html();
        this.setAttribute('title',txt);
    })
}