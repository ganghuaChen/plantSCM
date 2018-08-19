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
    <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
    <link href="../css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="../js/tabulator.min.js"></script>
    <link  rel="stylesheet" href="../css/toastr.min.css">  
    <script src="../js/toastr.min.js"></script>
     <script src="../js/bootstrap3-typeahead.min.js"></script>
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
        	//toastr.options.closeButton=true;
        	
        	toastr.info("请先填写收货人");
        	 //初始化日期选择器
        	 var picker1 = $('#datetimepicker1').datetimepicker({          
        		 format: 'YYYY-MM-DD',          
        		 locale: moment.locale('zh-cn'), 
        		 defaultDate: getEndDate() 
        		 });      
        	//初始化焊片表
        	 $("#tb_hp").tabulator({        	    
         	    layout:"fitColumns", //fit columns to width of table (optional)
        	    //index:1,
         	    columns:[ //Define Table Columns        	    	
         	        {title:"形状", field:"hporderShape",editor:true,headerSort:false,widthGrow:1,editor:"select",editorParams:{"直":"直","弯":"弯"},},
         	        {title:"型号", field:"hporderModel",headerSort:false,editor:"select",editorParams:getModel(),},
         	        {title:"规格", field:"hporderSpec",editor:true,headerSort:false,widthGrow:1},
         	        {title:"重量", field:"hporderNumber",headerSort:false,editor:true,widthGrow:1},
         	        {title:"单价", field:"hporderPrice", headerSort:false,editor:true,widthGrow:1},
         	       // {title:"总价", field:"hporderTotalPrice",headerSort:false,widthGrow:1},
         	        {title:"执行人", field:"hporderPerformer",headerSort:false,editor:"select",editorParams:{"仓库":"仓库","工厂":"工厂"},widthGrow:1},
         	        {title:"应送达日期", field:"hpdeliveryDate",headerSort:false,editor:true,widthGrow:1},
         	        {title:"备注", field:"hporderRemark",headerSort:false,editor:true,widthGrow:1},
         	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}   
         	       
         	    ], 
         	  
         	});  
 
        	//初始化焊剂表
        	 $("#tb_hj").tabulator({        	    
         	    layout:"fitColumns", //fit columns to width of table (optional)
        	    //index:1,
         	    columns:[ //Define Table Columns        	    	
         	        {title:"种类", field:"hjType",editor:true,headerSort:false,widthGrow:1},     	       
         	        {title:"数量", field:"hjorderNumber",headerSort:false,editor:true,widthGrow:1},
         	        {title:"厂家", field:"hjorderFactory",headerSort:false,editor:true,widthGrow:1},
         	        {title:"单价", field:"hjorderPrice",headerSort:false,editor:true,widthGrow:1},
         	        //{title:"总价", field:"hjorderTotalPrice",headerSort:false,widthGrow:1},         	       
         	        {title:"应送达日期", field:"hjdeliveryDate",headerSort:false,editor:true,widthGrow:1},
         	        {title:"备注", field:"hjorderRemark",headerSort:false,editor:true,widthGrow:1},
         	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}   
         	       
         	    ], 
         	  
         	});  
        	 var tabledata1 = [
          	   {hpdeliveryDate:afterThreeDate()},
          	   {hpdeliveryDate:afterThreeDate()},
          	   {hpdeliveryDate:afterThreeDate()},
          	   {hpdeliveryDate:afterThreeDate()},
          	];
          	//load sample data into the table
          	$("#tb_hp").tabulator("setData", tabledata1);
          	 var tabledata2 = [
            	   {hjdeliveryDate:afterThreeDate()},
            	   {hjdeliveryDate:afterThreeDate()},
            	   {hjdeliveryDate:afterThreeDate()},
            	   {hjdeliveryDate:afterThreeDate()},
            	];
            	//load sample data into the table
            	$("#tb_hj").tabulator("setData", tabledata2);
          //获取自动补齐输入框的值列表       	
        	getReceiver(); 
        	$("#hpadd-row").click(function(){
        		$("#tb_hp").tabulator("addRow", {hpdeliveryDate:afterThreeDate()});
        		});
        	
        	$("#hjadd-row").click(function(){
        		$("#tb_hj").tabulator("addRow", {hjdeliveryDate:afterThreeDate()});
        		});
        	
        	
        	
        }); 
       
      
        //判断焊片第i行是否为空行
        function hpRowIsNull(i){
        	var data = $("#tb_hp").tabulator("getData");
        	if(isNull(data[i].hporderShape) && isNull(data[i].hporderModel) && isNull(data[i].hporderSpec) && isNull(data[i].hporderNumber) &&
        			isNull(data[i].hporderPrice)  && isNull(data[i].hporderPerformer) && isNull(data[i].hporderRemark)){
        		return true;
        	}
        	return false;
        }
        //判断焊剂第i行是否为空行
        function hjRowIsNull(i){
         	var data = $("#tb_hj").tabulator("getData");
         	if(isNull(data[i].hjType) && isNull(data[i].hjorderNumber) && isNull(data[i].hjorderFactory) && isNull(data[i].hjorderPrice) 
         			  && isNull(data[i].hjorderRemark)){
         		return true;
         	}
         	return false;
         }
        //点击提交按钮
    	function clickadd(){
    		var customer=$("#receiver").val();
    		var date =$("#datetimepicker1").find("input").val();
    		if(isNull(customer)){
    			toastr.info("请填写收货人");
    		}else if(isNull(date)){
    			toastr.info("请填写下单日期");
    		}else{
    			add(customer,date);
    		}
    	}
    	//提交
        function add(customer,date){
        	var data = $("#tb_hp").tabulator("getData");
        	var datajson=[];
        	var k=true;
        	
        	  	for(var i=0;i<data.length;i++){
            		
            		if(hpRowIsNull(i)){
            			continue;
            		}      
                   // xiadandate(data[i].hpdeliveryDate,$("#datetimepicker1").find("input").val());					
            		data[i].hporderPrice=Number(data[i].hporderPrice);
            		//data[i].hporderTotalPrice=parseFloat(data[i].hporderTotalPrice);
            		data[i].hporderNumber=Number(data[i].hporderNumber);
            		if(isNull(data[i].hporderShape)){        			       			
            			toastr.info("请填写焊片形状");
            			k=false;
            			break;
            		} 
					else if(isNull(data[i].hporderModel)){        			       			
            			toastr.info("请填写焊片型号");
            			k=false;
            			break;
            		} 
					else if(!isSpecValid(data[i].hporderSpec) ){        			       			
            			toastr.info("焊片规格请填写为1*1*1的格式");
            			k=false;
            			break;
            		} 
					else if(!isInteger(data[i].hporderNumber)){
            			toastr.info("重量请填写正整数");
            			k=false;
            			break;
            			
            		}
            		else if(!isTwoFloat(data[i].hporderPrice)){
            			toastr.info("单价请填写不超过两位小数的正数");
            			k=false;
            			break;
            		}
            		else if(!isDate(data[i].hpdeliveryDate)){
                	    toastr.info("日期请填写为yyyy-mm-dd的格式");
                	    k=false;
                		break;
                	}
					else if(!check(data[i].hpdeliveryDate)){
						toastr.info("请填写有效的日期");
                	    k=false;
                		break;
						
					}
					else if(!xiadandate(data[i].hpdeliveryDate,$("#datetimepicker1").find("input").val())){
						toastr.info("应送达日期不应早于下单日期");
                	    k=false;
                		break;
					}
                    else if(isNull(data[i].hporderPerformer)){                       	

            			toastr.info("请填写焊片执行人");
            			k=false;
            			break;
            		} 					
            		data[i].hpCustomerName=customer;
            		data[i].hporderDate=date;
					data[i].hporderTotalPrice=parseFloat((data[i].hporderPrice*data[i].hporderNumber).toFixed(2));
					
            		if(!isNull($("#phone").val())){
            			data[i].hporderPhone=$("#phone").val();
            		}
            		
            		datajson.push(data[i]);
            	}
     	
        	//如果焊片验证通过
        	if(k==true){
        		
        		var datahj = $("#tb_hj").tabulator("getData");
            	var datajsonhj=[];              	
            	var khj=true;
            	for(var i=0;i<datahj.length;i++){
            		if(hjRowIsNull(i)){
            			continue;
            		}              		
            		datahj[i].hjorderPrice=Number(datahj[i].hjorderPrice);
            		//datahj[i].hjorderTotalPrice=parseFloat(datahj[i].hjorderTotalPrice);
            		datahj[i].hjorderNumber=Number(datahj[i].hjorderNumber);
            		if(isNull(datahj[i].hjType)){        			       			
            			toastr.info("请填写焊剂种类");
            			khj=false;
            			break;
            		} 
					else if(!isInteger(datahj[i].hjorderNumber)){
            			toastr.info("焊剂数量请填写正整数");
            			khj=false;
            			break;
            			
            		}
					else if(isNull(datahj[i].hjorderFactory)){        			       			
            			toastr.info("请填写焊剂厂家");
            			khj=false;
            			break;
            		} 
            		else if(!isTwoFloat(datahj[i].hjorderPrice)){           			
            			toastr.info("焊剂单价请填写不超过两位小数的数字");
            			khj=false;
            			break;
            		}
            		
					else if(!isDate(datahj[i].hjdeliveryDate)){            			
                	    toastr.info("焊剂日期请填写为yyyy-mm-dd的格式");
                	    khj=false;
                		break;
                	} 
					else if(!check(datahj[i].hjdeliveryDate)){
						toastr.info("请填写有效的日期");
                	    khj=false;
                		break;
						
					}
					else if(!xiadandate(datahj[i].hjdeliveryDate,$("#datetimepicker1").find("input").val())){
						toastr.info("应送达日期不应早于下单日期");
                	    khj=false;
                		break;
					}
            		datahj[i].hjCustomerName=customer;
            		datahj[i].hjProductDate=date;
					datahj[i].hjorderTotalPrice=parseFloat((datahj[i].hjorderPrice*datahj[i].hjorderNumber).toFixed(2));
            		if(!isNull($("#phone").val())){
            			datahj[i].hjorderPhone=$("#phone").val();
            		}
            		datajsonhj.push(datahj[i]);
            	}
            	
            	if(khj==true){                            		
            		var hjorders=datajsonhj;
            		var hporders=datajson;
            		if(hjorders.length==0 && hporders.length==0){
            			toastr.info("请至少填写一条记录");
            		}else{
            			//设置按钮不可动
            			 $("#submit").attr("disabled",true);
            			var order={
            					hpOrder:datajson,
                				hjOrder:datajsonhj
                		}						
                		 $.ajax({
                             type:"POST",
                             url:"/plantSCM/BusinessOrder/creatOrder",//添加订单  向后台发送多条焊片焊剂订单记录      后台返回result为null
                             contentType:"application/json;charset=UTF-8",
                             data:JSON.stringify(order),//将 JavaScript 值转换为 JSON 字符串
                             dataType:"json",
                             success:function(data){  
							
                            	 if(data.code==0){
								     $("#tb_hp").tabulator("setData", datajson);
									 $("#tb_hj").tabulator("setData", datajsonhj);
									 var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {	
				                    			window.location.href = path+"business_orderrecord.jsp";
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
                            		// toastr.success(data.msg);
									 //setTimeout(function(){window.location.href = path+"business_orderrecord.jsp";  },1500);
                            	 }else if(data.code==114){                       		
								     //toastr.success(data.msg);
								     var d = dialog({								
				                    		title: '提示',
				                    		content: data.msg,
				                    		okValue: '确定',
				                    		ok: function () {				                    			
				                    			window.location.href = path+"business_orderrecord.jsp"
				                    			return true;
				                    		}
				      
				                    	});
								     d.width(300);
				                     d.show();
									// setTimeout(function(){window.location.href = path+"business_orderrecord.jsp";  },1500);
									 
								 }
								 else{									
								     //toastr.error(data.msg);
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
								     $("#submit").attr("disabled",false);
								 }
								 
                            	          
                             },
                             error:function(){
                            	
                            	 toastr.error('请连接网络');
                            	 $("#submit").attr("disabled",false);
                            	 
                             }
                          });
            			
            			
            		}
            		
            		    		 
            	}      		        		
        	}           
        }
		//判断为正整数
		function isInteger(s){  
	        var re = /^[0-9]*[1-9][0-9]*$/ ;
             return re.test(s);
            }   
      //验证某一个数字是否是不超过两位的小数
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
      //验证输入的规格格式      
        function isSpecValid(str){
            if(isNull(str)){
             return false;
             }
             var regu = /^(\d+(\.\d+)?)\*(\d+(\.\d+)?)\*(\d+(\.\d+)?)$/ ;	
             var re = new RegExp(regu);	
             return re.test(str);
         }
        //验证输入的日期格式      
        function isDate(str){
            
             var regu = /^(\d{4})\-(\d{2})\-(\d{2})$/ ;
             var re = new RegExp(regu);			
             return re.test(str);
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
        //获得三天后数据
        function afterThreeDate(){
        	 var date = new Date();
        	 date.setDate(date.getDate()+3);
             var seperator1 = "-";
             var month = date.getMonth() + 1;
             var strDate = date.getDate();
             if (month >= 1 && month <= 9) {
                 month = "0" + month;
             }
             if (strDate >= 0 && strDate <= 9) {
                 strDate = "0" + strDate;
             }
             var threeDate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
             return threeDate;
        	
        }
        //从后台获取型号
        function getModel(){
    	var modelobject={};
    	//modellist从数据库获取
    	$.ajax({
    		type:"GET",
    		url:"/plantSCM/BusinessOrder/getModel",//从后台获取产品型号
    		success:function(data){
    			var modellist=data.result;   		
    	    	for(var i=0;i<modellist.length;i++){
    	    		modelobject[modellist[i]]=modellist[i];
    	    	}      	    	
    	    	return modelobject;
    		}
    	});
    	return modelobject;
    	
    }
        //获取联系人
        function getReceiver(){
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
                            afterSelect: function (item) {                            
                            	var temp = {
                            			CustomerName:item                                       
                                    };
                            	$.ajax({
                                    type:"GET",
                                    data:temp,
                                    dataType:"json",
                                    url:"/plantSCM/BusinessOrder/getHanpianOrderByCustomer",//从后台获取选中收货人最近一次购买焊片记录
                                    success:function(data){
                                    	if(data.code==0){
                                    		result=data.result;                                    		
                                    		for(var i=0;i<result.length;i++){
                                    			result[i].hpdeliveryDate=afterThreeDate();
                                    		}
                                    		$("#tb_hp").tabulator("setData", result);                                    		                         		
                                    	}                                    	                                        	              
                                    },                          	       
                                }); 
                            	$.ajax({
                                    type:"GET",
                                    data:temp,
                                    dataType:"json",
                                    url:"/plantSCM/BusinessOrder/getHanjiOrderByCustomer",//从后台获取选中收货人最近一次购买焊片记录
                                    success:function(data){
                                    	if(data.code==0){
                                    		result=data.result;
                                    		for(var i=0;i<result.length;i++){
                                    			result[i].hjdeliveryDate=afterThreeDate();
                                    		}
                                    		$("#tb_hj").tabulator("setData", result);                                    		                         		
                                    	}                                    	                                        	              
                                    },                          	       
                                });  
                            }
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
            <li style="background-color:#F0FFFF;">
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
                         <input type='text' class="form-control" placeholder="请选择下单日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div style="float:left;white-space:pre;">         联系电话</div>
                 <div style="float:left;">
                  <input id="phone" type='text' placeholder="请填写联系电话" />  
                 </div>     
                                                       
               </div>
               <br/>
               <div class="row">
               <span><span class="glyphicon glyphicon-tree-conifer"></span>焊片</span>
               </div>
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hp"></table>
                       <button id="hpadd-row"  type="button" class="btn btn-default" ><span class="glyphicon glyphicon-plus"></span></button>
                       
                       
                   </div>
               </div>
                <br/>
                
               <div class="row">
               <span><span class="glyphicon glyphicon-leaf"></span>焊剂</span>
               </div>
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hj"></table>
                       <button id="hjadd-row"  type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                      
                   </div>
               </div>
               <div class="row">
                  <div style="width:60px; display:block;margin-left: auto;margin-right: auto" >
                  <div>
                   <button id="submit"  type="button" class="btn btn-primary"  style="display:inline;" onclick="clickadd()">提交</button>
                   
                 </div>
                 </div>
              </div>
               
              </div>
              
      </div>
 </div>
</body>
</html>