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
    <link  rel="stylesheet" href="../css/toastr.min.css">  
    <script src="../js/toastr.min.js"></script>
    <script src="../js/path.js"></script>
    <script>
    
        $(function () {
        	//在右上角添加用户名字
        	 var storage=window.localStorage;            
             $("#staff-name").html(storage["staffname"]);
             
        	//设置提示框的属性
        	toastr.options.timeOut = 1300;
        	toastr.options.positionClass = 'toast-top-center';
        	toastr.options.preventDuplicates = true;
        	
        	 //初始化日期选择器
        	 var picker1 = $('#datetimepicker1').datetimepicker({          
        		 format: 'YYYY-MM-DD',          
        		 locale: moment.locale('zh-cn'), 
        		 defaultDate: getBeginDate() 
        		 });      
        	 var picker2 = $('#datetimepicker2').datetimepicker({  
        		 format: 'YYYY-MM-DD',         
        		 locale: moment.locale('zh-cn'),
        		 defaultDate: getEndDate()
        		 
        	 });  
        	 var picker3 = $('#datetimepicker3').datetimepicker({          
        		 format: 'YYYY-MM-DD',          
        		 locale: moment.locale('zh-cn'), 
        		 defaultDate: getBeginDate() 
        		 });      
        	 var picker4 = $('#datetimepicker4').datetimepicker({  
        		 format: 'YYYY-MM-DD',         
        		 locale: moment.locale('zh-cn'),
        		 defaultDate: getEndDate()
        		 
        	 });  
        	 var picker5 = $('#datetimepicker5').datetimepicker({  
        		 format: 'YYYY-MM-DD',         
        		 locale: moment.locale('zh-cn'),
        		 defaultDate: getBeginDate() 
        		 
        	 });  
        	 var picker6 = $('#datetimepicker6').datetimepicker({  
        		 format: 'YYYY-MM-DD',         
        		 locale: moment.locale('zh-cn'),
        		 defaultDate: getEndDate()
        		 
        	 });    
        	//初始化原料表
             inityltable()
        	 //初始化焊剂表
        	 inithjtable();
        	//初始化焊片表
             inithptable();


        }); 

       
        //获得本月1号的日期
        function getBeginDate() {
            var date = new Date();
            var seperator1 = "-";
            var month = date.getMonth() + 1;
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            var beginDate = date.getFullYear() + seperator1 + month + seperator1 +"01";
            return beginDate;
        }
        //获得当天日期
        function getEndDate() {
            var date = new Date();
            var seperator1 = "-";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var endDate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
            return endDate;
        }
        
              
        //左侧栏点击事件
        function clickorderrecord(){
        	 window.location.href = path+"business_orderrecord.jsp";        	
        }
        function clickpurchaserecord(){
        	window.location.href = path+"business_purchaserecord.jsp";
        }
        function clickstatistic(){
        	window.location.href = path+"business_purchasestatistics.jsp";
        }        
        function clickinventory(){
        	window.location.href = path+"business_inventory.jsp";
        }
       
        //点击新建出厂登记
        function clickaddorder(){
        	window.location.href = path+"business_neworder.jsp";
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
      //点击搜索按钮搜索原料
        function search1(){       	
        	var temp = {        			
                    startTime:$("#datetimepicker1").find("input").val(),
                    endTime: $("#datetimepicker2").find("input").val(),
                                     
                };
        	if(temp.startTime==""){
        		toastr.info("请选择开始时间");
        	}else if(temp.endTime==""){
        		toastr.info("请选择结束时间");
        	}else{
        		$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessStatistics/getMaterialPurchaseStatistics",//从后台获取原料统计信息   给后台传开始时间结束时间
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){
                    		var result=data.result;                    		
                    		var sum={ylTotalPriceStatistics:0,ylWeightStatistics:0};
                    		for(var i=0;i<result.length;i++){
                    			sum.ylTotalPriceStatistics=sum.ylTotalPriceStatistics+result[i].ylTotalPriceStatistics;
                    			sum.ylWeightStatistics=sum.ylWeightStatistics+result[i].ylWeightStatistics;
                    			
                    		}                    		
                    		$("#tb_yl").bootstrapTable('load', result); 
                    		$("#tb_yl").bootstrapTable('append', sum);   
                    	}
                    	else{
                    		var msg=data.msg;
                    		toastr.error(msg);
                    	}
                        	              
                    },
          	       error : function(err){
          	    	toastr.error('请连接网络');
                     }
                });	
        	}
        	
        }
        //点击搜索按钮搜索焊剂
        function search2(){       	
        	var temp = {        			
                    startTime:$("#datetimepicker3").find("input").val(),
                    endTime: $("#datetimepicker4").find("input").val(),
                                      
                };
        	if(temp.startTime==""){
        		toastr.info("请选择开始时间");
        	}else if(temp.endTime==""){
        		toastr.info("请选择结束时间");
        	}else{
        		$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessStatistics/getHanjiPurchaseStatistics",//从后台获取焊剂统计信息   给后台传开始时间结束时间
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){
                    		var result=data.result;                    		               	                   		
                    		var sum={hjTotalPriceStatistics:0,hjNumberStatistics:0};
                    		for(var i=0;i<result.length;i++){
                    			sum.hjTotalPriceStatistics=sum.hjTotalPriceStatistics+result[i].hjTotalPriceStatistics;
                    			sum.hjNumberStatistics=sum.hjNumberStatistics+result[i].hjNumberStatistics;
                    			
                    		}                   		
                    		$("#tb_hj").bootstrapTable('load', result); 
                    		$("#tb_hj").bootstrapTable('append', sum);   
                    	}
                    	else{
                    		var msg=data.msg;
                    		toastr.error(msg);
                    	}
                        	              
                    },
          	       error : function(err){
          	    	toastr.error('请连接网络');
                     }
                });	
        	}
        	
        }
        //点击搜索按钮搜索焊片
        function search3(){       	
        	var temp = {        			
                    startTime:$("#datetimepicker5").find("input").val(),
                    endTime: $("#datetimepicker6").find("input").val(),
    
                };
        	if(temp.startTime==""){
        		toastr.info("请选择开始时间");
        	}else if(temp.endTime==""){
        		toastr.info("请选择结束时间");
        	}else{
            	$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessStatistics/getHanpianPurchaseStatistics",//从后台获取焊片统计信息   给后台传开始时间结束时间
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){                   		
                    		var result=data.result;                    		               	                   		
                    		var sum={hpWeightStatistics:0,hpTotalPriceStatistics:0};
                    		for(var i=0;i<result.length;i++){
                    			sum.hpWeightStatistics=sum.hpWeightStatistics+result[i].hpWeightStatistics;
                    			sum.hpTotalPriceStatistics=sum.hpTotalPriceStatistics+result[i].hpTotalPriceStatistics;
                    			
                    		}                   		
                    		$("#tb_hp").bootstrapTable('load', result); 
                    		$("#tb_hp").bootstrapTable('append', sum);   
                    		
                    	}
                    	else{
                    		var msg=data.msg;
                    		toastr.error(msg);
                    	}
                        	              
                    },
          	       error : function(err){
          	    	toastr.error('请连接网络');
                     }
                });	
        	}

        }
      
      //初始化焊片采购记录表
            function inithptable(){
        	var temp = {        			
                    startTime:$("#datetimepicker5").find("input").val(),
                    endTime: $("#datetimepicker6").find("input").val(),                      
                };
        	
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessStatistics/getHanpianPurchaseStatistics",//从后台获取焊片统计信息   给后台传开始时间结束时间
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;                 	                  		               	                   		
                		var sum={hpWeightStatistics:0,hpTotalPriceStatistics:0};
                		for(var i=0;i<result.length;i++){
                			sum.hpWeightStatistics=sum.hpWeightStatistics+result[i].hpWeightStatistics;
                			sum.hpTotalPriceStatistics=sum.hpTotalPriceStatistics+result[i].hpTotalPriceStatistics;
                			
                		}                   		               		
                		result.push(sum);
                	     $('#tb_hp').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: false,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                            // uniqueId: "id",                     //每一行的唯一标识，一般为主键列         
                             maintainSelected : true,
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                	if(!row.hpShape){
                                		return "总计";
                                	}
                                return index+1;
                                 }
                               }, {
                                 field: 'hpShape',
                                 title: '形状',
                                 sortable : true
                             }, {
                                 field: 'hpModel',
                                 title: '型号',                               
                                 sortable : true,
                                
                             }, {
                                 field: 'hpSpec',
                                 title: '规格',                               
                                 sortable : true
                             }, {
                                 field: 'hpWeightStatistics',
                                 title: '重量',
                                 sortable : true,
                                 
                             }, {
                                 field: 'hpTotalPriceStatistics',
                                 title: '总价',
                                 sortable : true
                             }],
                             data:result
                         });
                	}
                	else{
                		var msg=data.msg;
                		toastr.error(msg);
                	}
                    	              
                },
      	       error : function(err){
      	    	toastr.error('请连接网络');
                 }
            });	
        	
        }
           
          //初始化焊剂采购记录表
            function inithjtable(){
        	var temp = {        			
                    startTime:$("#datetimepicker3").find("input").val(),
                    endTime: $("#datetimepicker4").find("input").val(),                                    
                };
        	
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessStatistics/getHanjiPurchaseStatistics",//从后台获取焊剂统计信息   给后台传开始时间结束时间
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		//var result=data.result;                    		
                		var sum={hjTotalPriceStatistics:0,hjNumberStatistics:0};
                		for(var i=0;i<result.length;i++){
                			sum.hjTotalPriceStatistics=sum.hjTotalPriceStatistics+result[i].hjTotalPriceStatistics;
                			sum.hjNumberStatistics=sum.hjNumberStatistics+result[i].hjNumberStatistics;
                			
                		}  
                		result.push(sum);                		
                	     $('#tb_hj').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: false,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                            // uniqueId: "id",                     //每一行的唯一标识，一般为主键列         
                             maintainSelected : true,
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                	if(!row.hjSpecies){
                                		return "总计";
                                	}
                                return index+1;
                                 }
                               }, {
                                 field: 'hjSpecies',
                                 title: '种类',
                                 sortable : true
                             }, {
                                 field: 'hjNumberStatistics',
                                 title: '数量',
                                 sortable : true
                             }, {
                                 field: 'hjTotalPriceStatistics',
                                 title: '总价',
                                 sortable : true,
                                 
                             }],
                             data:result
                         });
                	}
                	else{
                		var msg=data.msg;
                		toastr.error(msg);
                	}
                    	              
                },
      	       error : function(err){
      	    	toastr.error('请连接网络');
                 }
            });	
        	
        }
          //初始化焊剂采购记录表
            function inityltable(){
        	var temp = {        			
                    startTime:$("#datetimepicker1").find("input").val(),
                    endTime: $("#datetimepicker2").find("input").val(),
                                    
                };
        	
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessStatistics/getMaterialPurchaseStatistics",//从后台获取原料统计信息   给后台传开始时间结束时间
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		//var result=data.result;                    		
                		var sum={ylTotalPriceStatistics:0,ylWeightStatistics:0};
                		for(var i=0;i<result.length;i++){
                			sum.ylTotalPriceStatistics=sum.ylTotalPriceStatistics+result[i].ylTotalPriceStatistics;
                			sum.ylWeightStatistics=sum.ylWeightStatistics+result[i].ylWeightStatistics;
                			
                		}  
                		result.push(sum);                	
                	     $('#tb_yl').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: false,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                            // uniqueId: "hjorderId",                     //每一行的唯一标识，一般为主键列         
                             //maintainSelected : true,
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {                               	
                                	if(!row.ylSpecies){
                                		return "总计";
                                	}
                                return index+1;
                                 }
                               },{
                                 field: 'ylSpecies',
                                 title: '种类',
                                 sortable : true
                             },  {
                                 field: 'ylWeightStatistics',
                                 title: '重量',
                                 sortable : true
                             }, {
                                 field: 'ylTotalPriceStatistics',
                                 title: '总价',                                 
                                 sortable : true,
                                 
                             }],
                             data:result
                         });
                	}
                	else{
                		var msg=data.msg;
                		toastr.error(msg);
                	}
                    	              
                },
      	       error : function(err){
      	    	toastr.error('请连接网络');
                 }
            });	
        	
        } 
          function purchase(){
        	  window.location.href = path+"business_purchasestatistics.jsp";
          }
          function order(){
        	  window.location.href = path+"business_orderstatistics.jsp";
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
                                <li class="role-navbar-nav" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="systemmanage()">工作台</a></li>
                            </ul>
							<ul class="nav navbar-nav">
                                <li class="role-navbar-nav active" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="businessmanage()">商务</a></li>
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
            <li>
            <a  href="javascript:void(0);" onclick="clickorderrecord()">
            <i class="glyphicon glyphicon-edit"></i>
                                           订单管理
            </a>
            </li>
            <li>
            <a href="javascript:void(0);" onclick="clickpurchaserecord()">
            <i class="glyphicon glyphicon-edit"></i>
                                        采购管理
            </a>
            </li>
            <li style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickstatistic()">
            <i class="glyphicon glyphicon-edit"></i>
                                         统计信息
            </a>
            </li>
            <li>
            <a href="javascript:void(0);" onclick="clickinventory()">
             <i class="glyphicon glyphicon-edit"></i>
                                        查看库存
            </a>
            </li>            
                    
            </ul>
            </div>
             <!--垂直导航栏结束-->
        
           <div class="col-xs-11 col-md-11">       
           
           
               <div class="row">                  
                   <button id="submit"  type="button" class="btn btn-primary"  onclick="purchase()">采购统计</button>
                   <button id="back"  type="button" class="btn btn-default"   onclick="order()">销售统计</button>                
              </div>  
                <br/>                
               <div class="row">                                                  
               <div style="white-space:pre;float:left;">采购日期</div>
                <div style="width:200px;float:left;">                 
                    <div class='input-group date' id='datetimepicker1' >  
                         <input type='text' class="form-control" placeholder="请选择开始日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div style="float:left;"> 
                                                            至</div>
                 <div style="width:200px;float:left;">      
                         <div class='input-group date' id='datetimepicker2'>  
                         <input type='text' class="form-control" placeholder="请选择结束日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                         </div>  
                  </div>
                 
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton1"  type="button" class="btn btn-primary"  onclick="search1()">搜索</button>                                               
                 </div>                                                         
               </div>
               <br/>               
               <div class="row">
               <span><span class="glyphicon glyphicon-tree-conifer"></span>原料</span>
               </div>
               <div class="row">
               <div class="col-xs-8 col-md-8">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_yl"></table>
                   </div>
                </div>
               </div>
                <br/>
                
                
                
                
                
             <div class="row">                                                  
               <div style="white-space:pre;float:left;">采购日期</div>
                <div style="width:200px;float:left;">                 
                    <div class='input-group date' id='datetimepicker3' >  
                         <input type='text' class="form-control" placeholder="请选择开始日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div style="float:left;"> 
                                                            至</div>
                 <div style="width:200px;float:left;">      
                         <div class='input-group date' id='datetimepicker4'>  
                         <input type='text' class="form-control" placeholder="请选择结束日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                         </div>  
                  </div>            
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton2"  type="button" class="btn btn-primary"  onclick="search2()">搜索</button>                                               
                 </div>                                                         
               </div>
               <br/>               
               <div class="row">
               <span><span class="glyphicon glyphicon-tree-conifer"></span>焊剂</span>
               </div>
               <div class="row">
               <div class="col-xs-8 col-md-8">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hj"></table>
                   </div>
               </div>
               </div>
                <br/>
                
                
                
                
                
                 <div class="row">                                                  
               <div style="white-space:pre;float:left;">采购日期</div>
                <div style="width:200px;float:left;">                 
                    <div class='input-group date' id='datetimepicker5' >  
                         <input type='text' class="form-control" placeholder="请选择开始日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div style="float:left;"> 
                                                            至</div>
                 <div style="width:200px;float:left;">      
                         <div class='input-group date' id='datetimepicker6'>  
                         <input type='text' class="form-control" placeholder="请选择结束日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                         </div>  
                  </div>                
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton3"  type="button" class="btn btn-primary"  onclick="search3()">搜索</button>                                               
                 </div>                                                         
               </div>
               <br/>               
               <div class="row">
               
               <span><span class="glyphicon glyphicon-tree-conifer"></span>焊片</span>
               </div>
               <div class="row">
               <div class="col-xs-8 col-md-8">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hp"></table>
                   </div>
               </div>
               </div>
                

        

      </div>
      </div>
   </div>
</body>
</html>