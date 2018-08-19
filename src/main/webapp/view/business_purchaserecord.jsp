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
    <script src="../js/dialog.js"></script>
    <script src="../js/path.js"></script>
    <script>
   
        $(function () {
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
			 $("body").on('click','#tb_yl tr .yledit',  function () {             	
            	  $(".yledit").addClass("btn disabled");
    			  $(".yledit").attr("disabled",true);
    			   $(this).addClass("btn disabled");
    			   $(this).attr("disabled",true);
    			   $(this).next().removeClass("btn disabled");
    			   $(this).next().attr("disabled",false);
    			   $(this).next().addClass("btn btn-default"); 
    			   $(this).parent().parent().children(".yltimeeditable").each(function(){       			  			     				   			 
    		           var value = $(this).text(); 
    		           var k=this.clientWidth/3*2;  
    		          $(this).html(" <div class='input-group date' id='yldatetimepicker'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择采购日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
    		          var ylpicker = $('#yldatetimepicker').datetimepicker({          
    		        		 format: 'YYYY-MM-DD',          
    		        		 locale: moment.locale('zh-cn'), 
    		        		 defaultDate: value
    		        		 });    
    		       });  
    			  
    			  $(this).parent().parent().children(".ylspecies").each(function(){			
				   var oldtext=$(this).text();
				   switch(oldtext)
                         {
                             case "银":
                             $(this).html("<select><option value='0' selected>银</option><option value='1'>铜</option><option value='2'>锌</option><option value='3'>镉</option><option value='4'>锡</option></select>");   
                              break;
                             case "铜":
                              $(this).html("<select><option value='0' >银</option><option value='1' selected>铜</option><option value='2' >锌</option><option value='3'>镉</option><option value='4'>锡</option></select>");
                              break;
							  case "锌":
                              $(this).html("<select><option value='0' >银</option><option value='1'>铜</option><option value='2' selected>锌</option><option value='3'>镉</option><option value='4'>锡</option></select>");
                              break;
							  case "镉":
                              $(this).html("<select><option value='0' >银</option><option value='1'>铜</option><option value='2' >锌</option><option value='3' selected>镉</option><option value='4'>锡</option></select>");
                              break;							 
                             default:
                              $(this).html("<select><option value='0' >银</option><option value='1'>铜</option><option value='2' >锌</option><option value='3'>镉</option><option value='4' selected>锡</option></select>");
                   }
   				      		         
   		           });    	
    			  		 
    				  $(this).parent().parent().children(".yleditable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    	
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
    		       });
             }); 
			 
			 
			 $("body").on('click','#tb_hj tr .hjedit',  function () {             	
            	  $(".hjedit").addClass("btn disabled");
    			  $(".hjedit").attr("disabled",true);
    			   $(this).addClass("btn disabled");
    			   $(this).attr("disabled",true);
    			   $(this).next().removeClass("btn disabled");
    			   $(this).next().attr("disabled",false);
    			   $(this).next().addClass("btn btn-default"); 
    			   $(this).parent().parent().children(".hjtimeeditable").each(function(){       			  			     				   			 
    		           var value = $(this).text(); 
    		           var k=this.clientWidth/3*2;  
    		          $(this).html(" <div class='input-group date' id='hjdatetimepicker'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择采购日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
    		          var hjpicker = $('#hjdatetimepicker').datetimepicker({          
    		        		 format: 'YYYY-MM-DD',          
    		        		 locale: moment.locale('zh-cn'), 
    		        		 defaultDate: value
    		        		 });    
    		       });  
    		
    				  $(this).parent().parent().children(".hjeditable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    	
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
    		       });
             }); 
			 
			 
			  $("body").on('click','#tb_hp tr .hpedit',  function () {             	
            	  $(".hpedit").addClass("btn disabled");
    			  $(".hpedit").attr("disabled",true);
    			   $(this).addClass("btn disabled");
    			   $(this).attr("disabled",true);
    			   $(this).next().removeClass("btn disabled");
    			   $(this).next().attr("disabled",false);
    			   $(this).next().addClass("btn btn-default"); 
    			   $(this).parent().parent().children(".hptimeeditable").each(function(){       			  			     				   			 
    		           var value = $(this).text(); 
    		           var k=this.clientWidth/3*2;  
    		          $(this).html(" <div class='input-group date' id='hpdatetimepicker'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择采购日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
    		          var hppicker = $('#hpdatetimepicker').datetimepicker({          
    		        		 format: 'YYYY-MM-DD',          
    		        		 locale: moment.locale('zh-cn'), 
    		        		 defaultDate: value
    		        		 });    
    		       });  
				   $(this).parent().parent().children(".hpshape").each(function(){
    				   if($(this).text()=="直"){
    					   $(this).html("<select><option value='0' selected>直</option><option value='1'>弯</option></select>");   
    				   }else{
    					   $(this).html("<select><option value='0'  >直</option><option value='1'  selected>弯</option></select>");
    				   }
    				      		         
    		       });  
				    $(this).parent().parent().children(".hpmodel").each(function(){  
    				
						var oldtext=$(this).text();
						$(this).html("<select id='select8'></select>");  
						getModelTable(oldtext);
						
    		       });	
    		
    				  $(this).parent().parent().children(".hpeditable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    	
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
    		       });
             }); 


        }); 

       //获取产品型号表格中
        function getModelTable(oldvalue){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/OpenFactory/getModel",//后台
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		for(var i=0;i<result.length;i++){
                   		 var text=result[i];
                   		 var value=i+2;
						 if(oldvalue==text){
						    $("#select8").append("<option value='"+value+"' selected>"+text+"</option>");
						 }
						 else{
						    $("#select8").append("<option value='"+value+"'>"+text+"</option>");
						 }
                   		 
                   	     }
                   	     
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
                    ylSpecies:$("#select1").find("option:selected").text(), 
                    ylFactory:$("#factory1").val(),                    
                };
          	if(temp.startTime==""){
          		toastr.info("请选择开始时间");
          	}else if(temp.endTime==""){
          		toastr.info("请选择结束时间");
          	}else{
          		$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessPurchase/getMaterialPurchase",//获取原料采购记录  向后台传开始时间、结束时间以及种类厂家   后台向前端传原料采购记录
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){
                    		var result=data.result;
                    		$("#tb_yl").bootstrapTable('load', result);            
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
                    from:$("#factory2").val(),                    
                };
        	if(temp.startTime==""){
          		toastr.info("请选择开始时间");
          	}else if(temp.endTime==""){
          		toastr.info("请选择结束时间");
          	}else{
              	$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessPurchase/getHanjiPurchase",//获取焊剂采购记录  向后台传开始时间、结束时间以及厂家   后台向前端传焊剂采购记录
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){
                    		var result=data.result;
                    		$("#tb_hj").bootstrapTable('load', result);            
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
                    hpFactory: $("#factory3").val()
                   
                    
                };
        	if(temp.startTime==""){
          		toastr.info("请选择开始时间");
          	}else if(temp.endTime==""){
          		toastr.info("请选择结束时间");
          	}else{
          		$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessPurchase/getHanpianPurchase",//获取焊片采购记录  向后台传开始时间、结束时间以及厂家   后台向前端传焊剂采购记录
                    data:temp,
                    dataType:"json",
                    success:function(data){
                    	if(data.code==0){
                    		var result=data.result;
                    		$("#tb_hp").bootstrapTable('load', result);            
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
                    hpFactory: $("#factory3").val()
                   
                    
                };       	
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessPurchase/getHanpianPurchase",//获取焊片采购记录  向后台传开始时间、结束时间以及厂家   后台向前端传焊剂采购记录
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;                 		
                	     $('#tb_hp').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: true,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                             uniqueId: "id",                     //每一行的唯一标识，一般为主键列         
                             maintainSelected : true,
							 undefinedText:"",
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                              
                             {
                                 field: 'hpDate',
                                 title: '采购日期',
								 class: 'hptimeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'hpShape',
                                 title: '形状',
								 class:"hpshape",
                                 sortable : true
                             }, {
                                 field: 'hpModel',
                                 title: '型号',
                                 class:"hpmodel",								 
                                 sortable : true,
                                
                             }, {
                                 field: 'hpSpec',
                                 title: '规格',
                                 class:"hpeditable",								 
                                 sortable : true
                             }, {
                                 field: 'hpPrice',
                                 title: '单价',
								  class:"hpeditable",	
                                 sortable : true
                             }, {
                                 field: 'hpWeight',
                                 title: '重量',
								  class:"hpeditable",	
                                 sortable : true,
                                 
                             }, {
                                 field: 'hpFactory',
                                 title: '厂家',
								  class:"hpeditable",	
                                 sortable : true
                             }, {
                                 field: 'hpTotalPrice',
                                 title: '总价',
                                 sortable : true
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:hpoperateEvents,
                                 formatter:hpAddFunctionAlty,
                             }, {
                                 field: 'hpNote',
                                 title: '备注',
								  class:"hpeditable",	
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
                    from:$("#factory2").val(),                    
                };       	
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessPurchase/getHanjiPurchase",//获取焊剂采购记录  向后台传开始时间、结束时间以及厂家   后台向前端传焊剂采购记录
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;                		
                	     $('#tb_hj').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: true,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                             uniqueId: "id",                     //每一行的唯一标识，一般为主键列         
                             maintainSelected : true,
							 undefinedText:"",
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                              
                             {
                                 field: 'hjDate',
                                 title: '采购日期',
								 class: 'hjtimeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'hjSpecies',
                                 title: '种类',
								 class:"hjeditable",
                                 sortable : true
                             }, {
                                 field: 'hjPrice',
                                 title: '单价',
								 class:"hjeditable",
                                 sortable : true,
                                
                             }, {
                                 field: 'hjNumber',
                                 title: '数量',
								 class:"hjeditable",
                                 sortable : true
                             }, {
                                 field: 'hjFrom',
                                 title: '厂家',
								 class:"hjeditable",
                                 sortable : true
                             }, {
                                 field: 'hjTotalPrice',
                                 title: '总价',
                                 sortable : true,
                                 
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:hjoperateEvents,
                                 formatter:hjAddFunctionAlty,
                             }, {
                                 field: 'hjNote',
                                 title: '备注',
								 class:"hjeditable",
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
          //初始化原料采购记录表
            function inityltable(){
        	var temp = {        			
                    startTime:$("#datetimepicker1").find("input").val(),
                    endTime: $("#datetimepicker2").find("input").val(),
                    ylSpecies:$("#select1").find("option:selected").text(), 
                    ylFactory:$("#factory1").val(),                    
                };       	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessPurchase/getMaterialPurchase",//获取原料采购记录  向后台传开始时间、结束时间以及种类厂家   后台向前端传原料采购记录
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;                		
                	     $('#tb_yl').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: true,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                             uniqueId: "id",                     //每一行的唯一标识，一般为主键列         
                             maintainSelected : true,
							 undefinedText:"",
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                              
                             {
                                 field: 'ylDate',
                                 title: '采购日期',
								 class: 'yltimeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'ylSpecies',
                                 title: '种类',
								 class:"ylspecies",
                                 sortable : true
                             }, {
                                 field: 'ylPrice',
                                 title: '单价',
								 class:"yleditable",
                                 sortable : true,
                                
                             }, {
                                 field: 'ylWeight',
                                 title: '重量',
								 class:"yleditable",
                                 sortable : true
                             }, {
                                 field: 'ylFactory',
                                 title: '厂家',
								 class:"yleditable",
                                 sortable : true
                             }, {
                                 field: 'ylTotalPrice',
                                 title: '总价',                                 
                                 sortable : true,
                                 
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:yloperateEvents,
                                 formatter:ylAddFunctionAlty,
                             }, {
                                 field: 'ylnote',
                                 title: '备注',   
                                 class:"yleditable",								 
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
		  //为操作列添加按钮
            function ylAddFunctionAlty(value,row,index){
         	   return ['<button id="ylTableEditor" type="button" class="btn btn-default btn-xs yledit">编辑</button>&nbsp;' ,
         		   '<button id="ylTableSave" type="button" class="btn btn-default btn-xs ylsave" disabled="disabled">保存</button>&nbsp;',
         		  '<button id="ylTablequxiao" type="button" class="btn btn-default btn-xs ylquxiao">取消</button>',
         		   ].join("")
            }
			//按钮的事件 编辑以及保存
            window.yloperateEvents={
     		   "click #ylTableEditor":function(e,value,row,index){	
     		   },
     		   "click #ylTableSave":function(e,value,row,index){
     			     $("body").one('click','#tb_yl tr .ylsave',  function () {    	            	
     	  			    var obj1 = $(this).parent().parent().children(".yltimeeditable");
						var obj2=$(this).parent().parent().children(".ylspecies");
						var obj3 =$(this).parent().parent().children(".yleditable");
     	  			   
     	  			   
     	  			    var ylDate=obj1.first().find("input").val();
     	  			    var ylSpecies=obj2.first().find("option:selected").text();    
     	  			    var ylPrice=obj3.eq(0).find("input").val();       	  			         	  			   
     	  			    var ylWeight=obj3.eq(1).find("input").val();   	  			    
     	  			    var ylFactory=obj3.eq(2).find("input").val();   
     	  			    var ylnote=obj3.eq(3).find("input").val();        	  			     	  			       	  			     	  			    	     	  			   		
     	  			    var newData = {
     	  			    		    id:row.id,
     	  			    		    ylDate:ylDate,     	  			    		    
     	  			    		    ylSpecies:ylSpecies,
     	  			    		    ylPrice: Number(ylPrice),   	  			    		   
     	  			    		    ylWeight:Number(ylWeight),
     	  			    		    ylFactory:ylFactory,
     	  			    		    ylnote:ylnote,    	  			    		     	  			    		 
     	  				    };	                     					
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValidyl(newData)){	
                         newData["ylTotalPrice"]=parseFloat((newData["ylPrice"]*newData["ylWeight"]).toFixed(2));					  
     	  				//给后台发送ajax请求，修改数据						
						
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/BusinessPurchase/modifyMaterialPurchase",//修改原料记录  向后台发送一条原料记录 后台返回的result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	        	          
     		                      if(data.code==0){
     		                    	  $("#tb_yl").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: newData,
     		      				    });     		                    	  
     		                    	  //toastr.success(data.msg);
     		                    	 var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                       }else{
     		                    	   $("#tb_yl").bootstrapTable('updateRow', {
     		       				        index: index,
     		       				        row: row
     		       				    });
     		                    	   //var msg=data.msg;
     		                   		   //toastr.error(msg);
     		                    	  var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                    	   		   
     		                        }      		                 
     		                      },
     		                      error : function(err){
     		                	    	toastr.error('请连接网络');
     		                           }
     		                      
     		                   });
     	  				
     	  			  }   				
     	             });
     		   
			   },
			   "click #ylTablequxiao":function(e,value,row,index){	    		
	 				  $("#tb_yl").bootstrapTable('updateRow', {
	  				        index: index,
	  				        row: row,
	  				    });
	       			    
	     		   }  
			   
			   }
			   //验证输入是否合法
            function isValidyl(newData){   
			   if(newData["ylDate"]==""){
				     toastr.info('请输入采购日期');
					 return false;
				} 	
				if(!isTwoFloat(newData["ylPrice"])){
				     toastr.info('单价为不超过两位小数的正数');
					 return false;
				}
				if(!isThreeFloat(newData["ylWeight"])){
				     toastr.info('重量为不超过三位小数的正数');
					 return false;
				}				
				if(isNull(newData["ylFactory"])){
				     toastr.info('请输入厂家');
					 return false;
				} 
	 
    		   return true;
			
		
            }
			   
			   //为操作列添加按钮
            function hjAddFunctionAlty(value,row,index){
         	   return ['<button id="hjTableEditor" type="button" class="btn btn-default btn-xs hjedit">编辑</button>&nbsp;' ,
         		   '<button id="hjTableSave" type="button" class="btn btn-default btn-xs hjsave" disabled="disabled">保存</button>&nbsp;',
         		  '<button id="hjTablequxiao" type="button" class="btn btn-default btn-xs hjquxiao">取消</button>',
         		   ].join("")
            }
			//按钮的事件 编辑以及保存
            window.hjoperateEvents={
     		   "click #hjTableEditor":function(e,value,row,index){	
     		   },
     		   "click #hjTableSave":function(e,value,row,index){
     			     $("body").one('click','#tb_hj tr .hjsave',  function () {
     	            	var obj1 = $(this).parent().parent().children(".hjtimeeditable");
						var obj2 =$(this).parent().parent().children(".hjeditable");
     	  			   
     	  			   
     	  			    var hjDate=obj1.first().find("input").val();
     	  			    var hjSpecies=obj2.eq(0).find("input").val();       	  			         	  			   
     	  			    var hjPrice=obj2.eq(1).find("input").val();   	  			    
     	  			    var hjNumber=obj2.eq(2).find("input").val();   
     	  			    var hjFrom=obj2.eq(3).find("input").val();
						var hjNote=obj2.eq(4).find("input").val();
     	  			    var newData = {
     	  			    		    id:row.id,
     	  			    		    hjDate:hjDate,     	  			    		    
     	  			    		    hjSpecies: hjSpecies,
     	  			    		    hjPrice: Number(hjPrice),   	  			    		   
     	  			    		    hjNumber:Number(hjNumber),
     	  			    		    hjFrom:hjFrom,
     	  			    		    hjNote:hjNote,
     	  			    		    	  			    		 
     	  				    };	                  					
     	  			  //如果输入合法则发送请求到后台修改数据
					  
     	  			  if(isValidhj(newData)){	
                         newData["hjTotalPrice"]=parseFloat((newData["hjPrice"]*newData["hjNumber"]).toFixed(2));					  
     	  				//给后台发送ajax请求，修改数据						
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/BusinessPurchase/modifyHanjiPurchase",//修改焊剂记录  向后台发送一条焊剂记录 后台返回的result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	        	          
     		                      if(data.code==0){
     		                    	  $("#tb_hj").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: newData,
     		      				    });     		                    	  
     		                    	  //toastr.success(data.msg);
     		                    	 var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                       }else{
     		                    	   $("#tb_hj").bootstrapTable('updateRow', {
     		       				        index: index,
     		       				        row: row
     		       				    });
     		                    	   //var msg=data.msg;
     		                   		   //toastr.error(msg);
     		                    	  var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                    	   		   
     		                        }      		                 
     		                      },
     		                      error : function(err){
     		                	    	toastr.error('请连接网络');
     		                           }
     		                      
     		                   });
     	  				
     	  			  }   	  			
     	             });
     		   },
 			  "click #hjTablequxiao":function(e,value,row,index){	    		
				  $("#tb_hj").bootstrapTable('updateRow', {
 				        index: index,
 				        row: row,
 				    });
      			    
    		   }  
			   }
			     //验证输入是否合法
            function isValidhj(newData){   
			   if(newData["hjDate"]==""){
				     toastr.info('请输入采购日期');
					 return false;
				} 	
				if(isNull(newData["hjSpecies"])){
				     toastr.info('请输入种类');
					 return false;
				} 
				if(!isTwoFloat(newData["hjPrice"])){
				     toastr.info('单价为不超过两位小数的正数');
					 return false;
				}
				if(!isInteger(newData["hjNumber"])){
				     toastr.info('数量为正整数');
					 return false;
				}				
				if(isNull(newData["hjFrom"])){
				     toastr.info('请输入厂家');
					 return false;
				} 
	 
    		   return true;
			
		
            }
			   
			   
			     //为操作列添加按钮
            function hpAddFunctionAlty(value,row,index){
         	   return ['<button id="hpTableEditor" type="button" class="btn btn-default btn-xs hpedit">编辑</button>&nbsp;' ,
         		   '<button id="hpTableSave" type="button" class="btn btn-default btn-xs hpsave" disabled="disabled">保存</button>&nbsp;', 
         		  '<button id="hpTablequxiao" type="button" class="btn btn-default btn-xs hpquxiao">取消</button>',
         		   ].join("")
            }
			//按钮的事件 编辑以及保存
            window.hpoperateEvents={
     		   "click #hpTableEditor":function(e,value,row,index){	
     		   },
     		   "click #hpTableSave":function(e,value,row,index){
     			     $("body").one('click','#tb_hp tr .hpsave',  function () {
     	            	var obj1 = $(this).parent().parent().children(".hptimeeditable");
						var obj2=$(this).parent().parent().children(".hpshape");
						var obj3=$(this).parent().parent().children(".hpmodel");
						var obj4 =$(this).parent().parent().children(".hpeditable");
     	  			   
     	  			   
     	  			    var hpDate=obj1.first().find("input").val();
     	  			    var hpShape=obj2.first().find("option:selected").text();
						var hpModel=obj3.first().find("option:selected").text();
     	  			    var hpSpec=obj4.eq(0).find("input").val();       	  			         	  			   
     	  			    var hpPrice=obj4.eq(1).find("input").val();   	  			    
     	  			    var hpWeight=obj4.eq(2).find("input").val();   
     	  			    var hpFactory=obj4.eq(3).find("input").val();
						var hpNote=obj4.eq(4).find("input").val();  
     	  			    var newData = {
     	  			    		    id:row.id,
     	  			    		    hpDate:hpDate,     	  			    		    
     	  			    		    hpShape:hpShape,
     	  			    		    hpModel: hpModel,   	  			    		   
     	  			    		    hpSpec:hpSpec,
     	  			    		    hpPrice:Number(hpPrice),
     	  			    		    hpWeight:Number(hpWeight),  
									hpFactory:hpFactory,
									hpNote:hpNote,
     	  				    };
                     					
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValidhp(newData)){	
                         newData["hpTotalPrice"]=parseFloat((newData["hpPrice"]*newData["hpWeight"]).toFixed(2));					  
     	  				//给后台发送ajax请求，修改数据							
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/BusinessPurchase/modifyHanpianPurchase",//修改焊片记录  向后台发送一条焊片记录 后台返回的result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	        	          
     		                      if(data.code==0){
     		                    	  $("#tb_hp").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: newData,
     		      				    });     		                    	  
     		                    	  //toastr.success(data.msg);
     		                    	 var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                       }else{
     		                    	   $("#tb_hp").bootstrapTable('updateRow', {
     		       				        index: index,
     		       				        row: row
     		       				    });
     		                    	   //var msg=data.msg;
     		                   		  // toastr.error(msg);
     		                    	  var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    							                    			
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
     		                    	   		   
     		                        }      		                 
     		                      },
     		                      error : function(err){
     		                	    	toastr.error('请连接网络');
     		                           }
     		                      
     		                   });
     	  				
     	  			  }  	  			
     	             });
     		   },
 			  "click #hpTablequxiao":function(e,value,row,index){	    		
				  $("#tb_hp").bootstrapTable('updateRow', {
 				        index: index,
 				        row: row,
 				    });
      			    
    		   }  
			   }
	      //验证输入是否合法
            function isValidhp(newData){   
			   if(newData["hpDate"]==""){
				     toastr.info('请输入采购日期');
					 return false;
				} 	
				if(!isSpecValid(newData["hpSpec"])){
					toastr.info('焊片规格请填写为1*1*1的格式');
					 return false;
				} 
				if(!isTwoFloat(newData["hpPrice"])){
				     toastr.info('单价为不超过两位小数的正数');
					 return false;
				}
				if(!isThreeFloat(newData["hpWeight"])){
				     toastr.info('重量为不超过三位小数的正数');
					 return false;
				}				
				if(isNull(newData["hpFactory"])){
				     toastr.info('请输入厂家');
					 return false;
				} 
	 
    		   return true;
			
		
            }
            //验证输入的规格格式      
            function isSpecValid(str){
                if(isNull(str)){
                 return false;
                 }
                 var regu = /^(\d+(\.\d+)?)\*(\d+(\.\d+)?)\*(\d+(\.\d+)?)$/ ;	
                 var re = new RegExp(regu);	
                 return re.test(str);
             }
	     //判断为正整数
		  function isInteger(s){  
	        var re = /^[0-9]*[1-9][0-9]*$/ ;
             return re.test(s);
            }     
	      //判断为不超过两位的小数的正数
		  function isTwoFloat(data){            	
            	if(isNaN(data)){
            		return false;
            	}
            	else{
				    if(data<=0){
        		    return false;
        	        }
            		data=data+"";
            	}
                if(data.split('.').length > 1 && data.split('.')[1].length>2){
                	
                    return false;
                }
            	return true;
            }
			 //判断为不超过三位的小数的正数
			function isThreeFloat(data){            	
            	if(isNaN(data)){
            		return false;
            	}
            	else{
				    if(data<=0){
        		    return false;
        	        }
            		data=data+"";
            	}
                if(data.split('.').length > 1 && data.split('.')[1].length>3){
                	
                    return false;
                }
            	return true;
            }
		  //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
            function isNull(str){
            	if(!str) return true;
                 if ( str == "" ) return true;
                 var regu = "^[ ]+$";
                 var re = new RegExp(regu);
                 return re.test(str);
             }
          function addpurchase(){
        	  window.location.href = path+"business_newpurchase.jsp"; 
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
            <li style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickpurchaserecord()">
            <i class="glyphicon glyphicon-edit"></i>
                                        采购管理
            </a>
            </li>
            <li>
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
                 <div style="float:left;">                    
                        <button id="newpurchasebutton"  type="button" class="btn btn-primary"  onclick="addpurchase()">添加采购单</button>                                               
                 </div>                                                         
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
                  <div style="white-space:pre;float:left;">    厂家</div>
                  <div style="float:left;">
                   <input id="factory1" type='text' placeholder="请填写厂家" />  
                 </div>   
                  <div style="white-space:pre;float:left;">     种类</div>
                 <div style="float:left;">
                       <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                                <option value="1">全部</option>                                                                                 
                                <option value="2">银</option>   
                                <option value="3">铜</option>   
                                <option value="4">锌</option> 
                                <option value="5">镉</option> 
                                <option value="6">锡</option>                                                     
                              </select>
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
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_yl"></table>
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
                 <div style="white-space:pre;float:left;">    厂家</div>
                  <div style="float:left;">
                   <input id="factory2" type='text' placeholder="请填写厂家" />  
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
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hj"></table>
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
                 <div style="white-space:pre;float:left;">    厂家</div>
                  <div style="float:left;">
                   <input id="factory3" type='text' placeholder="请填写厂家" />  
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
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hp"></table>
                   </div>
               </div>
                

        

      </div>
      </div>
   </div>
</body>
</html>