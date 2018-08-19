<!-- 原料修正盘点页面 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <!--<link href="../css/tabulator_semantic-ui.min.css" rel="stylesheet">  -->
    <link href="../css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="../js/tabulator.min.js"></script>
    <link  rel="stylesheet" href="../css/toastr.min.css">  
    <script src="../js/toastr.min.js"></script>
    <script src="../js/path.js"></script>
    <script src="../js/dialog.js"></script>
    <script type="text/javascript">
   
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
            //点击编辑按钮触发以下事件，delegate修复了翻页后按钮无效的问题
             $("body").on('click','#tb_departments tr .edit1', function () {           	
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
        	var temp = {
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                   model:$("#select1").find("option:selected").text()
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/FactoryPd/getMaterialInventory",
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result;                   		
                	     $('#tb_departments').bootstrapTable({                           
                             striped: true,                      //是否显示行间隔色
                             cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                             sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）       
                             uniqueId: "ylId",                     //每一行的唯一标识，一般为主键列                                     
                             columns:[[                    	
                               {field: 'ylType',title: '原料种类'}, 
                               {field: 'ylremainingInventory',title: '剩余库存',class: 'editable'}, 
                               {field: 'opeartion',title: '操作',events:operateEvents,formatter:AddFunctionAlty}
                               ],                                                         
                               ] ,
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
    	   return ['<button id="TableEditor" type="button" class="edit1 btn btn-default edit btn-xs " delsong="1">编辑</button>&nbsp;' ,
    		   '<button id="TableSave" type="button" class="btn btn disabled save btn-xs" disabled="disabled">保存</button>&nbsp;',
    		   '<button id="Tablequxiao" type="button" class="btn btn-default btn-xs quxiao">取消</button>',
    		   ].join("")
       }

       //按钮的事件 编辑以及保存
       window.operateEvents={
		   "click #TableEditor":function(e,value,row,index){	
		   },
		   "click #TableSave":function(e,value,row,index){
			     $("body").one('click','#tb_departments tr .save', function () {
	            	var obj =$(this).parent().parent().children(".editable")
                    var ylremainingInventory= obj.eq(0).find("input").val();	            	
	  			    var materialInventory = {
	  			    		    ylId:row.ylId,
	  			    		    ylremainingInventory:parseFloat(ylremainingInventory),
	  			    		    ylType:row.ylType
			    		
	  				    };	  			    
	  			  //如果输入合法则发送请求到后台修改数据
	  			  if(isValid(materialInventory)){	  				  
	  				//给后台发送ajax请求，修改数据
	  				  $.ajax({
		                      type:"POST",
		                      url:"/plantSCM/FactoryPd/modifyMaterialInventory",
		                      contentType:"application/json;charset=UTF-8",
		                      data:JSON.stringify(materialInventory),
		                      dataType:"json",
		                      success:function(data){  	        	          
		                      if(data.code==0){
		                    	  $("#tb_departments").bootstrapTable('updateRow', {
		      				        index: index,
		      				        row: materialInventory
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
    	  
		    if(isThreeFloat(newData["ylremainingInventory"])){
		    	return true;
		    	
		    }
		   return false;
        }
        //验证某一个数字是否是不超过三位的小数
        function isThreeFloat(data){        	
        	if(isNaN(data)|data<0){
        		return false;
        	}
        	else{
        		data=data+"";
        	}
            if(data.split('.').length > 1 && data.split('.')[1].length>3){
            	
                return false;
            }
        	return true;
        }
      //左侧栏点击事件
        function clickopenrecord(){
        	 window.location.href = path+"factory_openfactoryrecord.jsp";        	
        }
        function clickhpoutrecord(){
        	window.location.href = path+"factory_hpoutrecord.jsp";
        }
        function clickpandian(){
        	window.location.href = path+"factory_inventory.jsp";
        }        
        function clickxiuzheng(){
        	window.location.href = path+"factory_mat_inventory.jsp";
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

        function logoff(){
        	  localStorage.clear();
        	  window.location.href='logoff';
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
                                <li class="role-navbar-nav " id="factory-navbar-nav"><a href="javascript:void(0)" onclick="warehousemanage()">仓库</a></li>
                            </ul>
							 <ul class="nav navbar-nav">
                                <li class="role-navbar-nav active" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="facrorymanage()">工厂</a></li>
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
            <a  href="javascript:void(0);" onclick="clickopenrecord()">
            <i class="glyphicon glyphicon-edit"></i>
                                           开炉登记
            </a>
            </li>
            <li>
            <a href="javascript:void(0);" onclick="clickhpoutrecord()">
            <i class="glyphicon glyphicon-edit"></i>
                                        出厂记录
            </a>
            </li>
            <li>
            <a href="javascript:void(0);" onclick="clickpandian()">
            <i class="glyphicon glyphicon-edit"></i>
                                         盘点清仓
            </a>
            </li>
            <li  style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickxiuzheng()">
             <i class="glyphicon glyphicon-edit"></i>
                                        原料盘点修正
            </a>
            </li>            
                    
            </ul>
            </div>
             <!--垂直导航栏结束-->
        
           <div class="col-xs-11 col-md-11">               
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_departments"></table>
                   </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>