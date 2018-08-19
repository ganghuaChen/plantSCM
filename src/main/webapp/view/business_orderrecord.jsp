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
	<script src="../js/bootstrap3-typeahead.min.js"></script>
	<script src="../js/dialog.js"></script>
	<script src="../js/path.js"></script>
    <script>
    
        $(function () {
        	
        	//var showme = document.getElementById("shangwunav");
      	    //showme.style.display="none";
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
        	 $('#select4').selectpicker({
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
        	 //初始化焊片表
             inithptable();
        	 //初始化焊剂表
        	 inithjtable();
             //获取并显示产品型号            
             getModel();  
             getReceiverhp();
			 getReceiverhj();
                                     
   
        }); 
		     //获取联系人
        function getReceiverhp(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getCustomer",//从后台获取收货人列表   url记得改  这里不是getModel
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		$("#receiver").typeahead({
                            source: result, // 数据源
                            autoSelect:false,
                            changeInputOnMove:false,
                           
                      
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
		   //获取联系人
        function getReceiverhj(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getCustomer",//从后台获取收货人列表   url记得改  这里不是getModel
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		$("#receiver2").typeahead({
                            source: result, // 数据源
                            autoSelect:false,
                            changeInputOnMove:false,
                           
                      
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
       
        //获取产品型号
        function getModel(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getModel",//获取产品型号  没有传入参数  返回数据中的result为产品型号数组
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
      //点击搜索按钮搜索焊片
        function search(){       	
        	var temp = {
        			hpCustomerName:$("#receiver").val(),
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                    hporderState:$("#select1").find("option:selected").text(), 
                    hporderShape:$("#select2").find("option:selected").text(),
                    hporderModel:$("#select3").find("option:selected").text(),             
                };
        	
        	if(temp.beginDate==""){
        		toastr.info("请选择开始时间");
        	}else if(temp.endDate==""){
        		toastr.info("请选择结束时间");
        	}else{
        		$.ajax({
                    type:"GET",
                    url:"/plantSCM/BusinessOrder/getHanpianOrder",//获取焊片订单记录   传入参数为收货人、开始日期、结束日期、订单状态、产品形状、产品型号     返回数据中的result为焊片订单记录
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
      //点击搜索按钮搜索焊剂
      function searchhj(){
    	  var temp = {
    			  hjCustomerName:$("#receiver2").val(),
                  beginDate:$("#datetimepicker3").find("input").val(),
                  endDate: $("#datetimepicker4").find("input").val(),
                  hjorderState:$("#select4").find("option:selected").text(),                
              };
      
      	if(temp.beginDate==""){
      		toastr.info("请选择开始时间");
      	}else if(temp.endDate==""){
      		toastr.info("请选择结束时间");
      	}else{
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getHanjiOrder",//获取焊剂订单记录     传入参数为收货人、开始日期、结束日期、订单状态     返回数据中的result为焊剂订单记录
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
      //初始化焊片订单记录表
            function inithptable(){
        	var temp = {
        			hpCustomerName:$("#receiver").val(),
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                    hporderState:$("#select1").find("option:selected").text(), 
                    hporderShape:$("#select2").find("option:selected").text(),
                    hporderModel:$("#select3").find("option:selected").text(),
                    
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getHanpianOrder",//获取焊片订单记录   传入参数为收货人、开始日期、结束日期、订单状态、产品形状、产品型号     返回数据中的result为焊片订单记录
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
                             uniqueId: "hporderId",                     //每一行的唯一标识，一般为主键列         
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
                                 field: 'hporderDate',
                                 title: '下单日期',
                                 class: 'xdtimeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'hpCustomerName',
                                 title: '收货人',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'hporderPhone',
                                 title: '电话',
                                 class: 'editable',
                                 sortable : true,
                                
                             }, {
                                 field: 'hporderPerformer',
                                 title: '执行人',
                                 class: 'performer',
                                 sortable : true
                             }, {
                                 field: 'hpdeliveryDate',
                                 title: '应送达日期',
                                 class: 'ddtimeeditable',
                                 sortable : true
                             }, {
                                 field: 'hporderShape',
                                 title: '形状',
                                 class: 'shape',
                                 sortable : true,
                                 
                             }, {
                                 field: 'hporderModel',
                                 title: '型号',
                                 class: 'model',
                                 sortable : true
                             }, {
                                 field: 'hporderSpec',
                                 title: '规格',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'hporderNumber',
                                 title: '重量',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'hporderPrice',
                                 title: '单价',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'hporderTotalPrice',
                                 title: '总价',                                
                                 sortable : true
                             }, {
                                 field: 'hporderState',
                                 title: '订单状态',
                                 sortable : true
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:operateEvents,
                                 formatter:AddFunctionAlty,
                             }, {
                                 field: 'hporderRemark',
                                 title: '备注',
                                 class: 'editable',
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
            function AddFunctionAlty(value,row,index){
         	   return ['<button id="TableEditor" type="button" class="btn btn-default btn-xs edit">编辑</button>&nbsp;' ,
         		   '<button id="TableSave" type="button" class="btn btn-default btn-xs save" disabled="disabled">保存</button>&nbsp;',
         		  '<button id="Tablequxiao" type="button" class="btn btn-default btn-xs quxiao">取消</button>&nbsp;',
         		  '<button id="TableCancel" type="button" class="btn btn-default btn-xs cancel"  >取消订单</button>',
         		 
         		   ].join("")
            }
            //按钮的事件 编辑以及保存
            window.operateEvents={
     		   "click #TableEditor":function(e,value,row,index){
                if(row.hporderState=="未送达"){
         	       $("body").one('click','#tb_hp tr .edit',  function () {           	
                   	   $(".edit").addClass("btn disabled");
           			   $(".edit").attr("disabled",true);
           			   $(this).addClass("btn disabled");
           			   $(this).attr("disabled",true);
           			   $(this).next().removeClass("btn disabled");
           			   $(this).next().attr("disabled",false);
           			   $(this).next().addClass("btn btn-default"); 
           			   $(this).parent().parent().children(".xdtimeeditable").each(function(){       			  			     				   			 
           		           var value = $(this).text(); 
           		           var k=this.clientWidth/3*2;  
           		          $(this).html(" <div class='input-group date' id='datetimepicker5'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择下单日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
           		          var picker5 = $('#datetimepicker5').datetimepicker({          
           		        		 format: 'YYYY-MM-DD',          
           		        		 locale: moment.locale('zh-cn'), 
           		        		 defaultDate: value
           		        		 });    
           		       });  
           			  $(this).parent().parent().children(".ddtimeeditable").each(function(){       			  			     				   			 
        		           var value = $(this).text(); 
        		           var k=this.clientWidth/3*2;  
        		          $(this).html(" <div class='input-group date' id='datetimepicker6'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择到达日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
        		          var picker5 = $('#datetimepicker6').datetimepicker({          
        		        		 format: 'YYYY-MM-DD',          
        		        		 locale: moment.locale('zh-cn'), 
        		        		 defaultDate: value
        		        		 });    
        		       });   	
           			   $(this).parent().parent().children(".shape").each(function(){
           				   if($(this).text()=="直"){
           					   $(this).html("<select><option value='0' selected>直</option><option value='1'>弯</option></select>");   
           				   }else{
           					   $(this).html("<select><option value='0'  >直</option><option value='1'  selected>弯</option></select>");
           				   }
           				      		         
           		       }); 
           			   $(this).parent().parent().children(".performer").each(function(){
        				   if($(this).text()=="工厂"){
        					   $(this).html("<select><option value='0' selected>工厂</option><option value='1'>仓库</option></select>");   
        				   }else{
        					   $(this).html("<select><option value='0'  >工厂</option><option value='1'  selected>仓库</option></select>");
        				   }
        				      		         
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
				       
				}else{
					toastr.info('只能修改未送达的订单');	  
                } 
     		   },
     		   "click #TableSave":function(e,value,row,index){
     			     $("body").one('click','#tb_hp tr .save',  function () {     			    	
     	            	var obj =$(this).parent().parent().children(".editable");
     	            	var obj1=$(this).parent().parent().children(".shape");
     	  			    var obj2 = $(this).parent().parent().children(".xdtimeeditable");
     	  			    var obj3=$(this).parent().parent().children(".ddtimeeditable"); 
     	  			    var obj4=$(this).parent().parent().children(".performer");
						var obj5=$(this).parent().parent().children(".model");
     	  			    var hporderDate=obj2.first().find("input").val();    	  			 
     	  			    var hpCustomerName=obj.eq(0).find("input").val();    	  			  
     	  			    var hporderPhone=obj.eq(1).find("input").val();     	  			   
     	  			    var hporderPerformer=obj4.first().find("option:selected").text();   
     	  			    var hpdeliveryDate=obj3.first().find("input").val();    	  			  
     	  			    var hporderShape=obj1.first().find("option:selected").text();     	  			              	  			  
					    var hporderModel=obj5.first().find("option:selected").text();    
     	  			    var hporderSpec=obj.eq(2).find("input").val();
     	  			    var hporderNumber=obj.eq(3).find("input").val();  
     	  			    var hporderPrice=obj.eq(4).find("input").val();    	  			 
     	  			    var hporderRemark=obj.eq(5).find("input").val();   	  			   		
     	  			    var newData = {
     	  			    		    hporderId:row.hporderId,
     	  			    		    hporderDate:hporderDate,     	  			    		    
     	  			    		    hpCustomerName: hpCustomerName,
     	  			    		    hporderPhone: hporderPhone,
     	  			    		    hporderPerformer:hporderPerformer,
     	  			    		    hpdeliveryDate:hpdeliveryDate,
     	  			    		    hporderShape:hporderShape,
     	  			    		    hporderModel:hporderModel,
     	  			    		    hporderSpec:hporderSpec,
     	  			    		    hporderNumber:Number(hporderNumber),
     	  			    		    hporderPrice:Number(hporderPrice),     	  			    		   
     	  			    		    hporderRemark:hporderRemark,    	  			    		 
     	  				    };	     	  			
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValid(newData)){	 
                         newData["hporderTotalPrice"]=parseFloat((newData["hporderPrice"]*newData["hporderNumber"]).toFixed(2));                         			 
     	  				//给后台发送ajax请求，修改数据
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/BusinessOrder/modifyHanpianOrder",//修改焊片记录 向后台传一条焊片记录  后台返回是否成功，result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	        	          
     		                      if(data.code==0){
     		                    	  $("#tb_hp").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: newData,
     		      				    }); 
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
     		                    	  //toastr.success(data.msg);
     		                       }else{
     		                    	   $("#tb_hp").bootstrapTable('updateRow', {
     		       				        index: index,
     		       				        row: row
     		       				    });    		                    	   
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
     		  "click #TableCancel":function(e,value,row,index){	    		
				  if(row.hporderState=="未送达"){
					  $('#myModal').modal('show');
					  hporderid=row.hporderId;
	     			  $("#clickcancel").click(function(){
	     				 $('#myModal').modal('hide');
	     				 	$.ajax({
	         	                type:"GET",
	         	                url:"/plantSCM/BusinessOrder/cancelHanpianOrder?id="+hporderid,//取消订单 向后台传订单ID，后台将订单状态修改为已取消,result为null
	         	                //data:temp,
	         	                dataType:"json",
	         	                success:function(data){
	         	                	if(data.code==0){
	         	                		row.hporderState="已取消";
	         	                		$("#tb_hp").bootstrapTable('updateRow', {
	     		      				        index: index,
	     		      				        row: row,
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
	         	            
	         	                	}
	         	                	else{	         	                		
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
	                   });  
				      
				  }else{
					  toastr.info('只能取消未送达的订单');
			  
				  }		
      			    
    		   },
    			  "click #Tablequxiao":function(e,value,row,index){	    		
    				  $("#tb_hp").bootstrapTable('updateRow', {
     				        index: index,
     				        row: row,
     				    });
          			    
        		   }  
     	    }
            //验证输入是否合法
            function isValid(newData){
                if(newData["hporderDate"]==""){
				     toastr.info('请输入下单日期');
					 return false;
				}
				if(!xiadandate(newData["hpdeliveryDate"],newData["hporderDate"])){
				     toastr.info('应送达日期不应早于下单日期');
					 return false;
				} 
				if(isNull(newData["hpCustomerName"])){
				     toastr.info('请输入收货人');
					 return false;
				} 
				
				if(newData["hpdeliveryDate"]==""){
				     toastr.info('请输入送达日期');
					 return false;
				} 
				if(!isSpecValid(newData["hporderSpec"])){
				     toastr.info('焊片规格请填写为1*1*1的格式');
					 return false;
				} 
				if(!isInteger(newData["hporderNumber"])){
				     toastr.info('重量请输入正整数');
					 return false;
				} 
				if(!isTwoFloat(newData["hporderPrice"])){
				     toastr.info('价格为不超过两位小数的正数');
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
			function isInteger(s){  
	        var re = /^[0-9]*[1-9][0-9]*$/ ;
             return re.test(s);
            }           
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
          //初始化焊剂订单记录表
            function inithjtable(){
        	var temp = {
        			hjCustomerName:$("#receiver2").val(),
                    beginDate:$("#datetimepicker3").find("input").val(),
                    endDate: $("#datetimepicker4").find("input").val(),
                    hjorderState:$("#select4").find("option:selected").text(),                    
                };       	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/BusinessOrder/getHanjiOrder",//获取焊剂订单记录     传入参数为收货人、开始日期、结束日期、订单状态     返回数据中的result为焊剂订单记录
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
                             uniqueId: "hjorderId",                     //每一行的唯一标识，一般为主键列         
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
                                 field: 'hjProductDate',
                                 title: '下单日期',
                                 class: 'xdtimeeditable2',
                                 sortable : true,
                                
                             }, {
                                 field: 'hjCustomerName',
                                 title: '收货人',
                                 class: 'editable2',
                                 sortable : true
                             }, {
                                 field: 'hjorderPhone',
                                 title: '电话',
                                 class: 'editable2',
                                 sortable : true,
                                
                             }, {
                                 field: 'hjdeliveryDate',
                                 title: '应送达日期',
                                 class: 'ddtimeeditable2',
                                 sortable : true
                             }, {
                                 field: 'hjType',
                                 title: '种类',
                                 class: 'editable2',
                                 sortable : true,
                                 
                             }, {
                                 field: 'hjorderNumber',
                                 title: '数量',
                                 class: 'editable2',
                                 sortable : true
                             }, {
                                 field: 'hjorderFactory',
                                 title: '厂家',
                                 class: 'editable2',
                                 sortable : true
                             }, {
                                 field: 'hjorderPrice',
                                 title: '单价',
                                 class: 'editable2',
                                 sortable : true
                             }, {
                                 field: 'hjorderTotalPrice',
                                 title: '总价',                             
                                 sortable : true
                             }, {
                                 field: 'hjorderState',
                                 title: '订单状态',                               
                                 sortable : true
                             },{
                                 field: 'opeartion',
                                 title: '操作',
                                 events:operateEvents2,
                                 formatter:AddFunctionAlty2,
                             }, {
                                 field: 'hjorderRemark',
                                 title: '备注',
                                 class: 'editable2',
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
            function AddFunctionAlty2(value,row,index){
         	   return ['<button id="TableEditor2" type="button" class="btn btn-default btn-xs edit2">编辑</button>&nbsp;' ,
         		   '<button id="TableSave2" type="button" class="btn btn-default btn-xs save2" disabled="disabled">保存</button>&nbsp;',
         		  '<button id="Tablequxiao2" type="button" class="btn btn-default btn-xs quxiao2">取消</button>&nbsp;',
         		  '<button id="TableCancel2" type="button" class="btn btn-default btn-xs cancel2" >取消订单</button>',
         		   ].join("")
            }
            //按钮的事件 编辑以及保存
            window.operateEvents2={
     		   "click #TableEditor2":function(e,value,row,index){
                  if(row.hjorderState=="未送达"){
        		      $("body").one('click','#tb_hj tr .edit2',  function () {             	
                    	  $(".edit2").addClass("btn disabled");
            			  $(".edit2").attr("disabled",true);
            			   $(this).addClass("btn disabled");
            			   $(this).attr("disabled",true);
            			   $(this).next().removeClass("btn disabled");
            			   $(this).next().attr("disabled",false);
            			   $(this).next().addClass("btn btn-default"); 
            			   $(this).parent().parent().children(".xdtimeeditable2").each(function(){       			  			     				   			 
            		           var value = $(this).text(); 
            		           var k=this.clientWidth/3*2;  
            		          $(this).html(" <div class='input-group date' id='datetimepicker7'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择下单日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
            		          var picker5 = $('#datetimepicker7').datetimepicker({          
            		        		 format: 'YYYY-MM-DD',          
            		        		 locale: moment.locale('zh-cn'), 
            		        		 defaultDate: value
            		        		 });    
            		       });  
            			  $(this).parent().parent().children(".ddtimeeditable2").each(function(){       			  			     				   			 
         		           var value = $(this).text(); 
         		           var k=this.clientWidth/3*2;  
         		          $(this).html(" <div class='input-group date' id='datetimepicker8'> <input type='text' style='width:"+k+"px;' class='form-control' placeholder='请选择到达日期' />  <span class='input-group-addon'>   <span class='glyphicon glyphicon-calendar'></span> </span>  </div>");
         		          var picker5 = $('#datetimepicker8').datetimepicker({          
         		        		 format: 'YYYY-MM-DD',          
         		        		 locale: moment.locale('zh-cn'), 
         		        		 defaultDate: value
         		        		 });    
         		       });   
            			  $(this).parent().parent().children(".performer2").each(function(){
            				  if($(this).text()=="工厂"){
           					   $(this).html("<select><option value='0' selected>工厂</option><option value='1'>仓库</option></select>");   
           				   }else{
           					   $(this).html("<select><option value='0'  >工厂</option><option value='1'  selected>仓库</option></select>");
           				   }
           				      		         
           		           });    	
            			   $(this).parent().parent().children(".shape2").each(function(){
            				   if($(this).text()=="直"){
            					   $(this).html("<select><option value='0' selected>直</option><option value='1'>弯</option></select>");   
            				   }else{
            					   $(this).html("<select><option value='0'  >直</option><option value='1'  selected>弯</option></select>");
            				   }
            				      		         
            		       });    			 
            				  $(this).parent().parent().children(".editable2").each(function(){  
            				   var k=this.clientWidth;    				 
            		           var value = $(this).text();    	
            		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
            		       });
                     });				       
				  }else{
					  toastr.info('只能修改未送达的订单');				     
				  }		   
     		   },
     		   "click #TableSave2":function(e,value,row,index){
     			     $("body").one('click','#tb_hj tr .save2',  function () {
     	            	var obj =$(this).parent().parent().children(".editable2");
     	  			    var obj2 = $(this).parent().parent().children(".xdtimeeditable2");
     	  			    var obj3=$(this).parent().parent().children(".ddtimeeditable2");       	  			   
     	  			    var hjProductDate=obj2.first().find("input").val();
     	  			    var hjCustomerName=obj.eq(0).find("input").val();   
     	  			    var hjorderPhone=obj.eq(1).find("input").val();       	  			    
     	  			    var hjdeliveryDate=obj3.first().find("input").val();
     	  			    var hjType=obj.eq(2).find("input").val();   	  			    
     	  			    var hjorderNumber=obj.eq(3).find("input").val();   
     	  			    var hjorderFactory=obj.eq(4).find("input").val();   
     	  			    var hjorderPrice=obj.eq(5).find("input").val();       	  			  
     	  			    var hjorderRemark=obj.eq(6).find("input").val();        	  			    	     	  			   		
     	  			    var newData = {
     	  			    		    hjorderId:row.hjorderId,
     	  			    		    hjProductDate:hjProductDate,     	  			    		    
     	  			    		    hjCustomerName: hjCustomerName,
     	  			    		    hjorderPhone: hjorderPhone,   	  			    		   
     	  			    		    hjdeliveryDate:hjdeliveryDate,
     	  			    		    hjType:hjType,
     	  			    		    hjorderNumber:Number(hjorderNumber),
     	  			    		    hjorderFactory:hjorderFactory,
     	  			    		    hjorderPrice:Number(hjorderPrice),     	  			    		    
     	  			    		    hjorderRemark:hjorderRemark,    	  			    		 
     	  				    };	     	  			
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValid2(newData)){	
                         newData["hjorderTotalPrice"]=parseFloat((newData["hjorderPrice"]*newData["hjorderNumber"]).toFixed(2));					  
     	  				//给后台发送ajax请求，修改数据					
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/BusinessOrder/modifyHanjiOrder",//修改焊剂记录  向后台发送一条焊剂记录 后台返回的result为null
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
     		  "click #TableCancel2":function(e,value,row,index){
			     if(row.hjorderState=="未送达"){
			   	  $('#myModal').modal('show');			  
     			  hjorderid=row.hjorderId;
     			  $("#clickcancel").click(function(){
     				 $('#myModal').modal('hide');
     				 	$.ajax({
         	                type:"GET",
         	                url:"/plantSCM/BusinessOrder/cancelHanjiOrder?id="+hjorderid,//取消焊剂订单  向后台发送焊剂ID,后台向前端发送result为null         	               
         	                dataType:"json",
         	                success:function(data){
         	                	if(data.code==0){
         	                		row.hjorderState="已取消";
         	                		$("#tb_hj").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: row,
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
         	            
         	                	}
         	                	else{
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
                   }); 
			    	 
			      }
			      else{
			    	  toastr.info('只能取消未送达的订单');
			
				  }
           			    
    		   } ,
 			  "click #Tablequxiao2":function(e,value,row,index){	    		
 				  $("#tb_hj").bootstrapTable('updateRow', {
  				        index: index,
  				        row: row,
  				    });
       			    
     		   }  
     	    }
          //验证输入是否合法
            function isValid2(newData){   
			//console.log(newData["hjdeliveryDate"]);
			
		
			 if(newData["hjProductDate"]==""){
				     toastr.info('请输入下单日期');
					 return false;
				} 
				if(!xiadandate(newData["hjdeliveryDate"],newData["hjProductDate"])){
				     toastr.info('应送达日期不应早于下单日期');
					 return false;
				} 
				
				if(isNull(newData["hjCustomerName"])){
				     toastr.info('请输入收货人');
					 return false;
				} 
				
				if(newData["hjdeliveryDate"]==""){
				     toastr.info('请输入送达日期');
					 return false;
				} 
				if(isNull(newData["hjType"])){
				     toastr.info('请输入种类');
					 return false;
				} 
				if(!isInteger(newData["hjorderNumber"])){
				     toastr.info('数量请输入正整数');
					 return false;
				} 
				if(isNull(newData["hjorderFactory"])){
				     toastr.info('请输入厂家');
					 return false;
				} 
				if(!isTwoFloat(newData["hjorderPrice"])){
				     toastr.info('价格为不超过两位小数的正数');
					 return false;
				} 
    		 
    		   return true;
			
		
            }
			 //验证日期合法性
		 function check(date){
            return (new Date(date).getDate()==date.substring(date.length-2));
         }
		 //判断日期的大小
		 function xiadandate(date1,date2){			
			 var oDate1 = new Date(date1);
             var oDate2 = new Date(date2);
             if(oDate1.getTime() >= oDate2.getTime()){
             return true;
             } else {
             return false;
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
							<ul class="nav navbar-nav" id="shangwunav">
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
            <li  style="background-color:#F0FFFF;">
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
                                                           收货人</div>
               <div style="float:left;">
               
			   <input id="receiver" type='text'  data-provide="typeahead" autocomplete="off" placeholder="请填写收货人" />  
               </div>                                            
               <div style="white-space:pre;float:left;">           下单日期</div>
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
                  <div style="white-space:pre;float:left;">     订单状态</div>
                 <div style="float:left;">
                       <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                                <option value="1">全部</option>                                                                                 
                                <option value="2">已送达</option>   
                                <option value="3">未送达</option> 
                                <option value="4">部分送达</option>                                               
                                <option value="5">工厂送货</option> 
                                <option value="6">已取消</option>                                                                  
                              </select>
                 </div>                                                      
               </div>
               <br/>
               <div class="row">              
                <div style="white-space:pre;float:left;">形状</div>
                 <div style="float:left;">
                       <select id="select2" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                                <option value="1">全部</option>                                                                                 
                                <option value="2">直</option>   
                                <option value="3">弯</option>                                                           
                              </select>
                 </div> 
                  <div style="white-space:pre;float:left;">       产品型号</div>
                 <div style="float:left;">
                        <select id="select3" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div>     
                  
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="search()">搜索</button>                       
                         &nbsp;
                        <button id="addbutton"  type="button" class="btn btn-primary"  onclick="clickaddorder()">添加订单</button>
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
                <br/>
                
                
                
                
                
                 <div class="row">
               <div style="float:left;"> 
                                                           收货人</div>
               <div style="float:left;">
               <input id="receiver2" type='text' placeholder="请填写收货人" />  
               </div>                                            
               <div style="white-space:pre;float:left;">           下单日期</div>
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
                  <div style="white-space:pre;float:left;">     订单状态</div>
                 <div style="float:left;">
                       <select id="select4" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                                <option value="1">全部</option>                                                                                 
                                <option value="2">已送达</option>   
                                <option value="3">未送达</option> 
                                <option value="4">部分送达</option>                                               
                                <option value="5">工厂送货</option> 
                                <option value="6">已取消</option>                                                  
                              </select>
                 </div>   
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton2"  type="button" class="btn btn-primary"  onclick="searchhj()">搜索</button>                       
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
               <div class="row">
               <!-- 模态框（Modal） -->
                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                 <div class="modal-dialog">
		              <div class="modal-content">
			           <div class="modal-header">
				           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					        &times;
				            </button>
				            <h4 class="modal-title" id="myModalLabel">提示</h4>
			          </div>
			          <div class="modal-body"> 确定要取消订单吗</div>
			         <div class="modal-footer">
				         
				         <button type="button" class="btn btn-primary"  id="clickcancel">确定取消</button>
				         <button type="button" class="btn btn-default" data-dismiss="modal">放弃</button>
			        </div>
		           </div><!-- /.modal-content -->
	             </div><!-- /.modal -->
                 </div>
               </div>

      </div>
      </div>
   </div>
</body>
</html>