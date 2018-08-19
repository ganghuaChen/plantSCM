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
        	
        	
        	 //初始化日期选择器
        	 var picker1 = $('#datetimepicker1').datetimepicker({          
        		 format: 'YYYY-MM-DD',          
        		 locale: moment.locale('zh-cn'), 
        		 defaultDate: getEndDate() 
        		 });  
        	 
        	//初始化平均价格表
        	$("#tb_average").tabulator({        	    
         	   layout:"fitColumns", //fit columns to width of table (optional)
         	   columnVertAlign:"bottom", //align header contents to bottom of cell
         	    columns:[ 
         	        {
         	            title:"库存原料平均价格",
         	            columns:[
         	                {title:"银", field:"ag",headerSort:false},
         	                {title:"铜", field:"cu",headerSort:false},
         	                {title:"锌", field:"zn",headerSort:false},
         	                {title:"镉", field:"ge",headerSort:false},
         	                {title:"锡", field:"sn",headerSort:false},
         	            ],
         	        },
         	    ],
         	   
         	  
         	});  
        	getylaverage();
        	//初始化原料表
        	 $("#tb_yl").tabulator({        	    
         	    layout:"fitColumns", //fit columns to width of table (optional)       	    
         	    columns:[ //Define Table Columns           	    	
         	        {title:"种类", field:"ylSpecies",align:"center",headerSort:false,widthGrow:1,editor:"select",editorParams:{"银":"银","铜":"铜","锌":"锌","镉":"镉","锡":"锡"},},     	         
         	        {title:"单价", field:"ylPrice", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"重量", field:"ylWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"厂家", field:"ylFactory", align:"center",headerSort:false,editor:true,widthGrow:1},        	          	       
         	        {title:"备注", field:"ylnote", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}   
         	       
         	    ], 
         	   
         	  
         	});  
        	
        	//初始化焊剂表
        	 $("#tb_hj").tabulator({        	    
         	    layout:"fitColumns", //fit columns to width of table (optional)        	  
         	    columns:[ //Define Table Columns        	    	
         	        {title:"种类", field:"hjSpecies",align:"center",editor:true,headerSort:false,widthGrow:1}, 
         	        {title:"单价", field:"hjPrice", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"数量", field:"hjNumber", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"厂家", field:"hjFrom", align:"center",headerSort:false,editor:true,widthGrow:1},         	                 	            	       
         	        {title:"备注", field:"hjNote", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}   
         	       
         	    ], 
         	  
         	});  
        	//初始化焊片表
        	 $("#tb_hp").tabulator({        	    
         	    layout:"fitColumns", //fit columns to width of table (optional)        	    
         	    columns:[        	    	
         	        {title:"形状", field:"hpShape",align:"center",editor:true,headerSort:false,widthGrow:1,editor:"select",editorParams:{"直":"直","弯":"弯"},},
         	        {title:"型号", field:"hpModel",align:"center",headerSort:false,editor:"select",widthGrow:1,editorParams:getmodel()},
         	        {title:"规格", field:"hpSpec",align:"center",editor:true,headerSort:false,widthGrow:1},        	       
         	        {title:"单价", field:"hpPrice", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"重量", field:"hpWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"厂家", field:"hpFactory", align:"center",headerSort:false,editor:true,widthGrow:1},
        	      	       
         	        {title:"备注", field:"hpNote", align:"center",headerSort:false,editor:true,widthGrow:1},
         	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}   
         	       
         	    ], 
         	  
         	  
         	});  
 
        	
        	 var tabledata1 = [{},{},{},{},];          	
          	 $("#tb_yl").tabulator("setData", tabledata1);
          	 var tabledata2 =[{},{},{},{},];            	
             $("#tb_hj").tabulator("setData", tabledata2);
             var tabledata3 = [{},{},{},{},];           	
             $("#tb_hp").tabulator("setData", tabledata3);
        	
             
             $("#yladd-row").click(function(){
         		$("#tb_yl").tabulator("addRow", {});
         		});
         	
	
        	$("#hjadd-row").click(function(){
        		$("#tb_hj").tabulator("addRow", {});
        		});
        	
        	$("#hpadd-row").click(function(){
        		$("#tb_hp").tabulator("addRow", {});
        		});
        	
        	
        	
        }); 
        function getylaverage(){
        	$.ajax({
        		type:"GET",
        		url:"/plantSCM/BusinessPurchase/getMaterialAveragePrice",//从后台获取所有原料平均价格
        		success:function(data){
				    if(data.code==0){
					var averagelist=data.result;           			
        			var tableobject={};
        			for(var i=0;i<averagelist.length;i++){			
        				switch(averagelist[i].ylType)
        				{
        				case "银":
        					tableobject.ag=averagelist[i].ylAveragePrice;
        				  break;
        				case "铜":
        					tableobject.cu=averagelist[i].ylAveragePrice;
        				  break;
        				case "锌":
        					tableobject.zn=averagelist[i].ylAveragePrice;
        				  break;
        				case "镉":
        					tableobject.ge=averagelist[i].ylAveragePrice;
        				  break;   
        				case "锡":
        					tableobject.sn=averagelist[i].ylAveragePrice;
        				  break;    
        				}
        			}
        			
        			var tabledata = [tableobject];        			
                 	 $("#tb_average").tabulator("setData", tabledata);   	    	
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
        function getmodel(){
        	var modelobject={};
        	//modellist从数据库获取
        	$.ajax({
        		type:"GET",
        		url:"/plantSCM/BusinessPurchase/getModel",//从后台获取所有型号
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

       
      //判断原料第i行是否为空行
        function ylRowIsNull(i){
        	var data = $("#tb_yl").tabulator("getData");
        	if(isNull(data[i].ylSpecies) && isNull(data[i].ylPrice) && isNull(data[i].ylWeight) && isNull(data[i].ylFactory) 
        			 && isNull(data[i].ylnote)){
        		return true;
        	}
        	return false;
        }
        //判断焊片第i行是否为空行
        function hpRowIsNull(i){
        	var data = $("#tb_hp").tabulator("getData");
        	if(isNull(data[i].hpShape) && isNull(data[i].hpModel) && isNull(data[i].hpSpec) && isNull(data[i].hpWeight) &&
        			isNull(data[i].hpPrice) && isNull(data[i].hpFactory)  && isNull(data[i].hpNote)){
        		return true;
        	}
        	return false;
        }
        //判断焊剂第i行是否为空行
        function hjRowIsNull(i){
         	var data = $("#tb_hj").tabulator("getData");
         	if(isNull(data[i].hjSpecies) && isNull(data[i].hjPrice) && isNull(data[i].hjNumber) && isNull(data[i].hjFrom) 
         			 && isNull(data[i].hjNote) ){
         		return true;
         	}
         	return false;
         }
        //点击提交按钮
    	function clickadd(){
    		var date =$("#datetimepicker1").find("input").val();
    	   if(isNull(date)){
    			toastr.info("请填写采购日期");
    		}else{
    			add(date);
    		}
    	}
    	//提交
        function add(date){
        	var datayl = $("#tb_yl").tabulator("getData");
        	var datajsonyl=[];
        	var kyl=true;
        	for(var i=0;i<datayl.length;i++){        		
        		if(ylRowIsNull(i)){
        			continue;
        		}        		
        		datayl[i].ylPrice=Number(datayl[i].ylPrice);
        		datayl[i].ylWeight=Number(datayl[i].ylWeight);
        		if(isNull(datayl[i].ylSpecies)){        			       			
        			toastr.info("请填写原料种类");
        			kyl=false;
        			break;
        		} 
				
        		else if(!isTwoFloat(datayl[i].ylPrice)){
        			toastr.info("原料单价请填写不超过两位小数的正数");
        			kyl=false;
        			break;
        		}
        		else if(!isThreeFloat(datayl[i].ylWeight)){
        			toastr.info("原料重量请填写不超过三位小数的正数");
        			kyl=false;
        			break;
        			
        		}
				else if(isNull(datayl[i].ylFactory)){        			       			
        			toastr.info("请填写原料厂家");
        			kyl=false;
        			break;
        		} 
        		datayl[i].ylDate=date;
				datayl[i].ylTotalPrice=parseFloat((datayl[i].ylPrice*datayl[i].ylWeight).toFixed(2));
        		datajsonyl.push(datayl[i]);
        	}
    		var datahj = $("#tb_hj").tabulator("getData");
        	var datajsonhj=[];              	
        	var khj=true;
        	for(var i=0;i<datahj.length;i++){
        		if(hjRowIsNull(i)){
        			continue;
        		}  
        		datahj[i].hjPrice=Number(datahj[i].hjPrice);        		
        		datahj[i].hjNumber=Number(datahj[i].hjNumber);
        		if(isNull(datahj[i].hjSpecies)){        			       			
        			toastr.info("请填写焊剂种类");
        			khj=false;
        			break;
        		} 
				else if(!isTwoFloat(datahj[i].hjPrice)){
        			toastr.info("焊剂单价请填写不超过两位小数的正数");
        			khj=false;
        			break;
        		}
				else if(!isInteger(datahj[i].hjNumber)){
        			toastr.info("数量请填写正整数");
        			khj=false;
        			break;
        			
        		}
				else if(isNull(datahj[i].hjFrom)){        			       			
        			toastr.info("请填写焊剂厂家");
        			khj=false;
        			break;
        		} 
        		
        		datahj[i].hjDate=date;  
				datahj[i].hjTotalPrice=parseFloat((datahj[i].hjPrice*datahj[i].hjNumber).toFixed(2));
        		datajsonhj.push(datahj[i]);
        	}
        	var data = $("#tb_hp").tabulator("getData");
        	var datajson=[];
        	var k=true;
        	for(var i=0;i<data.length;i++){
        		
        		if(hpRowIsNull(i)){
        			continue;
        		}        		
        		data[i].hpPrice=Number(data[i].hpPrice);       		
        		data[i].hpWeight=Number(data[i].hpWeight);
        		if(isNull(data[i].hpShape)){        			       			
        			toastr.info("请填写焊片形状");
        			k=false;
        			break;
        		} 
				else if( isNull(data[i].hpModel)){        			       			
        			toastr.info("请填写焊片型号");
        			k=false;
        			break;
        		} 
				else if(!isSpecValid(data[i].hpSpec)){        			       			
					toastr.info('焊片规格请填写为1*1*1的格式');
        			k=false;
        			break;
        		} 
        		else if(!isTwoFloat(data[i].hpPrice) ){
        			toastr.info("焊片单价请填写不超过两位小数的正数");
        			k=false;
        			break;
        		}
        		else if(!isInteger(data[i].hpWeight)){
        			toastr.info("焊片重量请填写正整数");
        			k=false;
        			break;
        			
        		} 
               else if(isNull(data[i].hpFactory)){        			       			
        			toastr.info("请填写焊片厂家");
        			k=false;
        			break;
        		} 				
        		data[i].hporderDate=date;  
                data[i].hpTotalPrice=parseFloat((data[i].hpPrice*data[i].hpWeight).toFixed(2));				
        		datajson.push(data[i]);

        	}
        	     
    		if(k==true && kyl==true && khj==true && datajsonyl.length==0 && datajsonhj.length==0 && datajson.length==0 ){
    			toastr.info("请至少填写一条记录");
    		}else if(k==true && kyl==true && khj==true){
    			var purchase={
    					hpPurchase:datajson,
    					hjPurchase:datajsonhj,
        				materialPurchase:datajsonyl
        		}
    			//设置按钮不可动
   			   $("#submit").attr("disabled",true);
        		 $.ajax({
                     type:"POST",
                     url:"/plantSCM/BusinessPurchase/creatPurchase",//向后台发送原料、焊片、焊剂采购记录
                     contentType:"application/json;charset=UTF-8",
                     data:JSON.stringify(purchase),//将 JavaScript 值转换为 JSON 字符串
                     dataType:"json",
                     success:function(data){  
                    	 if(data.code==0){
						       $("#tb_hp").tabulator("setData", datajson);
							   $("#tb_hj").tabulator("setData", datajsonhj);
							   $("#tb_yl").tabulator("setData", datajsonyl);
							   //toastr.success(data.msg);
							   //setTimeout(function(){window.location.href = path+"business_purchaserecord.jsp";  },1500);
							   var d = dialog({								
		                    		title: '提示',
		                    		content: data.msg,
		                    		okValue: '确定',
		                    		ok: function () {
		                    			window.location.href = path+"business_purchaserecord.jsp";
		                    			return true;
		                    		}
		      
		                    	});
						     d.width(300);
		                     d.show();
                    		 
                    		 
                    	 }
                    	 else{
                    		 //toastr.error(data.msg);
                    		 var d = dialog({								
		                    		title: '提示',
		                    		content: data.msg,
		                    		okValue: '确定',
		                    		ok: function () {
		                    			//window.location.href = path+"business_purchaserecord.jsp";
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
        //验证输入的规格格式      
        function isSpecValid(str){
            if(isNull(str)){
             return false;
             }
             var regu = /^(\d+(\.\d+)?)\*(\d+(\.\d+)?)\*(\d+(\.\d+)?)$/ ;	
             var re = new RegExp(regu);	
             return re.test(str);
         }
		//验证是否正整数
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
        //验证某一个数字是否是不超过三位的小数
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
      //验证输入的日期格式
      
        function isDate(str){
            
             var regu = /^(\d{4})\-(\d{2})\-(\d{2})$/ ;
             var re = new RegExp(regu);
             return re.test(str);
         }
        //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
        function isNull(str){
        	if(!str) return true;
             if ( str == "" ) return true;
             var regu = "^[ ]+$";
             var re = new RegExp(regu);
             return re.test(str);
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
               <div style="float:left;">采购日期</div>
                <div style="width:200px;float:left;">                 
                    <div class='input-group date' id='datetimepicker1' >  
                         <input type='text' class="form-control" placeholder="请选择采购日期" />  
                         <span class="input-group-addon">  
                         <span class="glyphicon glyphicon-calendar"></span>  
                         </span>  
                    </div>  
                </div>
                <div class="col-xs-5 col-md-5" style="float:right;">
                <table id="tb_average"></table>
                 </div>                                                                       
               </div>
               <br/>
               
               
               <div class="row">
               <span><span class="glyphicon glyphicon-tree-conifer"></span>原料</span>
               </div>
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_yl"></table>
                       <button id="yladd-row"  type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                       
                   </div>
               </div>
               
               
               
               
               <div class="row">
               <span><span class="glyphicon glyphicon-tree-conifer"></span>焊剂</span>
               </div>
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_hj"></table>
                       <button id="hjadd-row"  type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                      
                   </div>
               </div>
               
               
               
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