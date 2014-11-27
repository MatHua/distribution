function Countupadate() {
    var truename,phone,company,address,bank_card,id,description,sex;

    var url = LOCALHOST+"/index.php/Factory/getFactoryInfo";
    $.ajax(url, {
        data: {
        },
        type:"POST",
        dataType: 'json',
        crossDomain: true,
        success: function (data) {
            var json=data;
            $("#My_company").val(json.data[0].company);
            $("#My_duty").val(json.data[0].truename);
            id=json.data[0].id;
            $("#My_adress").val(json.data[0].address);
            $("#My_call").val(json.data[0].phone);
            $("#textbox").html(json.data[0].description);
            }
    })
    $("#Countarea input").attr("disabled","disabled");
    $("#textbox").attr("contenteditable","fales");
    $("#Countbtn").click(function(){
        if($(this).html()=="保存")
        {
            $("#Countarea input").removeAttr("disabled");
            $("#textbox").removeAttr("contenteditable");
            $("#Countarea input").attr("disabled","disabled");
            $("#textbox").attr("contenteditable","fales");
            $("#textbox").css('background','#ebebe4');
            truename= $("#My_duty").val();
            phone=$("#My_call").val();
            company=$("#My_company").val();
            address=$("#My_adress").val();
            sex='男';
            description=$("#testbox").html();
            var url=LOCALHOST+"/index.php/Factory/editFactoryInfo";
            $.ajax(url, {
                data: {
                    "id":id,
                    "phone":phone,
                    "company":company,
                    "address":address,
                    "description":description,
                    "truename":truename,
                    "sex":sex
                },
                type:"POST",
                dataType: 'json',
                crossDomain: true,
                success: function (data) {
                    alert("修改成功");
                }
            })
            $(this).html("修改");
        }
        else
        {
            $("#Countarea input").removeAttr("disabled");
            $("#textbox").removeAttr("contenteditable");
            $("#textbox").attr("contenteditable","true");
            $("#textbox").css('background','#FFF');
            $(this).html("保存");
        }
    })
    function removeHTMLTag(str) {
        str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
        str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
        //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
        str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
        return str;
    }
}