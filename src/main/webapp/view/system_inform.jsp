<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>进销存管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/plantSCM/css/bootstrap.min.css">  
    <script type="text/javascript" src="/plantSCM/js/jquery-2.1.4.min.js"></script> 
    <script type="text/javascript" src="/plantSCM/js/bootstrap.min.js"></script>
    <script src="/plantSCM/js/bootstrap-table.min.js"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-table.min.css"  /> 
    <script src="/plantSCM/js/bootstrap-table-zh-CN.min.js"></script>
    <script src="/plantSCM/js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-select.min.css"  /> 
    <script src="/plantSCM/js/defaults-zh_CN.min.js"></script>
    <script src="/plantSCM/js/moment-with-locales.min.js"></script>  
    <link  rel="stylesheet" href="/plantSCM/css/bootstrap-datetimepicker.min.css">  
    <script src="/plantSCM/js/bootstrap-datetimepicker.min.js"></script>
    <link  rel="stylesheet" href="/plantSCM/css/toastr.min.css">  
    <script src="/plantSCM/js/toastr.min.js"></script>
    <script src="../js/path.js"></script>
    <script>
    var datas  = [];
    $(function (){
		//在右上角添加用户名字
        	 var storage=window.localStorage;            
             $("#staff-name").html(storage["staffname"]);
    	$.ajax({
            type:"get",
            url:"/plantSCM/GetInform",
            dataType:"json",
            success:function(data){  
            	
            	
    	$('#tabletest').bootstrapTable({  	
 	        type:'get',	        
			cache: false,			
			striped: true,
			pagination: true,
			pageSize: 10,
			pageNumber:1,
			pageList: [10, 20, 50, 100],
			search: true,			
			clickToSelect: true,
			sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*） 
			columns: 
			[				
				{field:"informTime",title:"通知日期",align:"center",valign:"middle",sortable:"true"},
				{field:"informContent",title:"通知内容",align:"center",valign:"middle",sortable:"true"},				
			],			
			data:data.result,
		});	 	       
    }    
    });
    })
    //左侧栏点击事件
        function clickphone_shezhi(){
        	window.location.href = path+"system_phone.jsp";
        }
        function clickmodel_shezhi(){
        	window.location.href = path+"system_model.jsp";
        }
        function clickinform(){
        	window.location.href = path+"system_inform.jsp";
        }
        function logoff(){
        	  localStorage.clear();
        	  window.location.href='logoff';
          }
		function systemmanage(){	   
	    window.location.href = path+"system_inform.jsp";  
        }
       function businessmanage(){	   
	    window.location.href = path+"business_orderrecord.jsp";  
       }
       function warehousemanage(){	   
	   window.location.href = path+"warehouse_songhuomanage.jsp";  
      }
      function facrorymanage(){	   
	   window.location.href = path+"factory_openfactoryrecord.jsp";  
       }
    </script>
</head>
<body>
          <!--水平导航栏-->
          <header>
                <nav class="navbar navbar-default fixed" id="header-nav" role="navigation" style="width:100%">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="#">进销存管理系统</a>
                        </div>
                        <div class="fl">
                            <ul class="nav navbar-nav">
                                <li class="role-navbar-nav active" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="systemmanage()">工作台</a></li>
                            </ul>
							<ul class="nav navbar-nav">
                                <li class="role-navbar-nav " id="factory-navbar-nav"><a href="javascript:void(0)" onclick="businessmanage()">商务</a></li>
                            </ul>
							 <ul class="nav navbar-nav">
                                <li class="role-navbar-nav " id="factory-navbar-nav"><a href="javascript:void(0)" onclick="warehousemanage()">仓库</a></li>
                            </ul>
							 <ul class="nav navbar-nav">
                                <li class="role-navbar-nav" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="facrorymanage()">工厂</a></li>
                            </ul>
                        </div>
                        <div class="fr">
                            <ul class="nav navbar-nav navbar-right">                                
                                <li><a id="nav-staff-name" href="#"><span class="glyphicon glyphicon-user"></span><span id="staff-name"></span></a></li>
                                <li><a id="logout" href="javascript:void(0);" onclick="logoff()"><span class="glyphicon glyphicon-log-out"></span> 退出</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </header>         
            <!--水平导航栏结束-->

                      
            <div class="container-fluid">
            <div class="row">
            <!--垂直导航栏-->
            <div class="col-xs-1 col-md-1">
            <!--nav-stacked是说明是竖直导航栏-->
            <ul id="main-nav" class="nav nav-tabs navbar-default fixed nav-stacked">
            <li style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickinform()">
             <i class="glyphicon glyphicon-edit"></i>
                                        通知列表
            </a>
            </li>         
           <li>
            <a href="javascript:void(0);" onclick="clickphone_shezhi()">
            <i class="glyphicon glyphicon-edit"></i>
                                        电话设置
            </a>
            </li>
            <li>
            <a href="javascript:void(0);" onclick="clickmodel_shezhi()">
            <i class="glyphicon glyphicon-edit"></i>
                                         型号设置
            </a>
            </li>
                         
            </ul>
            </div>
             <!--垂直导航栏结束-->       
           <div class="col-xs-11 col-md-11">          
               <div class="row">                                          
                       <div class="col-xs-8 col-md-8">      
                           <table class="table table-bordered" id='tabletest'>
                           
                         </table>    
                      </div>                                             
               </div>
               <div class="row">
                   <div class="panel-body" style="padding-bottom:0px;">                                       
                  </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>