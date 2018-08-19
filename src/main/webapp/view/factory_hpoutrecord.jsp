<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        	 //1.初始化Table
             initTable();            
             //获取并显示产品型号            
             getModel();  
            //点击编辑按钮触发以下事件，on修复了翻页后按钮无效的问题
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
    			   $(this).parent().parent().children(".fahuo").each(function(){ 
    				   if($(this).text()=="入库"){
    					   $(this).html("<select><option value='0' selected>入库</option><option value='1'>发货</option></select>");   
    				   }else{
    					   $(this).html("<select><option value='0'>入库</option><option value='1' selected>发货</option></select>");
    				   }   				  
    				  
    			   });
				    $(this).parent().parent().children(".model").each(function(){  
    				
						var oldtext=$(this).text();
						$(this).html("<select id='select8'></select>");  
						getModelTable(oldtext);
						
    		       });	
  
    			   $(this).parent().parent().children(".shape").each(function(){
    				   if($(this).text()=="直"){
    					   $(this).html("<select><option value='0' selected>直</option><option value='1'>弯</option></select>");   
    				   }else{
    					   $(this).html("<select><option value='0'  >直</option><option value='1'  selected>弯</option></select>");
    				   }
    				      		         
    		       });
    				  $(this).parent().parent().children(".editable").each(function(){  
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
        //获取产品型号
        function getModel(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/HpOut/getModel",
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		for(var i=0;i<result.length;i++){
                   		 var text=result[i];
                   		 var value=i+2;
                   		 $("#select2").append("<option value='"+value+"'>"+text+"</option>");
                   	     }
                   	     $('#select2').selectpicker('refresh');
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
                    outShape:$("#select1").find("option:selected").text(),
                    outModel:$("#select2").find("option:selected").text(),
                                   
                };
          	if(isNull(temp.beginDate)){
          	    toastr.info("请选择开始日期");
            }
			else if(isNull(temp.endDate)){
			    toastr.info("请选择结束日期");
			}
			else{
            	$.ajax({
                    type:"GET",
                    url:"/plantSCM/HpOut/getHpOutRecord",
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
        }
        //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
        function isNull(str){
        	if(!str) return true;
             if ( str == "" ) return true;
             var regu = "^[ ]+$";
             var re = new RegExp(regu);
             return re.test(str);
         }
        
        function initTable(){
        	var temp = {
                    beginDate:$("#datetimepicker1").find("input").val(),
                    endDate: $("#datetimepicker2").find("input").val(),
                    outShape:$("#select1").find("option:selected").text(),
                    outModel:$("#select2").find("option:selected").text(),
                           
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/HpOut/getHpOutRecord",
                data:temp,
                dataType:"json",
                success:function(data){
                	if(data.code==0){
                		result=data.result; 
                		
                	     $('#tb_departments').bootstrapTable({ 
                	    	 undefinedText:"",
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
                             maintainSelected : true,
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                               {checkbox: true},
                             {
                                 field: 'outDate',
                                 title: '出厂日期',
                                 class: 'timeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'outShape',
                                 title: '形状',
                                 class: 'shape',
                                 sortable : true
                             }, {
                                 field: 'outModel',
                                 title: '型号',
                                 class: 'model',
                                 sortable : true,
                                
                             }, {
                                 field: 'outSpec',
                                 title: '规格',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'outWeight',
                                 title: '重量',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'outFlow',
                                 title: '出厂流向',
                                 class: 'fahuo',
                                 sortable : true,
                                 formatter: function (value, row, index) {
                                	 if(value==false){
                                		 return "发货";
                                	 }
                                	 return "入库";
                                     }
                             }, {
                                 field: 'customerName',
                                 title: '收货人',
                                 class: 'editable  anoth',
                                 sortable : true
                             }, {
                                 field: 'customerPhone',
                                 title: '收货人电话',
                                 class: 'editable anoth',
                                 sortable : true
                             }, {
                                 field: 'price',
                                 title: '单价',
                                 class: 'editable anoth',
                                 sortable : true
                             }, {
                                 field: 'totalPrice',
                                 title: '总价',
                                 //class: 'editable anoth',
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
			     $("body").one( 'click','#tb_departments tr .save',function () {
	            	var obj =$(this).parent().parent().children(".editable");
	  			    var obj2 = $(this).parent().parent().children(".timeeditable");
	  			    var obj3=$(this).parent().parent().children(".shape");
	  			    var obj4=$(this).parent().parent().children(".fahuo");
					var obj5=$(this).parent().parent().children(".model");
	  			    var outDate = obj2.first().find("input").val();
	  			    var outShape = obj3.first().find("option:selected").text();
	  				var outModel =obj5.first().find("option:selected").text();    
	  				var outSpec = obj.eq(0).find("input").val();
	  				var outWeight=obj.eq(1).find("input").val();
	  				var outFlow=obj4.first().find("option:selected").text();
	  				
	  				if(outFlow=="发货"){
	  					outFlow=false;
	  				}else{
	  					outFlow=true;
	  				}	  					  				
	  			    var newData = {
	  			    		    id:row.id,
	  			    		    outDate: outDate,
	  			    		    outShape:outShape,
	  			    		    outModel:outModel,
	  			    		    outSpec:outSpec,
	  			    		    outWeight:Number(outWeight),
	  			    		    outFlow:outFlow	,			    		
	  				    };	
	  			  
	  			    if(outFlow==false){	  			    	
	  			    	var customerName=obj.eq(2).find("input").val();		  			    	
	  			    	var customerPhone=obj.eq(3).find("input").val();	  			    	
	  			    	var price=obj.eq(4).find("input").val();	  			    	
	  			        price=Number(price);	  			    	 			    		  			    	
	  			    	newData["customerName"]=customerName;
	  			    	if(customerPhone!="" && customerPhone!="-"){
	  			    		newData["customerPhone"]=customerPhone;
	  			    	}	  			    	
	  			    	newData["price"]=price;
	  			    	
	  			    }
	  			 
	  			 
	  			  //如果输入合法则发送请求到后台修改数据
	  			  if(isValid(newData)){	
				  if(outFlow==false){
				  newData["totalPrice"]=parseFloat((newData["price"]*newData["outWeight"]).toFixed(3));
				  }
				     
	  				  
	  				//给后台发送ajax请求，修改数据
	  				  $.ajax({
		                      type:"POST",
		                      url:"/plantSCM/HpOut/modifyHpOutRecord",
		                      contentType:"application/json;charset=UTF-8",
		                      data:JSON.stringify(newData),
		                      dataType:"json",
		                      success:function(data){  	        	          
		                      if(data.code==0){
							       row.customerName="";
								   row.customerPhone="";
								   row.price="";
								   row.totalPrice="";
							
		                    	  $("#tb_departments").bootstrapTable('updateRow', {
		      				        index: index,
		      				        row: newData,
		      				    });
		                    	  
		                    	  // toastr.success(data.msg);
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
		    if(newData["outDate"]==""){
			    toastr.info("出厂日期不为空");
			   return false;
			}
			if(!isSpecValid(newData["outSpec"])){
				toastr.info('焊片规格请填写为1*1*1的格式');
			   return false;
			}
			if(!isThreeFloat(newData["outWeight"])){
			    toastr.info("重量为不超过三位小数的正数");
			   return false;
			}
			if(!isNotEmptyAndExit(newData["customerName"])){
			    toastr.info("收货人不为空");
			   return false;
			}
			if(!isTwoFloat(newData["price"])){
			    toastr.info("单价为不超过两位小数的正数");
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
        //验证某一个数字是否是不超过三位的小数
        function isThreeFloat(data){
        	if (typeof(data) == "undefined"){
        		return true;
        	}
        	
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
		//验证某一个数字是否是不超过两位的小数
        function isTwoFloat(data){
        	if (typeof(data) == "undefined"){
        		return true;
        	}
        	
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
        function isNotEmptyAndExit(data){
        	if (typeof(data) != "undefined" && data==""){
        		return false;
        	}       	
        	return true;       	
        }
        function unique(arr){
            var result = [];
            for(var i=0;i<arr.length;i++){
               if(result.indexOf(arr[i])==-1 && arr[i]!=null){
                   result.push(arr[i])
               }
            }
            return result;
       }
        function printrecord(){
        	var printdata=$('#tb_departments').bootstrapTable('getAllSelections');
        	
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
        		namearray=unique(namearray);        	
        		for(var j=0;j<namearray.length;j++){
        			namestr=namestr+namearray[j];
        		}
        		sumprice=sumprice.toFixed(3);
        		var chsumprice=convertCurrency(sumprice);
        		$("#receiver").html(namestr);        	
        		$("#todydate").html(getEndDate());
        		$("#sum").html(sumprice);
        		$("#chinesestr").html(chsumprice);
        	 var showme = document.getElementById("printpaper");
        	  showme.style.display="block";
        	
        	 $('#printtable').bootstrapTable({                           
        		 undefinedText:"",
                 columns: [                    	
                 	 {
                    title: '编号',
                    formatter: function (value, row, index) {
                    return index+1;
                     }
                   },
                  
                 {
                     field: 'outDate',
                     title: '出厂日期',                                        
                    
                 }, {
                     field: 'outShape',
                     title: '形状', 
                 }, {
                     field: 'outModel',
                     title: '产品型号',
                    
                 }, {
                     field: 'outSpec',
                     title: '规格',
                 }, {
                     field: 'outWeight',
                     title: '重量',
                 }, {
                     field: 'price',
                     title: '单价',
                 }, {
                     field: 'totalPrice',
                     title: '总价',
                 }],
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
        function convertCurrency(money) {
        	  //汉字的数字
        	  var cnNums = new Array('零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖');
        	  //基本单位
        	  var cnIntRadice = new Array('', '拾', '佰', '仟');
        	  //对应整数部分扩展单位
        	  var cnIntUnits = new Array('', '万', '亿', '兆');
        	  //对应小数部分单位
        	  var cnDecUnits = new Array('角', '分', '毫', '厘');
        	  //整数金额时后面跟的字符
        	  var cnInteger = '整';
        	  //整型完以后的单位
        	  var cnIntLast = '元';
        	  //最大处理的数字
        	  var maxNum = 999999999999999.9999;
        	  //金额整数部分
        	  var integerNum;
        	  //金额小数部分
        	  var decimalNum;
        	  //输出的中文金额字符串
        	  var chineseStr = '';
        	  //分离金额后用的数组，预定义
        	  var parts;
        	  if (money == '') { return ''; }
        	  money = parseFloat(money);
        	  if (money >= maxNum) {
        	    //超出最大处理数字
        	    return '';
        	  }
        	  if (money == 0) {
        	    chineseStr = cnNums[0] + cnIntLast + cnInteger;
        	    return chineseStr;
        	  }
        	  //转换为字符串
        	  money = money.toString();
        	  if (money.indexOf('.') == -1) {
        	    integerNum = money;
        	    decimalNum = '';
        	  } else {
        	    parts = money.split('.');
        	    integerNum = parts[0];
        	    decimalNum = parts[1].substr(0, 4);
        	  }
        	  //获取整型部分转换
        	  if (parseInt(integerNum, 10) > 0) {
        	    var zeroCount = 0;
        	    var IntLen = integerNum.length;
        	    for (var i = 0; i < IntLen; i++) {
        	      var n = integerNum.substr(i, 1);
        	      var p = IntLen - i - 1;
        	      var q = p / 4;
        	      var m = p % 4;
        	      if (n == '0') {
        	        zeroCount++;
        	      } else {
        	        if (zeroCount > 0) {
        	          chineseStr += cnNums[0];
        	        }
        	        //归零
        	        zeroCount = 0;
        	        chineseStr += cnNums[parseInt(n)] + cnIntRadice[m];
        	      }
        	      if (m == 0 && zeroCount < 4) {
        	        chineseStr += cnIntUnits[q];
        	      }
        	    }
        	    chineseStr += cnIntLast;
        	  }
        	  //小数部分
        	  if (decimalNum != '') {
        	    var decLen = decimalNum.length;
        	    for (var i = 0; i < decLen; i++) {
        	      var n = decimalNum.substr(i, 1);
        	      if (n != '0') {
        	        chineseStr += cnNums[Number(n)] + cnDecUnits[i];
        	      }
        	    }
        	  }
        	  if (chineseStr == '') {
        	    chineseStr += cnNums[0] + cnIntLast + cnInteger;
        	  } else if (decimalNum == '') {
        	    chineseStr += cnInteger;
        	  }
        	  return chineseStr;
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
       
        //点击新建出厂登记
        function clickaddhpout(){
        	window.location.href = path+"factory_newhpout.jsp";
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
            <li style="background-color:#F0FFFF;">
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
                                                     
               </div>
               <br/>
               <div class="row">
                <div style="white-space:pre;float:left;">  形状</div>
                 <div style="float:left;">
                       <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">  
                                <option value="1">全部</option>                                                                                 
                                <option value="2">直</option>   
                                <option value="3">弯</option>                                                           
                              </select>
                 </div> 
                  <div style="white-space:pre;float:left;">  产品型号</div>
                 <div style="float:left;">
                        <select id="select2" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div>     
                 
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="search()">搜索</button>
                         &nbsp;
                        <button id="printbutton"  type="button" class="btn btn-primary"  onclick="printrecord()">打印</button>
                         &nbsp;
                        <button id="addbutton"  type="button" class="btn btn-primary"  onclick="clickaddhpout()">新建出厂登记</button>
                 </div>           
               </div>
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_departments"></table>
                   </div>
               </div>
               
                
                
               <!--startprint-->
               <div  id="printpaper"  style="display:none;">
                <div class="panel-body" style="padding-bottom:0px;">
                <div class="row">
                <span>收货单位:</span><span  id="receiver"></span>&nbsp;&nbsp;
                <span>日期:</span><span  id="todydate"></span>             
                </div>
                <div class="row">                        
                       <table id="printtable"></table>                                      
               </div>  
               <br/>
               <br/>
               <br/>
                <div class="row">
                 <span>合计:</span><span  id="sum"></span>
                </div>
                 <br/>
                <div class="row">
                 <span>大写:</span><span  id="chinesestr"></span>
                </div>
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