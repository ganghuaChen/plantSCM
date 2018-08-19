<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE>

<html>
<head>
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
    <!--<link href="../css/tabulator_semantic-ui.min.css" rel="stylesheet">  -->
   
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
    
  //选择器获取型号
    function getHpModel(){
    	$.ajax({
            type:"GET",
            url:"/plantSCM/WarehouseIn/getModel",
            success:function(data){
            	if(data.code==0){
            		result=data.result;            		
            		for(var i=0;i<result.length;i++){
               		 var text=result[i];
               		 var value=i+2;
               		 $("#select3").append("<option value='"+value+"'>"+text+"</option>");
               	     }
               	     $('#select3').selectpicker('refresh');
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
  
    var dataarray=[];
    $(function () {
    	getHpModel();//调用获取厂家
    	//initTable();//加载表格内容
    	//在右上角添加用户名字
        var storage=window.localStorage;            
        $("#staff-name").html(storage["staffname"]);
      //设置提示框的属性
       	toastr.options.timeOut = 1800;
       	toastr.options.positionClass = 'toast-top-center';
       	toastr.options.preventDuplicates = true; 
       	
      //设置选择框的属性
   	 $('#select1').selectpicker({
   	        noneSelectedText: "请选择",
   	    });    	
   	 $('#select2').selectpicker({
	        noneSelectedText: "请选择",
	    }); 
   	 $('#select3').selectpicker({
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
    	$.ajax({
            type:"get",
            url:"/plantSCM/WarehouseIn/getHpInInitRecord",//打开页面的初始数据（默认
            dataType:"json",
            success:function(data){            	
            	for(i in data.result) 
	            {
            		dataarray[i]={"id":data.result[i].id,"hpstorageDate":data.result[i].hpstorageDate,"hpShape":data.result[i].hpShape,"hpModel":data.result[i].hpModel,"hpSpec":data.result[i].hpSpec,"hpstorageWeight":data.result[i].hpstorageWeight,"hpFrom":data.result[i].hpFrom,
					"hpstorageState":data.result[i].hpstorageState,"hpOutId":data.result[i].hpOutId,"hpPurchaseId":data.result[i].hpPurchaseId};

            		//dataarray[i]={"hpstorageDate":data.result[i].hpstorageDate,"hpShape":data.result[i].hpShape,"hpModel":data.result[i].hpModel,"hpSpec":data.result[i].hpSpec,"hpstorageWeight":data.result[i].hpstorageWeight,"hpstorageState":data.result[i].hpstorageState};
	               if(dataarray[i].hpstorageState == false){
	            	   dataarray[i].hpstorageState = "未入库";
	               }   
	               else if(dataarray[i].hpstorageState == true){
	            	   dataarray[i].hpstorageState = "已入库";
	               }
	            }
     	  $('#example-table').bootstrapTable({
             // url: '/OnlineExam/gc/getHpInRecord',         //请求后台的URL（*）
             method: 'get',                      //请求方式（*）
               //toolbar: '#toolbar',                //工具按钮用哪个容器
               striped: true,                      //是否显示行间隔色
               cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
               pagination: true,                   //是否显示分页（*）
               sortable: true,                     //是否启用排序
               sortOrder: "asc",                   //排序方式
               //queryParams: oTableInit.queryParams,//传递参数（*）
               sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
               pageNumber:1,                       //初始化加载第一页，默认第一页
               pageSize: 5,                       //每页的记录行数（*）
               pageList: [2,5,10],                 //可供选择的每页的行数（*）
               //search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
               //strictSearch: true,
               //showColumns: true,                  //是否显示所有的列
               //showRefresh: true,                  //是否显示刷新按钮
               minimumCountColumns: 2,             //最少允许的列数
               clickToSelect: true,                //是否启用点击选中行
               height:311,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
               uniqueId: "id",                     //每一行的唯一标识，一般为主键列
               //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
               //cardView: false,                    //是否显示详细视图
               //detailView: false,                   //是否显示父子表
              
               columns: [
               	{checkbox: true}, //添加这一行可以在第一列添加复选框，在勾选打印时会有用
               	 {
                  title: '',//标题
                  formatter: function (value, row, index) {
                  return index+1;
                   }
                 },
                 
                
               {
                   field: 'hpstorageDate',
                   title: '入库日期',
                   //class: 'editable',
                   sortable : true,
                  
               }, 
               {
                   field: 'hpShape',
                   title: '形状',
                   //class: 'editable',
                   sortable : true
               }, 
               {
                   field: 'hpModel',
                   title: '型号',
                  // class: 'editable',
                   sortable : true,
                  
               }, 
               {
                   field: 'hpSpec',
                   title: '规格(厚*长*宽)',
                   //class: 'editable',
                   sortable : true
               }, 
               {
                   field: 'hpstorageWeight',
                   title: '重量',
                   //class: 'editable',
                   sortable : true
               }, 
               {
                   field: 'hpstorageState',
                   title: '入库状态',
                   sortable : false
               }, 
              ],
     	  data:dataarray,
           });
        	}
        });
   });//function 结束

   //点击搜索按钮
   function clicksearch(){
	   var hpstorageState=$("#select1").find("option:selected").text();//状态
	   var startTime =  $("#datetimepicker1").find("input").val();//开始时间
       var endTime = $("#datetimepicker2").find("input").val();//结束时间
       var hpShape = $("#select2").find("option:selected").text();
       var hpModel = $("#select3").find("option:selected").text();
       if(isNull(startTime) || isNull(endTime)){
    	   toastr.info("请选择时间");
       }else{
    	   var temp={
    			   hpstorageState:hpstorageState,
    			   startTime:startTime,
    			   endTime:endTime,
    			   hpShape:hpShape,
    			   hpModel:hpModel
    	   }    	  
    	   search(temp);
       }
   }
   
   //搜索
   function search(temp){
	   var hpstorageState=$("#select1").find("option:selected").text();//状态
	   if(hpstorageState == "未入库"){
		   hpstorageState=false;
	   }
	   else if(hpstorageState == "已入库"){
		   hpstorageState=true;
	   }
	   var temp={
			   hpstorageState:hpstorageState,
			   startTime:$("#datetimepicker1").find("input").val(),
			   endTime:$("#datetimepicker2").find("input").val(),
			   hpShape:$("#select2").find("option:selected").text(),
			   hpModel:$("#select3").find("option:selected").text()
	   };	 
	   //将搜索条件传到后台
	   $.ajax({
		   type:"GET",
 	        url:"/plantSCM/WarehouseIn/getHpInRecord",
 	        contentType:"application/json;charset=UTF-8",
 	        data:temp,//将 JavaScript 值转换为 JSON 字符串
 	        dataType:"json",
 	        success:function(data){	        	
 	        	//data是从后台获取的
 	        	if(data.code==0){
            		var result=data.result;
            		for(i=0;i<result.length;i++){
            			if(result[i].hpstorageState == true){
            				result[i].hpstorageState = "已入库";
            			}
            			else if(result[i].hpstorageState == false){
            				result[i].hpstorageState = "未入库";
            			}
            		}
            		$("#example-table").bootstrapTable('load', result);            
            	}
            	else{
            		var msg=data.msg;
            		toastr.error(msg);
            	}
 	        }
	   });
   }
   
   //点击确认入库
   /*function clickruku(){
	   var hpstorageState=$("#select1").find("option:selected").text();//状态
	   var startTime =  $("#datetimepicker1").find("input").val();//开始时间
       var endTime = $("#datetimepicker2").find("input").val();//结束时间
       var hpShape = $("#select2").find("option:selected").text();
       var hpModel = $("#select3").find("option:selected").text();
       if(isNull(startTime) || isNull(endTime)){
    	   toastr.info("请选择时间");
       }else{
    	   var temp={
    			   hpstorageState:hpstorageState,
    			   startTime:startTime,
    			   endTime:endTime,
    			   hpShape:hpShape,
    			   hpModel:hpModel
    	   }   	  
    	   rukuAck(temp);
       }
   }*/
   
   //入库确认
   function hpInAck(){
	   //获取选中的数据
	   var ackData=$('#example-table').bootstrapTable('getAllSelections');
	   var dataarray=[];//传向后台的数据
	   if(ackData.length <= 0){
		   toastr.info("请选择至少一条记录");
	   }else{
		   for(var i=0;i<ackData.length;i++){
			   if(ackData[i].hpstorageState == "未入库"){
				   ackData[i].hpstorageState = false;
				   dataarray.push(ackData[i]);
			   }
			   else if(ackData[i].hpstorageState == "已入库"){
				   toastr.info("该记录已入库");
				   break;
			   }
		   }		 
		   if(dataarray.length>0){
			   $.ajax({
				   type:"POST",
				   url:"/plantSCM/WarehouseIn/confirmHpInRecord",
				   contentType:"application/json;charset=UTF-8",
		 	       data:JSON.stringify(dataarray),//将 JavaScript 值转换为 JSON 字符串
		 	       dataType:"json",
		 	       success:function(data){  
		 	    	   if(data.code==0){
		 	    		   toastr.success(data.msg);
		 	    		   //toastr.info("入库确认成功");
		 	    		   setTimeout("self.location.reload();",1000);
		 	    		   //window.location.reload();
		 	    	   }else{
		 	    		   toastr.error(data.msg);
		 	    	   }
		 	       }
			   })
		   }
		   
	   }
   }
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
            <li><a href="javascript:void(0)" onclick="clickstatistics()"><i></i>送货统计</a></li>
            </ul>
            </li>
            <li>
            <a href="#systemSetting2" class="nav-header collapsed" data-toggle="collapse">            
            <i class="glyphicon glyphicon-edit"></i>
                                        入库管理
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>                    
            </a>
            <ul id="systemSetting2" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li style="background-color:#F0FFFF;"><a href="javascript:void(0)" onclick="clickhpinrecord()">焊片入库记录</a></li>
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
          <header>
                <nav class="navbar navbar-default fixed" id="header-nav" role="navigation" style="width:100%">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="#">焊片入库记录</a>
                        </div>                                          
                    </div>
                </nav>
            </header>         
</div>                         
    <div class="row">
    
        <div style="white-space:pre;float:left;">状态</div>
            <div style="float:left;">
                <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                     
                    <option value="0">未入库</option> 
                    <option value="1">已入库</option>                                                                                                                                                          
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
                                   
             </div><!-- 一行row结束 -->
         </br>
         <div class="row">
         <div style="white-space:pre;float:left;">形状</div>
                      <div style="float:left;">
                      <select id="select2" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                    <option value="1">全部</option>
                    <option value="2">直</option>
                    <option value="3">弯</option>                                                                                                                                            
                 </select>
             </div>    
           <div style="white-space:pre;float:left;"> &nbsp;&nbsp;&nbsp;&nbsp;型号</div>
                      <div style="float:left;">
                      <select id="select3" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                    <option value="1">全部</option>                                                                                                                                           
                 </select>
             </div>                
           <div style="float:left;">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="clicksearch()">搜索</button>          
                 </div>    
                  
                 <div style="float:left;">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <button id="rukubutton"  type="button" class="btn btn-primary"  onclick="hpInAck()">确认入库</button>          
                 </div>    
               </div>     <!-- 搜索栏结束 -->  
             
              </br>
            <div class="row">      
                           <table  class="table table-bordered" id='example-table'>
                            
                         </table>    
                      </div> 
                      
               
             </div>
             </div></div>
         
</body>
</html>