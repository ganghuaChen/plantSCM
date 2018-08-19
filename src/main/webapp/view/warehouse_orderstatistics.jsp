<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>进销存管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">  
    <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script> 
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <!--<link rel="stylesheet" href="../css/bootstrap-table.min.css"  />  --> 
    <script src="../js/bootstrap-table-zh-CN.min.js"></script>   
    <script src="../js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-select.min.css"  /> 
    <script src="../js/defaults-zh_CN.min.js"></script>
    <script src="../js/moment-with-locales.min.js"></script>  
    <link  rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css">  
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
    <link href="../css/tabulator_semantic-ui.css" rel="stylesheet">
    <!--<link href="../css/tabulator.min.css" rel="stylesheet">  -->
    <script type="text/javascript" src="../js/tabulator.min.js"></script>
    <link  rel="stylesheet" href="../css/toastr.min.css">  
    <script src="../js/toastr.min.js"></script>
    <script src="../js/path.js"></script>
    <script type="text/javascript">
    
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
    }   //获取日期结束 
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
  //选择器获取收货人
    function getCustomer(){
    	$.ajax({
            type:"GET",
            url:"/plantSCM/WarehouseOut/getCustomer",
            success:function(data){
            	if(data.code==0){
            		result=data.result;
            		for(var i=0;i<result.length;i++){
               		 var text=result[i];
               		 var value=i+2;
               		 $("#select1").append("<option value='"+value+"'>"+text+"</option>");
               	     }
               	     $('#select1').selectpicker('refresh');
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
	
	//点击搜索按钮
	function clicksearch(){
	    var startTime = $("#datetimepicker1").find("input").val();
		var endTime = $("#datetimepicker2").find("input").val();
		var customerName = $("#select1").find("option:selected").text();
		var temp = {
		        startTime:startTime,//开始时间
                endTime: endTime,//结束时间
                customerName:customerName,//收货人
		}
		if(isNull(startTime) || isNull(endTime)){
		    toastr.info("请选择时间");
		}
		else {
		    search(temp);
		}
	}
  //点击搜索按钮触发search函数
    function search(temp){   	
      	var temp = {
                startTime:$("#datetimepicker1").find("input").val(),//开始时间
                endTime: $("#datetimepicker2").find("input").val(),//结束时间
                customerName:$("#select1").find("option:selected").text(),//收货人                               
            };     	      	
    	$.ajax({
            type:"GET",
            url:"/plantSCM/WarehouseOut/getSonghuoStatistics",
            data:temp,//将数据传给后台
            dataType:"json",
            success:function(data){
            	if(data.code==0){
            		var result=data.result;
            		$("#example-table").tabulator("setData",result);
            		//$("#tb_departments").bootstrapTable('load', result);            
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
    
  
    
    
    $(function(){
    	initTable();
    	//在右上角添加用户名字
   	 var storage=window.localStorage;            
        $("#staff-name").html(storage["staffname"]);
        
   	//设置提示框的属性
   	toastr.options.timeOut = 1300;
   	toastr.options.positionClass = 'toast-top-center';
   	toastr.options.preventDuplicates = true;  
   	
   	//initTable();
	//设置选择框的属性
	 $('#select1').selectpicker({
	        noneSelectedText: "请选择",
	    });    	
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
	 //获取收货人
	 getCustomer();
	 //initTable();
	 //初始化表格
	 $("#example-table").tabulator({
		 layout:"fitColumns",
		 pagination:"local",
		 paginationSize:6,
		 columnVertAlign:"center", //align header contents to center of cell
		 columns:[	
			 {formatter:"rownum", align:"center",width:40},
		        {title:"收货人", field:"customerName",align:"center",headerSort:true,editor:false,widthGrow:2},
		        {//create column group
		            title:"焊片统计",
		            columns:[		               
		                {title:"应送数量", field:"hporderNumberStatistics", align:"center",headerSort:true,editor:false,bottomCalc:"sum",widthGrow:2},
		                {title:"实送数量", field:"hpsongchuNumberStatistics", align:"center", headerSort:true,editor:false,bottomCalc:"sum",widthGrow:2},		                
		            ],
		        },
		        {//create column group
		            title:"焊剂统计",
		            columns:[
		            	{title:"应送数量", field:"hjorderNumberStatistics", align:"center",headerSort:true,editor:false,bottomCalc:"sum",widthGrow:2},
		                {title:"实送数量", field:"hjsongchuNumberStatistics", align:"center", headerSort:true,editor:false,bottomCalc:"sum",widthGrow:2},
		            ],
		        },
		        //{title:"误差", field:"dValue",headerSort:false,editor:false,validator:threefloatnumber, width:80},//算出来
		    ],
		    
		});		

       
    function initTable(){
    	var temp = {
                startTime:$("#datetimepicker1").find("input").val(),//开始时间
                endTime: $("#datetimepicker2").find("input").val(),//结束时间
                customerName:$("#select1").find("option:selected").text(),//收货人                              
            };    	
    	 $.ajax({
     		type:"GET",
     		url:"/plantSCM/WarehouseOut/getSonghuoStatistics",//从后台获取订单数量
     		data:temp,
     		dataType:"json",
     		success:function(data){
     			if(data.code == 0){
     				var modellist=data.result;//获取的是数组        			
         			$("#example-table").tabulator("setData",modellist); 	
     			}
     			else{
     				toastr.info(data.msg);
     			}    			    		
     		}
     	});
    		 
     }

    });//function函数结束
     //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
   function isNull(str){
   	if(!str) return true;
        if ( str == "" ) return true;
        var regu = "^[ ]+$";
        var re = new RegExp(regu);
        return re.test(str);
    }
    
  //左侧栏点击事件
    function clicksonghuo(){
    	 window.location.href = path+"warehouse_songhuomanage.jsp";        	
    }
    function clickruku(){
    	window.location.href = path+"warehouse_hpinrecord.jsp";
    }
    function clickpandian(){
    	window.location.href = path+"warehouse_hpinventory.jsp";
    }        
    
    function clickstatistics(){
    	window.location.href = path+"warehouse_orderstatistics.jsp";
    }
    function clickhpinrecord(){
    	window.location.href = path+"warehouse_hpinrecord.jsp";
    }
    function clickhjinrecord(){
    	window.location.href = path+"warehouse_hjinrecord.jsp";
    }
    function clickhpinventory(){
    	window.location.href = path+"warehouse_hpinventory.jsp";
    }
    function clickhjinventory(){
    	window.location.href = path+"warehouse_hjinventory.jsp";
    }
    function clickhpprint(){
    	window.location.href = path+"warehouse_hpprint.jsp";
    }
    function clickhjprint(){
    	window.location.href = path+"warehouse_hjprint.jsp";
    }
    function clicksonghuomanage(){
    	window.location.href = path+"warehouse_songhuomanage.jsp";
    }
    //点击按钮
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
                                <li class="role-navbar-nav" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="systemmanage()">工作台</a></li>
                            </ul>
							<ul class="nav navbar-nav">
                                <li class="role-navbar-nav " id="factory-navbar-nav"><a href="javascript:void(0)" onclick="businessmanage()">商务</a></li>
                            </ul>
							 <ul class="nav navbar-nav">
                                <li class="role-navbar-nav active" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="warehousemanage()">仓库</a></li>
                            </ul>
							 <ul class="nav navbar-nav">
                                <li class="role-navbar-nav" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="facrorymanage()">工厂</a></li>
                            </ul>
                        </div>
                        <div class="fr">
                            <ul class="nav navbar-nav navbar-right">                                
                                <li><a id="nav-staff-name" href="#"><span class="glyphicon glyphicon-user"></span><span id="staff-name">staff-name</span></a></li>
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
            <!-- <a  href="javascript:void(0);" onclick="clicksonghuo()"> -->
            <a href="#systemSetting1" class="nav-header collapsed" data-toggle="collapse" >
            <i class="glyphicon glyphicon-edit"></i>
                                   送货管理                    
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>                               
            </a>
            <ul id="systemSetting1" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li><a href="javascript:void(0)" onclick="clicksonghuomanage()"><i></i>送货管理</a></li>
            <li style="background-color:#F0FFFF;"><a href="javascript:void(0)" onclick="clickstatistics()"><i></i>送货统计</a></li>
            </ul>
            </li>
            <li>
            <a href="#systemSetting2" class="nav-header collapsed" data-toggle="collapse" >            
            <i class="glyphicon glyphicon-edit"></i>
                                        入库管理
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>                            
            </a>
            <ul id="systemSetting2" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li><a href="javascript:void(0)" onclick="clickhpinrecord()">焊片入库记录</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjinrecord()">焊剂入库记录</a></li>
            </ul>
            </li>
            <li>
            <!--  <a href="javascript:void(0);" onclick="clickkucun()"> -->
            <a href="#systemSetting3" class="nav-header collapsed" data-toggle="collapse" >
            <i class="glyphicon glyphicon-edit"></i>
                                         库存管理
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="systemSetting3" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li><a href="javascript:void(0)" onclick="clickhpinventory()">焊片库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjinventory()">焊剂库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhpprint()">焊片打印</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjprint()">焊剂打印</a></li>
            </ul>
            </li>
                      
                  
            </ul>
            </div>
             <!--垂直导航栏结束-->
 <!-- 现在开始写搜索栏 -->            
<div class="col-xs-11 col-md-11">                          
    <div class="row">
        <div style="white-space:pre;float:left;">收货人</div>
            <div style="float:left;">
                <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                    <option value="1">全部</option>                                                                                                                                            
                 </select>
             </div>                 
               <div style="float:left;"> &nbsp;&nbsp;&nbsp;&nbsp;
                                                            日期</div>
                <div style="width:200px;float:left;">                 
                    <div class='input-group date' id='datetimepicker1' >  
                         <input type='text' class="form-control" placeholder="请选择开始日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div style="float:left;"> &nbsp;&nbsp;&nbsp;&nbsp;
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
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="clicksearch()">搜索</button>          
                 </div>                                                                
               </div>
                <div class="row">
                <div class="panel-body" style="padding-bottom:0px;padding-top:20px;">
                       <div id="example-table"></div>
                   </div>                    
             </div><!-- 一行row结束 -->
          
               
               </div>     <!-- 搜索栏结束 -->  
              

</body>
</html>