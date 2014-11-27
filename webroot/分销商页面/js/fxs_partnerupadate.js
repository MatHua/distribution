function Partnerupadate() {
    var partener_title=document.getElementById('xx_title').getElementsByTagName('a');
    var cell=document.getElementById('xx_list').getElementsByClassName('cell');
    var selectid=new Array();
    var partner_num;
    /*allrecord:全部的记录条数
     allpage:全部的界面数
     curpage:当前的页码
     groupsize:页码组的大小*/
    var allpage,curpage,groupsize=29,allrecord,goodsid;
    for(var i=0;i<partener_title.length;i++)
        for(var j=0;j<cell.length/partener_title.length;j++)
        {
            var TITLEWIDTH=partener_title[i].clientWidth||partener_title[i].offsetWidth;
            if(i<partener_title.length-1)
                TITLEWIDTH--;
            cell[(i+j*partener_title.length)].style.width=TITLEWIDTH+'px';
        }
    $("#Partner_xx").click(function () {
        $("#Partner_xx").addClass('Partner_click');
        $("#Partner_yj").removeClass('Partner_click');
        $(".Partner_yj").hide();
        var url = LOCALHOST+"/index.php/Factory/getAllDistributor";
        $.ajax(url, {
            data: {
            },
            type:"POST",
            dataType: 'json',
            crossDomain: true,
            success: function (data) {
                var json=data;
                var cell=$("#xx_list .cell");
                for(var i=0;i<cell.length/6&&i<json.data.length;i++){
                    cell[i*6+0].innerHTML=json.data[i].id;
                    cell[i*6+0].setAttribute('data-time',json.data[i].cTime);
                    cell[i*6+0].id="cell"+i;
                    cell[i*6+1].innerHTML=json.data[i].truename;
                    cell[i*6+2].innerHTML=json.data[i].company;
                    cell[i*6+3].innerHTML=json.data[i].address;
                    cell[i*6+4].innerHTML=json.data[i].phone;
                    cell[i*6+5].innerHTML=json.data[i].bank_card;
                    partner_num=i;
                }
            }
        })
        function getLocalTime(nS) {
            return new Date(parseInt(nS) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
        }
        $("#xx_list .row").click(function () {
        var cell=$(this).find(".cell");
        if(cell[0].innerHTML!='') {
            cell.toggleClass("rowselect");
            if(cell.hasClass("rowselect")){
                selectid.push(cell[0].innerHTML);
                $("#xx_id").val(cell[0].innerHTML);
                $("#xx_name").val(cell[1].innerHTML);
                $("#xx_dw").val(cell[2].innerHTML);
                $("#xx_szd").val(cell[3].innerHTML);
                $("#xx_lx").val(cell[4].innerHTML);
                $("#xx_zh").val(cell[5].innerHTML);
                $("#xx_sj").val(getLocalTime(cell[0].getAttribute('data-time')));
            }
            else{
                $("#xx_id").val('');
                $("#xx_name").val('');
                $("#xx_dw").val('');
                $("#xx_szd").val('');
                $("#xx_lx").val('');
                $("#xx_zh").val('');
                $("#xx_sj").val('');
                if(selectid.indexOf(cell[0].innerHTML)!=-1){
                    if(selectid.indexOf(cell[0].innerHTML)==0)
                    selectid.shift();
                    else
                    selectid.splice(selectid.indexOf(cell[0].innerHTML),1);
                }
            }
        }
    })
        $("#sc").click(function () {
            if(selectid!=''){
                confirm('是否删除选择的分销商？');
            }
            else
            {alert("请点击选择要操作的分销商");}
        })
        $("#qx").click(function () {
           var j=0;
           for(var i=0;i<=partner_num;i++){
               if(! $('#cell'+i).parent().find('.cell').hasClass("rowselect"))
               {
                   $('#cell'+i).parent().find('.cell').addClass("rowselect");
                   j=1;
                   selectid.push((i+1).toString());}
           }
            if(j==0){
                for(var i=0;i<=partner_num;i++){
                    $('#cell'+i).parent().find('.cell').removeClass("rowselect");
                }
                selectid=[];
            }
            console.log(selectid);
        })
    $(".Partner_xx").show();
    })
    $("#Partner_yj").click(function () {
        $("#Partner_yj").addClass('Partner_click');
        $("#Partner_xx").removeClass('Partner_click');
        $(".Partner_xx").hide();
        $(".Partner_yj").show();
        var myChart1 = echarts.init(document.getElementById('day_yj'));
        var myChart2 = echarts.init(document.getElementById('month_yj'));
        var option1 = {
            title : {
                text: '日销量',
                subtext: ''
            },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:[]
            },
            toolbox: {
                show : true,
                feature : {
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : ['26','27','28','29','30','1','2']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    axisLabel : {
                        formatter: '{value} 件/天'
                    }
                }
            ],
            series : [
                {
                    name:'最高销量',
                    type:'line',
                    data:[400, 501, 153, 300, 200, 450, 720],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大销量'},
                            {type : 'min', name: '最小销量'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均销量'}
                        ]
                    }
                }
            ]
        };
        var option2 = {
            title : {
                text: '周销量',
                subtext: ''
            },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['本周','上周']
            },
            toolbox: {
                show : true,
                feature : {
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : ['周一','周二','周三','周四','周五','周六','周日']
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    axisLabel : {
                        formatter: '{value} 件/周'
                    }
                }
            ],
            series : [
                {
                    name:'上周',
                    type:'line',
                    data:[4220, 4411, 1000, 3800, 2880, 4450, 4755],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大销量'},
                            {type : 'min', name: '最小销量'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name : '平均销量'}
                        ]
                    }
                },
                {
                    name:'本周',
                    type:'line',
                    data:[4000, 5011, 1453, 3500, 2800, 4250, 4720],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大销量'},
                            {type : 'min', name: '最小销量'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均销量'}
                        ]
                    }
                }
            ]
        };

        myChart1.setOption(option1);
        myChart2.setOption(option2);
    })
    $("#xz").click(function () {
        $(".Addbox,#Mask").show();
        $("#Add_cance").click(function () {
            $(".Addbox").hide();
            var input=document.getElementsByClassName('Inputbox')[0].getElementsByTagName('input');
            for(var i=0;i<input.length;i++)
                input[i].value='';
        })
    })
    $(".cell").mouseover(function(){
        var that=this;
        var txt=$(this).html();
        this.setAttribute('title',txt);
    })
    $("#Partner_xx").click();
}