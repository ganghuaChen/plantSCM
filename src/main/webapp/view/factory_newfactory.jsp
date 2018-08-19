
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
    <script src="/plantSCM/js/bootstrap-table.min.js"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-table.min.css"  /> 
    <script src="/plantSCM/js/bootstrap-table-zh-CN.min.js"></script>
     
    <script src="/plantSCM/js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-select.min.css"  /> 
    <script src="/plantSCM/js/defaults-zh_CN.min.js"></script>
    <script src="/plantSCM/js/moment-with-locales.min.js"></script>  
    <link  rel="stylesheet" href="/plantSCM/css/bootstrap-datetimepicker.min.css">  
    <script src="/plantSCM/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="/plantSCM/js/jquery-ui.min.js"></script>
    <link href="/plantSCM/css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="/plantSCM/js/tabulator.min.js"></script>
    <link  rel="stylesheet" href="/plantSCM/css/toastr.min.css">  
    <script src="/plantSCM/js/toastr.min.js"></script>
    <script src="../js/dialog.js"></script>
    <script src="../js/path.js"></script>
    <script>
   
    $(function(){
    	
    	//设置提示框的属性
    	toastr.options.timeOut = 1800;
    	toastr.options.positionClass = 'toast-top-center';
    	toastr.options.preventDuplicates = true;
    	//在右上角添加用户名字
    	 var storage=window.localStorage;            
         $("#staff-name").html(storage["staffname"]);
         
    	var picker2 = $('#datetimepicker1').datetimepicker({  
   		 format: 'YYYY-MM-DD',         
   		 locale: moment.locale('zh-cn'),
   		 defaultDate: getTodyDate()   		 
      	 });
    //验证输入为不超过三位小数的数字    	
   /* var threefloatnumber = function(cell, value, parameters){
        //cell - the cell component for the edited cell
        //value - the new input value of the cell
        //parameters - the parameters passed in with the validator
        if(value==""){
        	return true;
        }
        
        if(!isNumber(value)){
        	//alert("不是数字");
    		return false;
    	}
        var datastr=value+"";
    	if(datastr.split('.').length > 1 && datastr.split('.')[1].length>3){
        	//alert("超过三位小数");
            return false;
        }
    	if(value<0){
    		//alert("不能为负");
    		return false;
    	}
    	return true;
    }*/

    	$("#example-table").tabulator({
    	    //height:120, // set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
    	    layout:"fitColumns", //fit columns to width of table (optional)
    	    columns:[ //Define Table Columns
    	    	{formatter:"rownum", align:"center", width:40},
    	        {title:"型号", field:"model",editor:true,headerSort:false,editor:"select",editorParams:getmodel(),widthGrow:1},
    	        {title:"银", field:"agWeight",align:"center",headerSort:false,editor:true},
    	        {title:"铜", field:"cuWeight",editor:true,headerSort:false,widthGrow:1},
    	        {title:"锌", field:"znWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
    	        {title:"镉", field:"cdWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
    	        {title:"锡", field:"snWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
    	        {title:"废料", field:"wasteWeight",align:"center",headerSort:false,editor:true,widthGrow:1},
    	        //{title:"消耗总量", field:"batchYlWeight",align:"center",headerSort:false,editor:false,widthGrow:1},
    	        {title:"胚料产出", field:"batchBlanksWeight", align:"center",headerSort:false,editor:true,widthGrow:1},
    	        {title:"炉数(个)", field:"fireNumber",align:"center",headerSort:false,editor:true,widthGrow:1},
    	        //{title:"每炉平均损耗", field:"averageConsume", align:"center",headerSort:false,editor:false,widthGrow:1},
    	        //{title:"总产出比", field:"proportion",  align:"center",headerSort:false,editor:false,widthGrow:1},
    	        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}
    	        
    	    ],
    	
    	});
    
    	//Add row on "Add Row" button click
    	$("#add-row").click(function(){
    		$("#example-table").tabulator("addRow", {});
    		});
    	
    	var tabledata = [
    	   {},{},{},{}
    	];

    	//load sample data into the table
    	$("#example-table").tabulator("setData", tabledata);
    	
    });
    //获得当天日期
    function getTodyDate() {
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

  //验证输入为不超过三位小数的数字    	
    function threefloatnumber(value){
        //cell - the cell component for the edited cell
        //value - the new input value of the cell
        //parameters - the parameters passed in with the validator
        if(value==""){
        	return true;
        }
        if(value==undefined){
        	return true;
        }
		if(isNull(value)){
		    return true;
		}
        
        if(!isNumber(value)){
        	//alert("不是数字");
    		return false;
    	}
        var datastr=value+"";
    	if(datastr.split('.').length > 1 && datastr.split('.')[1].length>3){
        	//alert("超过三位小数");
            return false;
        }
    	if(value<0){
    		//alert("不能为负");
    		return false;
    	}
    	return true;
    }
  //获得当天日期
    function getTodyDate() {
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
  //判断表格第i行是否为空
   //判断表格第i行是否为空
    function rowIsNull(i){
    	var data = $("#example-table").tabulator("getData");
    	if(isNull(data[i].model)&&isNull(data[i].fireNumber)&&isNull(data[i].agWeight)&&isNull(data[i].cuWeight)
    			&&isNull(data[i].znWeight)&&isNull(data[i].cdWeight)&&isNull(data[i].snWeight)&&isNull(data[i].wasteWeight)
    			&&isNull(data[i].batchBlanksWeight)){
    		return true;
    	}
    	return false;
    }
  //点击提交按钮
    function clickadd(){
    	var date =$("#datetimepicker1").find("input").val();
    	if(isNull(date)){
    		toastr.info("请选择日期");
    	}else {
    		add(date);
    	}
    }
  
  //提交
    function add(date){
    	var data = $("#example-table").tabulator("getData");    	
    	var dataarray=[]; 	
    	var k = true;
    	for(var i = 0;i<data.length;i++){
    		if(rowIsNull(i)){
    			continue;
    		}    		
    		if(data[i].fireNumber<=0){
    			toastr.info("炉数必须为正数");
    			k = false;
    			break;
    		}
    		if(isNaN(data[i].fireNumber)){
    			toastr.info("炉数必须为整数");
    			k = false;
    			break;
    		}
    		if(data[i].fireNumber%1!=0){
    			toastr.info("炉数必须为整数");
    			k = false;
    			break;
    		}
    		if(isNull(data[i].model)){
    			toastr.info("请选择型号！");
    			k = false;
    			break;
    		}
    		if(date==""||date==null||date==undefined){
    			toastr.info("请选择日期");
    			k = false;
    			break;
    		}
    		if((!threefloatnumber(data[i].agWeight))||(!threefloatnumber(data[i].cuWeight))||(!threefloatnumber(data[i].znWeight))||(!threefloatnumber(data[i].cdWeight))
    				||(!threefloatnumber(data[i].snWeight))||(!threefloatnumber(data[i].wasteWeight))||(!threefloatnumber(data[i].batchBlanksWeight))){
    			toastr.error("请输入三位小数！");
    			k = false;
    			break;
    		}
    		
    		dataarray.push(data[i]);
    		//console.log(dataarray);
  		
    	}
    	if(dataarray.length==0 && k==true){
    		k = false;
    		toastr.info("请至少输入一条开炉记录！");
    	}
    	if(k==true && dataarray.length > 0){
    		//这是原来的开始
        	for(var i=0;i<dataarray.length;i++){
        		data[i].fireNumber=parseInt(data[i].fireNumber);
        		if(data[i].model!= undefined  && !isNaN(data[i].fireNumber) && data[i].fireNumber>0){
        			data[i].agWeight=parseFloat(data[i].agWeight);
        			if(isNaN(data[i].agWeight)){
        				data[i].agWeight=0;
        			}
        			data[i].cuWeight=parseFloat(data[i].cuWeight);
        			if(isNaN(data[i].cuWeight)){
        				data[i].cuWeight=0;
        			}
        			data[i].znWeight=parseFloat(data[i].znWeight);
        			if(isNaN(data[i].znWeight)){
        				data[i].znWeight=0;
        			}
        			data[i].cdWeight=parseFloat(data[i].cdWeight);
        			if(isNaN(data[i].cdWeight)){
        				data[i].cdWeight=0;
        			}
        			data[i].snWeight=parseFloat(data[i].snWeight);
        			if(isNaN(data[i].snWeight)){
        				data[i].snWeight=0;
        			}
        			data[i].wasteWeight=parseFloat(data[i].wasteWeight);
        			if(isNaN(data[i].wasteWeight)){
        				data[i].wasteWeight=0;
        			}
        			data[i].batchYlWeight=data[i].agWeight+data[i].cuWeight+data[i].znWeight+data[i].cdWeight+data[i].snWeight+data[i].wasteWeight;
        			data[i].batchBlanksWeight=parseFloat(data[i].batchBlanksWeight);
        			if(isNaN(data[i].batchBlanksWeight)){
        				data[i].batchBlanksWeight=0;
        			}    			
        			data[i].averageConsume=parseFloat(((data[i].batchYlWeight-data[i].batchBlanksWeight)/data[i].fireNumber).toFixed(3));
        			data[i].proportion=parseFloat((data[i].batchBlanksWeight/data[i].batchYlWeight).toFixed(3));
        			if(data[i].batchYlWeight==0){
        				toastr.info("开炉消耗总量不能为零");
        				break;
        			}     
        			dataarray[i].openDate=date;  
        		}
        	}	      			        			
        	    	//$("#example-table").tabulator("setData",dataarray);
        	    	//console.log(dataarray);
        		     //设置按钮不可动
   			        $("#searchbutton").attr("disabled",true);
        	    	 $.ajax({
        	             type:"POST",
        	             url:"/plantSCM/OpenFactory/createOpenFactory",//////////////////////////新建开炉
        	             contentType:"application/json;charset=UTF-8",
        	             data:JSON.stringify(dataarray),//将 JavaScript 值转换为 JSON 字符串
        	             dataType:"json",
        	             success:function(data){
        	            	 if(data.code==0){
        	            		 //alert("555");
        	            		// toastr.success(data.msg);
								 //setTimeout("window.location.href='http://localhost:8080/plantSCM/view/factory_openfactoryrecord.jsp'",1000); 
								 //setTimeout(function(){window.location.href = path+"factory_openfactoryrecord.jsp";  },1500);
        	            		 var d = dialog({								
			                    		title: '提示',
			                    		content: data.msg,
			                    		okValue: '确定',
			                    		ok: function () {
			                    			window.location.href = path+"factory_openfactoryrecord.jsp"; 
			                    			return true;
			                    		}
			      
			                    	});
							     d.width(300);
			                     d.show();
        	            	 }
        	            	 else if(data.code==206){
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
        	         			$("#searchbutton").attr("disabled",false);
        	         		}else{
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
        	         			$("#searchbutton").attr("disabled",false);
        	         		}
        	             },
                         error:function(){
                        	 toastr.error('请连接网络');
                        	 $("#searchbutton").attr("disabled",false);
                        	 
                         }
        	          });   
        		}
        	/*	else if(data[i].model = undefined  || !isNaN(data[i].fireNumber) || data[i].fireNumber<=0){
        			toastr.error("数据太少提交失败!");
        		}*/
        	
    	

    }
  
    //获取产品型号数组
    function getmodel(){
    	var modelobject={};
    	//modellist从数据库获取
    	$.ajax({
    		type:"GET",
    		url:"/plantSCM/OpenFactory/getModel",//后台
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
    
    function isNumber(val){

        var regPos = /^\d+(\.\d+)?$/; //非负浮点数
        var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
        if(regPos.test(val) || regNeg.test(val)){
            return true;
        }else{
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
                                
                                <li><a id="nav-staff-name" href="#"><span class="glyphicon glyphicon-user"></span> <span id="staff-name"></span></a></li>
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
                       <div class="col-xs-1 col-md-1"> 
                                                                                 开炉日期</div>
                       
                       <div class="col-xs-3 col-md-3">      
                                <div class='input-group date' id='datetimepicker1'>  
                                <input type='text' class="form-control" placeholder="请选择开炉日期" />  
                                <span class="input-group-addon">  
                                <span class="glyphicon glyphicon-calendar"></span>  
                                </span>  
                                </div>  
                      </div> 
                      
                      <div class="col-xs-2 col-md-2">
                            <button id="searchbutton" style="width:60px" type="button" class="btn btn-primary" onclick=clickadd() >提交</button>
                     </div>
                     
               </div>
               <div class="row">
                   <div class="panel-body" style="padding-bottom:0px;">                                     
                     <div id="example-table"></div>
                     <button id="add-row" style="width:60px" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                  </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>