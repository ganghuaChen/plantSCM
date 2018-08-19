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
        	 $('#select11').selectpicker({
        	        noneSelectedText: "请选择",
        	    }); 
        	 $('#select22').selectpicker({
     	        noneSelectedText: "请选择",
     	    }); 
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
              //getModel();
        	 //获取并显示产品型号            
             getname1();
             getModel();
             getname2();
          
                                     
            
        }); 
        //获取产品型号
        function getModel(){
      	$.ajax({
              type:"GET",
              url:"/plantSCM/WarehouseOut/getModel",//获取产品型号  没有传入参数  返回数据中的result为产品型号数组
              success:function(data){
              	//console.log(data.result);
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
        function getname2(){
          	$.ajax({
                  type:"GET",
                  url:"/plantSCM/WarehouseOut/getCustomer",//获取产品型号  没有传入参数  返回数据中的result为产品型号数组
                  success:function(data){
                  	//console.log(data.result);
                  	if(data.code==0){
                  		result=data.result;
                  		for(var i=0;i<result.length;i++){
                     		 var text=result[i];
                     		 var value=i+2;
                     		 $("#select22").append("<option value='"+value+"'>"+text+"</option>");
                     	     }
                     	     $('#select22').selectpicker('refresh');
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
        
        function getname1(){
      	$.ajax({
              type:"GET",
              url:"/plantSCM/WarehouseOut/getCustomer",//
              success:function(data){             	
              	if(data.code==0){
              		result=data.result;
              		for(var i=0;i<result.length;i++){
                 		 var text=result[i];
                 		 var value=i+2;
                 		 $("#select11").append("<option value='"+value+"'>"+text+"</option>");
                 	     }
                 	     $('#select11').selectpicker('refresh');
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
        
              
     
      //点击搜索按钮搜索焊片
        function search(){       	
        	var temp = {
        			hpCustomerName:$("#select11").find("option:selected").text(),
                    startTime:$("#datetimepicker1").find("input").val(),
                    endTime: $("#datetimepicker2").find("input").val(),
                   
                    outShape:$("#select2").find("option:selected").text(),
                    outModel:$("#select3").find("option:selected").text(),             
                };
        	
        	if(temp.startTime==""){
        		toastr.info("请选择开始时间");
        	}else if(temp.endTime==""){
        		toastr.info("请选择结束时间");
        	}else{
        		$.ajax({
                    type:"GET",
                    url:"/plantSCM/WarehouseOut/getHpOutRecord",//获取焊片订单记录   传入参数为收货人、开始日期、结束日期、产品形状、产品型号     返回数据中的result为焊片订单记录
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
    			  hjCustomerName:$("#select22").find("option:selected").text(),
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
                url:"/plantSCM/WarehouseOut/getHjOutRecord",//获取焊剂订单记录     传入参数为收货人、开始日期、结束日期     返回数据中的result为焊剂订单记录
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
        			hpCustomerName:$("#select11").find("option:selected").text(),
                    startTime:$("#datetimepicker1").find("input").val(),
                    endTime: $("#datetimepicker2").find("input").val(),
          
                    outShape:$("#select2").find("option:selected").text(),
                    outModel:$("#select3").find("option:selected").text(),
                    
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/WarehouseOut/getHpOutRecord",//获取焊片订单记录   传入参数为收货人、开始日期、结束日期、订单状态、产品形状、产品型号     返回数据中的result为焊片订单记录
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
                            	 {checkbox: true},
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                              
                               {
                                   field: 'hpCustomerName',
                                   title: '收货人',
                                   class: 'editable11',
                                   sortable : true
                               }, {
                                   field: 'hporderShape',
                                   title: '形状',
                                   class: 'shape11',
                                   sortable : true,
                                  
                               }, {
                                   field: 'hporderModel',
                                   title: '型号',
                                   class: 'editable11',
                                   sortable : true
                               }, 
                               {
                                   field: 'hporderSpec',
                                   title: '规格',
                                   class: 'editable11',
                                   sortable : true
                               },
                               {
                                   field: 'hporderPrice',
                                   title: '单价',
                                   class: 'editable11',
                                   sortable : true
                               }, 
                               {
                                   field: 'hporderNumber',
                                   title: '应送数量',
                                   class: 'editable11',
                                   sortable : true
                               }, 
                               {
                                   field: 'hpsongchuNumber',
                                   title: '送出数量',
                                   class: 'editable',
                                   sortable : true
                               }, 
                               {
                                   field: 'hpweisongNumber',
                                   title: '欠送数量',
                                   class: 'editable11',
                                   sortable : true
                               }, 
                               {
                                   field: 'hporderTotalPrice',
                                   title: '总价',
                                   class: 'editable11',
                                   sortable : true
                               }, 
                               {
                                   field: 'hpdeliveryDate',
                                   title: '应送达日期',
                                   class: 'timeeditable',
                                   sortable : true
                               },   
                               {
                                   field: 'actualDate',
                                   title: '实际送达日期',
                                   class: 'ddtimeeditable',
                                   sortable : true
                               }, 
                            
                             {
                                   field: 'hporderState',
                                   title: '送货状态',
                                   class: 'state',
                                   formatter:bianse,
                                   sortable : true
                               },{
                                   field: 'opeartion',
                                   title: '操作',
                                   events:operateEvents,
                                   formatter:AddFunctionAlty,
                               },
                               {
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
            function bianse(value,row,index){     		 
     		   if(value=="已送达"||value=="工厂送货"){
     		     return "<span style='color:#009100'>"+value+"<span>";
     		    
     		   }
     		   else{     return "<span style='color:#EA0000'>"+value+"<span>";   }
     		   return value;
     		   }
            //为操作列添加按钮
            function AddFunctionAlty(value,row,index){
         	   return ['<button id="TableEditor" type="button" class="btn btn-default btn-xs edit" >出库</button>&nbsp;' ,
         		   '<button id="TableSave" type="button" class="btn btn-default btn-xs save" disabled="disabled">保存</button>',
         		  '<button id="Tablequxiao" type="button" class="btn btn-default btn-xs quxiao">取消</button>',
         		  
         		   ].join("")
            }
            //按钮的事件 编辑以及保存
            window.operateEvents={
     		   "click #TableEditor":function(e,value,row,index){	
     			   if(row.hporderState=="已送达"||row.hporderState=="工厂送货"||row.hporderState=="已取消"){
     				   toastr.info('已送达，已取消或者工厂送货无法修改');
     				      //console.log(this);
     			         //  $(this).parent().css("color", "#f23000");
     				 //    $(this).parent().parent().css('background', 'red');
     			        
     				   
     			   }else{
     				   
     			  $("body").one('click','#tb_hp tr .edit',  function () {
                 	 //console.log("edit");
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
        			   $(this).parent().parent().children(".state").each(function(){
        				   if($(this).text()=="已送达"){
        					   $(this).html("<select><option value='0' selected>已送达</option><option value='2'>未送达</option><option value='3'>部分送达</select>"); 
        					
        				   }else if($(this).text()=="未送达"){
        					   $(this).html("<select><option value='0'  >已送达</option><option value='1'  selected>未送达</option><option value='3'>部分送达</option></select>");
        				   }else if($(this).text()=="部分送达"){
        					   $(this).html("<select><option value='0'  >已送达</option><option value='1' >未送达</option><option value='3' selected>部分送达</option></select>");
        				   }else {
        					   $(this).html("<select><option value='0'  >已送达</option><option value='1'>未送达</option><option value='3'>部分送达</option></select>");
        				   }
        				      		         
        		       });  
        			
        			   
        				  $(this).parent().parent().children(".editable").each(function(){  
        				   var k=this.clientWidth;    				 
        		           var value = $(this).text();    	
        		           
        		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
        		       });
                 });  
     			   }
     		   },
     		   "click #TableSave":function(e,value,row,index){
     			   //console.log(this);
     			//  if(row.hporderState=="未送达"){
   			     //   $(this).parent().parent().css('background', 'red');}
     			  
     			     $("body").one('click','#tb_hp tr .save',  function () {    
     			    	// console.log("save")
     			    	 
     			    	
     	            	var obj =$(this).parent().parent().children(".editable");
     	            	var obj1=$(this).parent().parent().children(".shape");
     	  			    var obj2 = $(this).parent().parent().children(".xdtimeeditable");
     	  			    var obj3=$(this).parent().parent().children(".ddtimeeditable");  
     	  			    var obj4=$(this).parent().parent().children(".state");
     	  			
     	  			// var hpCustomerName=obj.eq(0).find("input").val();    	
     	  			   var hpCustomerName=row.hpCustomerName;
    	  			//  var hporderShape=obj1.first().find("option:selected").text();   
    	  			   var hporderShape=row.hporderShape;
    	  			 //   var hporderModel=obj.eq(1).find("input").val();
    	  			      var hporderModel=row.hporderModel;
    	  			// var hporderSpec=obj.eq(2).find("input").val();
    	  			     var hporderSpec=row.hporderSpec;
    	  			// var hporderPrice=obj.eq(3).find("input").val();
    	  			    var hporderPrice=row.hporderPrice;
    	  		//	 var hporderNumber=obj.eq(4).find("input").val(); 
    	  		       var hporderNumber=row.hporderNumber;
    	  			var hpsongchuNumber=obj.eq(0).find("input").val();
    	  		//	 var hpweisongNumber=obj.eq(6).find("input").val();
    	  		//console.log(hporderNumber);
    	  		     var newData11={ hporderNumber:parseInt(hporderNumber),
	  	     	  			    hpsongchuNumber:parseInt(hpsongchuNumber),
    	  		    		 
    	  		     };
    	  		     //console.log(newData11);
    	  		      var hpweisongNumber= weisong(newData11);
    	  		//	 var hporderTotalPrice=obj.eq(7).find("input").val(); 
    	  		       var hporderTotalPrice=row.hporderTotalPrice;
    	  			 var  hpdeliveryDate=row.hpdeliveryDate;
    	  			 var hporderState=obj4.first().find("option:selected").text();   
    	  			    var actualDate=obj3.first().find("input").val();   
    	  			    var hporderRemark=obj.eq(1).find("input").val();
    	  			 
    	  			   
     	  			     var  newData = {
     	  			    	 hporderId:row.hporderId,
	  			    		    
	  			    		    hpCustomerName: hpCustomerName,
	  			    		    hporderShape: hporderShape,
	  			    		    hporderModel:hporderModel,
	  			    		    
	  			    		    hporderSpec:hporderSpec,
	  			    		    hporderNumber:hporderNumber,
	  			    		 
	  	     	  			    hpsongchuNumber:hpsongchuNumber,
	  	     	  			    hpweisongNumber:hpweisongNumber,
	  			    		    hporderPrice:hporderPrice,
	  			    		    hporderTotalPrice:hporderTotalPrice,
	  			    		  hpdeliveryDate:hpdeliveryDate,
	  			    		    actualDate:actualDate,
	  			    		    hporderState:hporderState,
	  			    		  hporderRemark:hporderRemark,
	  			    		    
	  			    		
	  			    		 	  	  			    		 
     	  				    };	
     	  			 
     	  				
     	  			  //console.log(newData);
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValid(newData)){	     	  				 
     	  				//给后台发送ajax请求，修改数据
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/WarehouseOut/modifyHpOut",//修改焊片记录 向后台传一条焊片记录  后台返回是否成功，result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	 
     		                    	 //console.log(newData);
     		                    
     		                      if(data.code==0){
     		                    	  $("#tb_hp").bootstrapTable('updateRow', {
     		      				        index: index,
     		      				        row: newData,
     		      				    });    		                    	  
     		                    	 //var msg=data.msg;
   		                   		   //toastr.success(msg);
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
     	  			  else{
     	  				toastr.info('请正确输入');
     	  			  }
     	             });
     			   
     			
     			     
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
    		    if(!isNaN(newData["hpsongchuNumber"])  &&  isdayu(newData)&& newData["hpsongchuNumber"]>=0 && isInteger1(newData["hpsongchuNumber"])  &&issongda1(newData)
    		    	){		    	
    		    	return true;
    		    	
    		    }
				
    		   return false;
            }
			
			function issongda1(newData){
			       if( newData["hpsongchuNumber"]==newData["hporderNumber"]&&newData["hporderState"]!="已送达")
				          {
							  toastr.info("送出数量等于应送数量，送货状态应为已送达");
						       return false;
							    
                         }  else if(newData["hpsongchuNumber"]<newData["hporderNumber"] &&newData["hporderState"]=="已送达")
                                        {
											console.log(1);
											toastr.info("送出数量小于应送数量，送货状态不能为已送达");
                                              return false;
                                         }	
                            	else if(newData["hpsongchuNumber"]==0 &&newData["hporderState"]=="部分送达")
                                        {
											toastr.info("送出数量等于0，送货状态不能为部分送达或已送达");
                                              return false;
                                         }
                                	else if(newData["hpsongchuNumber"]!=0 &&newData["hporderState"]=="未送达")
                                        {
											toastr.info("送出数量不等于0，送货状态不能为未送达");
                                              return false;
                                         }									 
			               
			                 return true;
			}
             function isInteger1(value){
	       var val = /^\+?[1-9][0-9]*$/;
		   if( val.test(value)||value==0){ return true;}
		   else {return false;  }
	  
	  }
			function isdayu(newData){
			       if(newData["hpsongchuNumber"]>newData["hporderNumber"])
				   {  return false;  }
				   else  {  return true;}
				
			}
			
         function weisong(newData11){
            	newData11["hpweisongNumber"]=newData11["hporderNumber"]-newData11["hpsongchuNumber"];
            	return newData11["hpweisongNumber"];
            }
            //验证输入是否为空或者全部为空字符串   
            function isNull(str){
                 if ( str == "" ) return true;
                 var regu = "^[ ]+$";
                 var re = new RegExp(regu);
                 return re.test(str);
             }
            //验证某一个数字是否是不超过两位的小数
            function isTwoFloat(data){            	
            	if(isNaN(data)){
            		return false;
            	}
            	else{
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
        			hjCustomerName:$("#select22").find("option:selected").text(),
                    startTime:$("#datetimepicker3").find("input").val(),
                    endTime: $("#datetimepicker4").find("input").val(),
                                  
                };
        	
        	$.ajax({
                type:"GET",
                url:"/plantSCM/WarehouseOut/getHjOutRecord",//获取焊剂订单记录     传入参数为收货人、开始日期、结束日期、订单状态     返回数据中的result为焊剂订单记录
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
                            	  {checkbox: true},
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                              
                               {
                                   field: 'hjCustomerName',
                                   title: '收货人',
                                   class: 'editable22',
                                   sortable : true
                               },    {
                                   field: 'hjorderFactory',
                                   title: '厂家',
                                   class: 'editable22',
                                   sortable : true
                               }, {
                                   field: 'hjType',
                                   title: '种类',
                                   class: 'editable22',
                                   sortable : true,
                                  
                               }, 
                               {
                                   field: 'hjorderPrice',
                                   title: '单价',
                                   class: 'editable22',
                                   sortable : true
                               }, {
                                   field: 'hjorderNumber',
                                   title: '应送数量',
                                   class: 'editable22',
                                   sortable : true
                               },
                               {
                                   field: 'hjsongchuNumber',
                                   title: '已送数量',
                                   class: 'editable2',
                                   sortable : true
                               },
                               {
                                   field: 'hjweisongNumber',
                                   title: '欠送数量',
                                   class: 'editable22',
                                   sortable : true
                               },
                               {
                                   field: 'hjorderTotalPrice',
                                   title: '总价',
                                   class: 'editable22',
                                   sortable : true
                               },
                               {
                                   field: 'hjdeliveryDate',
                                   title: '应送达日期',
                                   class: 'timeeditable2',
                                   sortable : true
                               },
                               {
                                   field: 'actualDate',
                                   title: '实际送达日期',
                                   class: 'ddtimeeditable2',
                                   sortable : true
                               },
                              {
                                   field: 'hjorderState',
                                   title: '送货状态',  
                                   class:'state1',
                                   formatter:bianse1,
                                   sortable : true
                               },{
                                   field: 'opeartion',
                                   title: '操作',
                                   events:operateEvents2,
                                   formatter:AddFunctionAlty2,
                               },  {
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
            function bianse1(value,row,index){
      		   //console.log(row);
      		   if(value=="已送达"){
      		     return "<span style='color:#009100'>"+value+"<span>";
      		    
      		   }
      		   else{     return "<span style='color:#EA0000'>"+value+"<span>";   }
      		   return value;
      		   }
            //为操作列添加按钮
            function AddFunctionAlty2(value,row,index){
         	   return ['<button id="TableEditor2" type="button" class="btn btn-default btn-xs edit2">出库</button>&nbsp;' ,
         		   '<button id="TableSave2" type="button" class="btn btn-default btn-xs save2" disabled="disabled">保存</button>&nbsp;',
         		  '<button id="Tablequxiao2" type="button" class="btn btn-default btn-xs quxiao2">取消</button>',
         		  
         		   ].join("")
            }
            //按钮的事件 编辑以及保存
            window.operateEvents2={
     		   "click #TableEditor2":function(e,value,row,index){	
                   if(row.hjorderState=="已送达"||row.hjorderState=="已取消"){
     				   toastr.info('已送达或者已取消无法修改');
     				   
     			   }
     			   else{
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
        			   $(this).parent().parent().children(".shape2").each(function(){
        				   if($(this).text()=="直"){
        					   $(this).html("<select><option value='0' selected>直</option><option value='1'>弯</option></select>");   
        				   }else{
        					   $(this).html("<select><option value='0'  >直</option><option value='1'  selected>弯</option></select>");
        				   }
        				      		         
        		       });   
        			   $(this).parent().parent().children(".state1").each(function(){
          				   if($(this).text()=="已送达"){
          					   $(this).html("<select><option value='0' selected>已送达</option><option value='2'>未送达</option><option value='3'>部分送达</option></select>");   
          				   }else if($(this).text()=="未送达"){
          					   $(this).html("<select><option value='0'  >已送达</option><option value='1'  selected>未送达</option><option value='3'>部分送达</option></select>");
          				   }else{
          					   $(this).html("<select><option value='0'  >已送达</option><option value='1' >未送达</option><option value='3' selected>部分送达</option></select>");
          				   }
          				      		         
          		       });  
        				  $(this).parent().parent().children(".editable2").each(function(){  
        				   var k=this.clientWidth;    				 
        		           var value = $(this).text();    	
        		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");   		         
        		       });
                 });  
     			  }
     		   },
     		   "click #TableSave2":function(e,value,row,index){
     			     $("body").one('click','#tb_hj tr .save2',  function () {
     	            	var obj =$(this).parent().parent().children(".editable2");
     	  			    var obj2 = $(this).parent().parent().children(".xdtimeeditable2");
     	  			    var obj3=$(this).parent().parent().children(".ddtimeeditable2");  
     	  			    var obj4=$(this).parent().parent().children(".state1");    	  			   
     	  			      var hjCustomerName=row.hjCustomerName;
     	  			   // var hjType=obj.eq(1).find("input").val();   	  			    
     	  			      var hjType=row.hjType;
     	  			   // var hjorderFactory=obj.eq(2).find("input").val();   
     	  			      var hjorderFactory=row.hjorderFactory;
     	  			  //  var hjorderPrice=obj.eq(3).find("input").val();   
     	  			       var hjorderPrice=row.hjorderPrice;
     	  			   // var hjorderNumber=obj.eq(4).find("input").val(); 
     	  			      var hjorderNumber=row.hjorderNumber;
     	  			    var hjsongchuNumber=obj.eq(0).find("input").val();
     	  			  //  var hjweisongNumber=obj.eq(5).find("input").val();
     	  			    var newData22={ hjorderNumber:parseInt(hjorderNumber),
	  	     	  			    hjsongchuNumber:parseInt(hjsongchuNumber),
     	  			    		
     	  			    };
     	  			       var hjweisongNumber=weisong1(newData22);
     	  			  //  var hjorderTotalPrice=obj.eq(6).find("input").val();  
     	  			      var hjorderTotalPrice=row.hjorderTotalPrice;
     	  			      var hjdeliveryDate=row.hjdeliveryDate;
     	  			   var actualDate=obj3.first().find("input").val();
     	  			   var hjorderState=obj4.first().find("option:selected").text();   
     	  			    var hjorderRemark=obj.eq(1).find("input").val();        	  			    	     	  			   		
     	  			    var newData = {
     	  			    		hjorderId:row.hjorderId,
     	  			    		 hjCustomerName:hjCustomerName,
     	     	  			     hjType:  hjType,
     	     	  			     hjorderFactory: hjorderFactory,
     	     	  			     hjorderPrice :hjorderPrice,
     	     	  			     hjorderNumber:hjorderNumber,
     	     	  			     hjsongchuNumber:hjsongchuNumber,
     	     	  			     hjweisongNumber:hjweisongNumber,
     	     	  			     hjorderTotalPrice:hjorderTotalPrice,
     	     	  			    hjdeliveryDate:hjdeliveryDate,
     	     	  			    actualDate:actualDate,
     	     	  			    hjorderState:hjorderState,
     	     	  			     hjorderRemark:hjorderRemark,    	  			    		 
     	  				    };	     	  			
     	  			  //如果输入合法则发送请求到后台修改数据
     	  			  if(isValid2(newData)){	     	  				     	  				  
     	  				//给后台发送ajax请求，修改数据
     	  				  $.ajax({
     		                      type:"POST",
     		                      url:"/plantSCM/WarehouseOut/modifyHjOut",//修改焊剂记录  向后台发送一条焊剂记录 后台返回的result为null
     		                      contentType:"application/json;charset=UTF-8",
     		                      data:JSON.stringify(newData),
     		                      dataType:"json",
     		                      success:function(data){  	 
                                   //console.log(newData);								  
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
     	  				
     	  			  }else{
     	  				  toastr.info("请正确输入");
     	  			  }     	  			
     	             });
     		   },
     		  "click #Tablequxiao2":function(e,value,row,index){	    		
				  $("#tb_hj").bootstrapTable('updateRow', {
				        index: index,
				        row: row,
				    });
    			    
  		       }  		
     	    		        			 
     	    }
          //验证输入是否合法
            function isValid2(newData){           
    		    if(   !isNaN(newData["hjsongchuNumber"]) && isdayu1(newData)  &&newData["hjsongchuNumber"]>=0  && isInteger(newData["hjsongchuNumber"])  && issongda(newData)
    		    	                                                ){		    	
    		    	return true;
    		    	
    		    }
    		   return false;
            }
			
			function issongda(newData){
			       if( newData["hjsongchuNumber"]==newData["hjorderNumber"]&&newData["hjorderState"]!="已送达")
				          {
							  toastr.info("送出数量等于应送数量，送货状态应为已送达");
						       return false;
                         }  else if(newData["hjsongchuNumber"]<newData["hjorderNumber"] &&newData["hjorderState"]=="已送达")
                                        {
											toastr.info("送出数量小于应送数量，送货状态不能为已送达");
                                              return false;
                                         }	
								else if(newData["hjsongchuNumber"]==0 &&newData["hjorderState"]=="部分送达")
                                        {
											toastr.info("送出数量等于0，送货状态不能为部分送达或已送达");
                                              return false;
                                         }	
                                 	else if(newData["hjsongchuNumber"]!=0 &&newData["hjorderState"]=="未送达")
                                        {
											toastr.info("送出数量不等于0，送货状态不能为未送达");
                                              return false;
                                         }										 
			
			                 return true;
			}
			 
			 function isInteger(value){
	       var val = /^\+?[1-9][0-9]*$/;
		   if( val.test(value)||value==0){ return true;}
		   else {return false;  }
	  
	  }
			function isdayu1(newData){
			       if(newData["hjsongchuNumber"]>newData["hjorderNumber"])
				   {  return false;  }
				   else  {  return true;}
				
			}
            function weisong1(newData22){
            	newData22["hjweisongNumber"]=newData22["hjorderNumber"]-newData22["hjsongchuNumber"];
            	return newData22["hjweisongNumber"];
            }
            //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
            function isNullOrUndefined(str){
            	if(!str) return true;
                 if ( str == "" ) return true;
                 var regu = "^[ ]+$";
                 var re = new RegExp(regu);
                 return re.test(str);
             }
            function printrecord(){
            	var printdata1=$('#tb_hp').bootstrapTable('getAllSelections');
            	var printdata2=$('#tb_hj').bootstrapTable('getAllSelections');
            	//console.log(printdata1);
            	//console.log(printdata2);
            	var printdata=[];
            	for(var i=0;i<printdata1.length;i++){
            		printdata1[i].name="焊片";
            		printdata1[i].customerName=printdata1[i].hpCustomerName;
            		printdata1[i].orderPrice=printdata1[i].hporderPrice;
            		printdata1[i].orderNumber=printdata1[i].hporderNumber;
            		printdata1[i].songchuNumber=printdata1[i].hpsongchuNumber;            		
            		printdata1[i].orderTotalPrice=printdata1[i].hporderTotalPrice;            	
            		printdata.push(printdata1[i]);
            	}
            	for(var i=0;i<printdata2.length;i++){
            		printdata2[i].name="焊剂";
            		printdata2[i].customerName=printdata2[i].hjCustomerName;
            	
            		printdata2[i].orderPrice=printdata2[i].hjorderPrice;
            		printdata2[i].orderNumber=printdata2[i].hjorderNumber;
            		printdata2[i].songchuNumber=printdata2[i].hjsongchuNumber;           		
            		printdata2[i].orderTotalPrice=printdata2[i].hjorderTotalPrice;   
            		printdata2[i].hporderModel=printdata2[i].hjorderFactory; 
            		printdata2[i].hporderSpec=printdata2[i].hjType;
            		printdata.push(printdata2[i]);
            	}
            	
            	if(printdata.length<1){
            		toastr.info("请选择至少一条记录");
            	}else{
            		var namestr="";      		
            		var namearray=[];
            		var sumprice=0;
            		for(var i=0;i<printdata.length;i++){
            		    namearray.push(printdata[i].customerName);
            		    sumprice=sumprice+printdata[i].totalPrice;
            		}
            		$("#todydate").html(getEndDate());
            	 var showme = document.getElementById("printpaper");
            	  showme.style.display="block";
            	
            	 $('#printtable').bootstrapTable({                           
                    
                     columns: [                    	
                    	 {
                             title: '编号',
                             formatter: function (value, row, index) {
                             return index+1;
                              }
                            },
                            {   field:'name',
                            	title:'名称',
                            	
                    	   
                            },
                           
                            {
                                field: 'customerName',
                                title: '收货人',
                         
                           
                            }, {
                                field: 'hporderShape',
                                title: '形状'
                             
                               
                            }, {
                                field: 'hporderModel',
                                title: '型号/厂家'
                               
                            }, 
                            {
                                field: 'hporderSpec',
                                title: '规格/种类'
                              
                            },
                            {
                                field: 'orderPrice',
                                title: '单价'
                               
                            }, 
                            {
                                field: 'orderNumber',
                                title: '应送数量'
                               
                            }, 
                            {
                                field: 'songchuNumber',
                                title: '已送数量'
                               
                            }, 
                          
                            {
                                field: 'orderTotalPrice',
                                title: '总价'
                           
                            }, 
                         
                         
                    
                          ],
                     data:printdata
                 });
            	
            	        	
            	bdhtml=window.document.body.innerHTML;
                sprnstr="<!--startprint-->"; //开始打印标识字符串有17个字符            
                eprnstr="<!--endprint-->"; //结束打印标识字符串
                prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17); //从开始打印标识之后的内容
                prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); //截取开始标识和结束标识之间的内容
                window.document.body.innerHTML=prnhtml; //把需要打印的指定内容赋给body.innerHTML           
                window.print(); //调用浏览器的打印功能打印指定区域
                window.location.reload(); // 最后还原页面
            	}
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
            <a href="#systemSetting1" class="nav-header collapsed" data-toggle="collapse" >
            <i class="glyphicon glyphicon-edit"></i>
                                   送货管理                    
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>                               
            </a>
            <ul id="systemSetting1" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li style="background-color:#F0FFFF;"><a href="javascript:void(0)" onclick="clicksonghuomanage()"><i></i>送货管理</a></li>
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
            <li><a href="javascript:void(0)" onclick="clickhpinventory()">焊片库存</a></li>
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
               <div style="float:left;"> 
                                                           收货人</div>
                <div style="float:left;">
                        <select id="select11" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div>                                             
               <div style="white-space:pre;float:left;">       送货日期</div>
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
                          <button id="printbutton"  type="button" class="btn btn-primary"  onclick="printrecord()">打印</button>
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
                        <select id="select22" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div>                                            
               <div style="white-space:pre;float:left;">       送货日期</div>
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
                        <button id="searchbutton2"  type="button" class="btn btn-primary"  onclick="searchhj()">搜索</button>                       
                 </div>                                                    
               </div>
                <br/>
 
               <div class="row">
               <span><span class="glyphicon glyphicon-leaf"></span>焊剂</span>
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
				   
			          </div>
			   
			       
		           </div><!-- /.modal-content -->
	             </div><!-- /.modal -->
                 </div>
               </div>
                <!--startprint-->
                <div  id="printpaper"  style="display:none;">
                <div class="panel-body" style="padding-bottom:0px;">
                 <span>日期:</span><span  id="todydate"></span> 
                <div class="row">                        
                       <table id="printtable"></table>                                      
               </div>  
               <br/>
               <br/>
               <br/> 
               <br/>
                <br/>
                <div class="row">
                <span>制单人:</span>
                </div>
                <br/>
                <div class="row">
                <span>签字:</span>
                </div>
                 </div>  
               </div>
              <!--endprint-->
             

      </div>
      </div>
   </div>
</body>
</html>