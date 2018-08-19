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
    <script src="../js/bootstrap-table.min.js"></script>
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
    <script src="../js/dialog.js"></script>
    <script>
   
        $(function () {
        	//在右上角添加用户名字
        	 var storage=window.localStorage;            
             $("#staff-name").html(storage["staffname"]);
        	//设置提示框的属性
        	toastr.options.timeOut = 1800;
        	toastr.options.positionClass = 'toast-top-center';
        	toastr.options.preventDuplicates = true;
          	
        	 //1.初始化Table
             initTable();                  
                             
             $("body").delegate('#tb_departments tr .edit1', 'click', function () {           	
            	  $(".edit").addClass("btn disabled");
    			  $(".edit").attr("disabled",true);
    			   $(this).addClass("btn disabled");
    			   $(this).attr("disabled",true);
    			   $(this).next().removeClass("btn disabled");
    			   $(this).next().attr("disabled",false);
    			   $(this).next().addClass("btn btn-default");   		
    				  $(this).parent().parent().children(".editable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    		        
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");
    		       });
             });            
        }); 
      
    
        function initTable(){
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/WarehouseInventory/getHpInventoryRecord",
              
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;  
                		
                	     $('#tb_departments').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             pagination: true,                   //是否显示分页（*）
                             sortable: true,                     //是否启用排序
                             sortOrder: "asc",                   //排序方式
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             pageNumber:1,                       //初始化加载第一页，默认第一页
                             pageSize: 5,                       //每页的记录行数（*）
                             pageList: [5,10],        //可供选择的每页的行数（*）
                             clickToSelect: true,                //是否启用点击选中行
                             //height: 400,                       //启用改参数会导致表格对不齐
                             uniqueId: "id",                     //每一行的唯一标识，一般为主键列                                     
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                           {
                                 field: 'model',
                                 title: '型号',
                                 class: 'editable1',
                                 sortable : true
                             }, {
                                 field: 'shape',
                                 title: '形状',
                                 class: 'editable1',
                                 sortable : true
                             }, {
                                 field: 'spec',
                                 title: '规格',
                                 class: 'editable1',
                                 sortable : true
                             }, {
                                 field: 'actualNumber',
                                 title: '重量',
                                 class: 'editable',
                                 sortable : true
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:operateEvents,
                                 formatter:AddFunctionAlty,
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
       function AddFunctionAlty(value,row,index){
    	   return ['<button id="TableEditor" type="button" class="edit1 btn btn-default btn-xs edit  " delsong="1">编辑</button>&nbsp;' ,
    		   '<button id="TableSave" type="button" class="btn btn disabled btn-xs save" disabled="disabled">保存</button>&nbsp;',
    		   '<button id="Tablequxiao" type="button" class="btn btn-default btn-xs quxiao">取消</button>',
    		   ].join("")
       }

       //按钮的事件 编辑以及保存
       window.operateEvents={
		   "click #TableEditor":function(e,value,row,index){	
		   },
		   "click #TableSave":function(e,value,row,index){
			     $("body").delegate('#tb_departments tr .save', 'click', function () {
	            	var obj =$(this).parent().parent().children(".editable")
	  			
	  			//	var hpkc_id=obj.find("input").val();
	  				var model=row.model;
	  				var shape=row.shape;
	  				var spec=row.spec;
	  				var actualNumber=obj.eq(0).find("input").val(); 
	  				
	  				
	  			    var newData = {
	  			    		    
	  				    
	  			    			hpkcId:row.hpkcId,
	  				    		model:model,
	  				    	    shape:shape,
	  				    		spec:spec,
	  				    		actualNumber:actualNumber
	  				    	
			    		
	  				    };
	  			  //如果输入合法则发送请求到后台修改数据
	  			  if(isValid(newData)){	  				  
	  				//给后台发送ajax请求，修改数据
	  				  $.ajax({
		                      type:"POST",
		                      url:"/plantSCM/WarehouseInventory/modifyHpInventoryRecord",
		                      contentType:"application/json;charset=UTF-8",
		                      data:JSON.stringify(newData),
		                      dataType:"json",
		                      success:function(data){  	        	          
		                      if(data.code==0){
		                    	  $("#tb_departments").bootstrapTable('updateRow', {
		      				        index: index,
		      				        row: newData
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
		                    	   $("#tb_departments").bootstrapTable('updateRow', {
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
	  			  }else{
	  				  toastr.info("请正确输入");
	  				

	  			  }
	             });
		   },
		   "click #Tablequxiao":function(e,value,row,index){	    		
				  $("#tb_departments").bootstrapTable('updateRow', {
				        index: index,
				        row: row,
				    });
 			    
		   }  
			 
	    }
       //验证输入是否合法
       function isValid(newData){           	
		    if( !isNaN(newData["actualNumber"])&&!isNull(newData["actualNumber"])&&newData["actualNumber"]>=0&&  isThreeFloat(newData["actualNumber"])
		    		){		    	
		    	return true;
		    	
		    }
		   return false;
       }

       //验证输入是否为空或者全部为空字符串   
       function isNull(str){
            if ( str == "" ) return true;
            var regu = "^[ ]+$";
            var re = new RegExp(regu);
            return re.test(str);
        }    
     
      function isThreeFloat(value){
             var datastr=value+"";
    	if(datastr.split('.').length > 1 && datastr.split('.')[1].length>3){
        	//alert("超过三位小数");
            return false;
        }
            return true;
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
            <a href="#systemSetting2" class="nav-header collapsed" data-toggle="collapse"  >            
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
            <a href="#systemSetting3" class="nav-header collapsed" data-toggle="collapse"  >
            <i class="glyphicon glyphicon-edit"></i>
                                         库存管理
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="systemSetting3" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li style="background-color:#F0FFFF;"><a href="javascript:void(0)" onclick="clickhpinventory()">焊片库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjinventory()">焊剂库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhpprint()">焊片打印</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjprint()">焊剂打印</a></li>
            </ul>
            </li>
                      
                    
            </ul>
            </div>
             <!--垂直导航栏结束-->
        
           <div class="col-xs-11 col-md-11">          
                <div class="row">
              
                                                                    
               </div>       
               <div class="row">
			    <div class="col-xs-8 col-md-8"> 
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_departments"></table>
                   </div>
				   </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>