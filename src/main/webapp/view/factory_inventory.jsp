
<!-- 盘点清仓页面 -->
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
        	//设置选择型号框的属性
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
        	 //1.初始化Table
             initTable();            
             //获取并显示产品型号                   
             getModel();                  
            //点击编辑按钮触发以下事件，delegate修复了翻页后按钮无效的问题
             $("body").on( 'click', '#tb_departments tr .edit1',function () {           	
            	  $(".edit").addClass("btn disabled");
    			  $(".edit").attr("disabled",true);
    			   $(this).addClass("btn disabled");
    			   $(this).attr("disabled",true);
    			   $(this).next().removeClass("btn disabled");
    			   $(this).next().attr("disabled",false);
    			   $(this).next().addClass("btn btn-default"); 
    			   $(this).parent().parent().children(".timeeditable").each(function(){       			  			     				   			 
    		           var value = $(this).text(); 
    		           var k=this.clientWidth/3*2;  
    		          $(this).html(" <div class='input-group date' id='datetimepicker3'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择结束日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
    		          var picker3 = $('#datetimepicker3').datetimepicker({          
    		        		 format: 'YYYY-MM-DD',          
    		        		 locale: moment.locale('zh-cn'), 
    		        		 defaultDate: value
    		        		 });    
    		       });
                   $(this).parent().parent().children(".model").each(function(){  
    				
                    var oldtext=$(this).text();
                    $(this).html("<select id='select8'></select>");  
                    getModelTable(oldtext);
                    
               });   		
    				  $(this).parent().parent().children(".editable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    		        
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");
    		       });
             });            
        }); 
         //获取产品型号
         function getModel(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/FactoryPd/getModel",//后台
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
        //获取产品型号 表格
        function getModelTable(oldvalue){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/FactoryPd/getModel",
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
        //点击搜索按钮触发search函数
        function search(){       	
          	var temp = {
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                   Model:$("#select1").find("option:selected").text()
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/FactoryPd/getFactoryPdRecord",
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		var result=data.result;
                		$("#tb_departments").bootstrapTable('load', result);            
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
        
        function initTable(){
        	var temp = {
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                   Model:$("#select1").find("option:selected").text()
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/FactoryPd/getFactoryPdRecord",
                data:temp,
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
                             columns:[[                    	
                               {title: '',rowspan:2,formatter: function (value, row, index) {return index+1;}}, 
                               {field: 'model',rowspan:2,title: '产品型号',class: 'model',sortable : true}, 
                               {field: 'inventoryDate',rowspan:2,title: '盘点时间',class: 'timeeditable',sortable : true},
                               {
                                title:'加工前',colspan:7,
                                },
                                {
                                 title:'加工后',colspan:7,
                                 },
                               {title:"误差",rowspan:2, field:"dValue",formatter:bianse},
                               {field: 'opeartion',rowspan:2,title: '操作',events:operateEvents,formatter:AddFunctionAlty}
                               ],
                               [
                               {field: 'beforeBlanks',title: '胚料',class: 'editable',sortable : true}, 
                               {field: 'beforeWaste',title: '废料',class: 'editable',sortable : true}, 
                               {field: 'beforeBulk',title: '散料',class: 'editable',sortable : true},
                               {field: 'beforeSemi',title: '半成品',class: 'editable',sortable : true} , 
                               {field: 'beforeProduct',title: '成品',class: 'editable',sortable : true},
                               {field: 'beforeDailiao',title: '呆料',class: 'editable',sortable : true},
                               {field: 'beforeTotal',title: '总重量',sortable : true},
                               {field: 'afterSale',title:'销量',class: 'editable',sortable : true}, 
                               {field: 'afterWaste',title: '废料',class: 'editable',sortable : true}, 
                               {field: 'afterBulk',title: '散料',class: 'editable',sortable : true},
                               {field: 'afterSemi',title: '半成品',class: 'editable',sortable : true} , 
                               {field: 'afterProduct',title: '成品',class: 'editable',sortable : true},
                               {field: 'afterDailiao',title: '呆料',class: 'editable',sortable : true},
                               {field: 'afterTotal',title: '总重量',sortable : true},
                               ],
                              
                               ],
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
        function bianse(value,row,index){
            if(value>=1 || value<=-1){
                return "<span style='color:red'>"+value+"<span>";
            }else{
                return value;
            }
            
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
	  			    var obj2 = $(this).parent().parent().children(".timeeditable")
	  			    var obj3=$(this).parent().parent().children(".model");
                    var inventory_date = obj2.first().find("input").val();
                    var model=obj3.first().find("option:selected").text();  
                    var before_blanks = obj.eq(0).find("input").val();
                    var before_waste = obj.eq(1).find("input").val();
                    var before_bulk = obj.eq(2).find("input").val();
                    var before_semi = obj.eq(3).find("input").val();
                    var before_product = obj.eq(4).find("input").val();
                    var before_dailiao = obj.eq(5).find("input").val();
                    var after_sale = obj.eq(6).find("input").val();
                    var after_waste = obj.eq(7).find("input").val();
                    var after_bulk = obj.eq(8).find("input").val();
                    var after_semi = obj.eq(9).find("input").val();
                    var after_product = obj.eq(10).find("input").val();
                    var after_dailiao = obj.eq(11).find("input").val();
                   
	  			    var newData = {
	  			    		    id:row.id,
	  				    		inventoryDate: inventory_date,
	  				    		model: model,
                                beforeBlanks:Number(before_blanks),
                                beforeWaste:Number(before_waste),
                                beforeBulk:Number(before_bulk),
                                beforeSemi:Number(before_semi),
                                beforeProduct:Number(before_product),
                                beforeDailiao:Number(before_dailiao),
                                //beforeTotal:before_total,
                                afterSale:Number(after_sale),
                                afterWaste:Number(after_waste),
                                afterBulk:Number(after_bulk),
                                afterSemi:Number(after_semi),
                                afterProduct:Number(after_product),
                                afterDailiao:Number(after_dailiao),
                                //afterTotal:after_total,
                                //dValue:after_total-before_total,

	  				    };	  			    
	  			  //如果输入合法则发送请求到后台修改数据
	  			  if(isValid(newData)){	 
                    newData.beforeTotal=parseFloat((newData.beforeBlanks+newData.beforeWaste+newData.beforeBulk+newData.beforeSemi+newData.beforeDailiao+newData.beforeProduct).toFixed(3));
                        //newData.beforeTotal=newData.beforeBlanks+newData.beforeWaste+newData.beforeBulk+newData.beforeSemi+newData.beforeDailiao+newData.beforeProduct;
                        newData.afterTotal=parseFloat((newData.afterSale+newData.afterWaste+newData.afterBulk+newData.afterSemi+newData.afterDailiao+newData.afterProduct).toFixed(3));
                        newData.dValue=parseFloat((newData.afterTotal-newData.beforeTotal).toFixed(3));
                       
                         			  
	  				//给后台发送ajax请求，修改数据
	  				  $.ajax({
		                      type:"POST",
		                      url:"/plantSCM/FactoryPd/modifyFactoryPdRecord",
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
            if(newData["inventoryDate"]===""){
                toastr.info("请选择盘点日期");
                return false;
            }
            if(newData["model"]===""){
                toastr.info("型号不能为空");
                return false;
            }
            if(!isThreeFloat(newData["beforeBlanks"])){
			   toastr.info("胚料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["beforeWaste"])){
			   toastr.info("废料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["beforeBulk"])){
			   toastr.info("散料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["beforeSemi"])){
			   toastr.info("半成品重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["beforeProduct"])){
			   toastr.info("成品重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["beforeDailiao"])){
			   toastr.info("呆料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterSale"])){
			   toastr.info("销量重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterWaste"])){
			   toastr.info("废料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterBulk"])){
			   toastr.info("散料重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterSemi"])){
			   toastr.info("半成品重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterProduct"])){
			   toastr.info("成品重量为不超三位小数的正数");
			   return false;
			}
            if(!isThreeFloat(newData["afterDailiao"])){
			   toastr.info("呆料重量为不超三位小数的正数");
			   return false;
			}     	  		
		   return true;
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
        function addnewfactory(){
        	window.location.href = path+"factory_newinventory.jsp";
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
            <li style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickpandian()">
            <i class="glyphicon glyphicon-edit"></i>
                                         盘点清仓
            </a>
            </li>
            <li>
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
                <div style="float:left;"> 
                                                            日期</div>
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
                 <div style="white-space:pre;float:left;">  产品型号</div>
                 <div style="float:left;">
                        <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div> 
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="search()">搜索</button>
                         &nbsp;
                        <button id="newfactorybutton"  type="button" class="btn btn-primary"  onclick="addnewfactory()">新增盘点清仓</button>
                 </div>                                                          
               </div>       
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