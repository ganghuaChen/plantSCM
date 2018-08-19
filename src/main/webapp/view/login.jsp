<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>进销存管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">  
    <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script> 
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-table.min.css"  /> 
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>
     
    <script src="../js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-select.min.css"  /> 
    <script src="../js/defaults-zh_CN.min.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>  
    <link  rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css">  
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
    <link href="../css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="../js/tabulator.min.js"></script>
    <link href="../css/login.css" rel="stylesheet">
    <script src="../js/path.js"></script>
   <style type="text/css">
   *{
    padding: 0;
    margin: 0;
}

body{
    font-family: Georgia, serif;
    background: url(../img/loginbackground.jpg) no-repeat;
    background-size:100% 100%;  
    background-attachment: fixed;

}

#container {
    height: 100%;
    width: 100%;
}


.login-title h1{
    color:black;
    margin:5px auto;
    text-align: center;
}


.block-display{
    display: block;
    height: 380px;
    width: 460px;
    padding: 30px 50px 50px 50px;/*边距*/
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    position:absolute;
    margin:auto;
    background-color: #fff;
    border: 1px solid #dadada;
    border-radius: 15px;
}

.login-title{
    text-align: center;
    padding-bottom: 20px;
    border-bottom: 1px #ddd solid;/*下边框（下划线）*/
}

/*输入框的div*/
.input-form{

    background: #fff;
    border: #ccc solid 1px;
    border-radius: 10px;
    font-size: 25px;
    height: 46px;
    line-height: 46px;
    position: relative;
    margin: 20px;
    
}

.input-form input{
    border:none;
    text-align: left;
    font-size: 18px;
    outline: none;
    margin: 1px;
    height: 30px;
}

.input-form span{
    position: relative;
}

.password-icon{

}


.notificationMsg {
    position: absolute;
    right:10px;
    font-size:8px;
}

.focus {
    border: 1px solid #6b93f2;
}

.invalid {
    border: 1px solid #d16d62;
}

.error-msg{
    background-color:yellowgreen;
    font-size:12px;
    color: #fff;
    right: 30px;
    top: -5px;
    height: 0px;
    padding: 5px;
    border-radius: 4px;
    overflow:hidden; 

} 

.hide{
    display: none;
}
.btn-wrap{
    margin-top:20px;
    /* text-align: center;
    position: absolute; */
}

.btn-default {
    /* display: inline-block;
    border: none;
    border-radius: 15px;
    height: 200;
    font-size: 30px; */
    height: 46px;
    width: 180px;
    line-height: 46px;
    background-color: #fff;
    border: #ccc solid 1px;
    border-radius: 10px;
    margin: 40px auto;
    color: greenyellow;
    
}

.btn-default a {
    display: block;
    color: black;
    font-size:20px;
    text-align: center;
    text-decoration: none;
    margin: 3px;
}

.login-error-div{
    width:150px;
    position: relative;
    text-align: center;
    margin: 5px auto;
}

.login-error-div span {
    background-color: #d16d62;
    font-size: 12px;
    color: #fff;
    line-height: 20px;
    position: relative;
    height: 20px;
    padding: 4px;
    border-radius:4px;
    margin:auto;
}
   </style>
    <script >
    $(function() {
        //当输入域失去焦点 (blur) 时改变其颜色：
        $("#sAccount").blur(function(){
         //var validNum = (/^\d{8}$/.test($(this).val()));
         // 这里规定工号只能由8位整数组成，$(this).val()获得input的输入值。
        if($(this).val()===""){
            showError($("input#sAccount"),"工号不能为空")
        } //else if (!validNum){
            //showError($("input#sAccount"),"工号格式错误");
        //}
        });

        //当元素获得焦点时，发生 focus 事件。
    $(".input-form input").focus(function(){
        resetError($(this));
    }).keydown(function(){
        resetError($(this));
    });

    $("#sPassword").blur(function(){
        if($(this).val()==""){
            showError($(this),"密码不能为空");
        }
    });

    $("#login-submit").click(function(){
    validLogin();
    });

    $("#sPassword").keydown(function(event){
        // which属性用于返回触发当前事件时按下的键盘按键或鼠标按钮。13代表回车键，输入密码直接回车即可登录
        if(event.which === 13){
        validLogin();
        }
    });
    });

    function showError($input,errorMsg){
    $input.siblings("span.error-msg").text(errorMsg).removeClass("hide");
    $input.parents("div.input-form").addClass("invalid");
    }

    function resetError($input){
        $input.parents("div.input-form").removeClass("invalid");
        $input.siblings("span.error-msg").addClass("hide");
        $input.parents("div.input-form").addClass("focus");
        $("#login-error-msg").addClass("hide");
    }

    function validLogin(){
        var sn = $("#sAccount").val();
        var pw = $("#sPassword").val();
        if((sn !=="")&&(pw !=="")){
            var staff = {
            		sAccount: sn,
            		sPassword:pw
            };
           
            $.ajax({
                type: "POST",
                url:"/plantSCM/login",
                contentType:"application/json;charset=UTF-8",
    		    data:JSON.stringify(staff),
    		    dataType:"json",
                success: function(data){
                    if(data.code ==0){
                    	 var storage=window.localStorage;
                         storage["staffname"]=data.result;                        
                         window.location.href = "system_inform.jsp";                        
                    } else{
                        var $lem = $("#login-error-msg");
                        $lem.text(data.msg);
                        $lem.removeClass("hide");
                    }
                }
            });
        } else if(sn === ""){
            showError($(sAccount),"工号不能为空")
        }else{
            showError($("#sPassword"),"密码不能为空");
        }
    }
    </script>
</head>
<body>
    <div id="container">
      <div class="block-display">
         <div class="login-title">
            <h1>进销存管理系统</h1>
         </div>
         <div class="login-input login-form">
            <div class="account input-form">
              <span class="account-icon"></span>
              <input type="text" name="sAccount" id="sAccount" placeholder="请输入工号"/>
              <span class="error-msg hide"></span>              
            </div>
            <div class="password input-form">
                 <span class="password-icon"></span>
                 <input id="sPassword" type="password" name="sPassword" placeholder=" 请输入密码"/>
                 <span class="error-msg hide"></span>
            </div>
            <div class="btn-wrap">
                 
                 <div class="btn-default">
                      <a id="login-submit" href="#">登录</a>
                 </div>

                 <div class="login-error-div">
                      <span class="hide" id="login-error-msg"></span>
                 </div>
            </div>
            
         </div>
      </div>
    </div>   
</body>
</html>