
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>新建出厂记录</title>
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
    <script src="../js/path.js"></script>
    <script src="../js/dialog.js"></script>
    <script type="text/javascript">
   
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
    //默认日期
    $(function(){
    	//在右上角添加用户名字
        var storage=window.localStorage;            
        $("#staff-name").html(storage["staffname"]);
    	//设置提示框的属性
    	toastr.options.timeOut = 1800;
    	toastr.options.positionClass = 'toast-top-center';
    	toastr.options.preventDuplicates = true;
    	
    var picker = $('#datetimepicker1').datetimepicker({  
   	format: 'YYYY-MM-DD',         
   	locale: moment.locale('zh-cn'),
   	defaultDate: getTodyDate()
   	});
 
    
    //初始化表格
    $("#example-table").tabulator({
	    //height:120, // set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
	    layout:"fitColumns", //fit columns to width of table (optional)
	    columns:[ //Define Table Columns
	    	{formatter:"rownum", align:"center", width:40},
	    	//{title:"编号",formatter:function(value,row,index){return index+1;}},
	    	//{title:"",field:"id",editor:true,headerSort:false},
	        {title:"形状", field:"outShape",editor:true,headerSort:false,editor:"select",editorParams:{"直":"直","弯":"弯"},widthGrow:1},
	        {title:"型号", field:"outModel",editor:true,headerSort:false,editor:"select",editorParams:getModel(),widthGrow:1},
	        {title:"规格(厚*长*宽)", field:"outSpec",align:"left",headerSort:false,editor:true,widthGrow:2},
	        {title:"重量(kg)", field:"outWeight",editor:true,headerSort:false,widthGrow:1},
	        {title:"出厂流向", field:"outFlow", headerSort:false,editor:"select",editorParams:{"入库":"入库","发货":"发货"},widthGrow:1},  
	        {title:"收货人", field:"customerName", headerSort:false,editor:true,widthGrow:1},//如果选择出厂则这两行需要填
	        {title:"收货电话", field:"customerPhone",headerSort:false,editor:true,widthGrow:1},//如果选择入库则这几行disabled
	        {title:"单价(元/kg)",field:"price",headerSort:false,editor:true,widthGrow:1},
	        {title:"总价(元)",field:"totalPrice",headerSort:false,editor:false,widthGrow:1},
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
    
  //判断三位小数
    function threefloatnumber(value){
    	if(value==""){
        	return true;
        }
        if(value==undefined){
        	return true;
        }
        if(!isNumber(value)){
    		return false;
    	}
        var datastr=value+"";
    	if(datastr.split('.').length > 1 && datastr.split('.')[1].length>3){
            return false;
        }
    	if(value<0){
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
    //判断两位小数
    function twofloatnumber(value){
    	if(value==""){
        	return true;
        }
        if(value==undefined){
        	return true;
        }
        if(!isNumber(value)){
    		return false;
    	}
        var datastr=value+"";
    	if(datastr.split('.').length > 1 && datastr.split('.')[1].length>2){
            return false;
        }
    	if(value<0){
    		return false;
    	}
    	return true;
    }
    //判断表格第i行是否为空.
    function rowIsNull(i){
    	var data = $("#example-table").tabulator("getData");
    	if(isNull(data[i].outModel) && isNull(data[i].outSpec)  && isNull((data[i].outShape))  && isNull(data[i].outFlow) &&
    			isNull(data[i].outWeight) && isNull(data[i].customerName) && isNull(data[i].price) && isNull(data[i].customerPhone)){
    		return true;
    	}
    	//有一个项不为空则返回false
    	return false;
    }
    //点击提交按钮
    function clickadd(){
    	var date =$("#datetimepicker1").find("input").val();  
    	if(isNull(date)){
    		toastr.info("请选择日期");
    	}else{
    		add(date);
    	}
    }
    //提交
//提交
    function add(date){
    	
    	var data = $("#example-table").tabulator("getData");
    	//var date =$("#datetimepicker1").find("input").val();   
    	var dataarray=[];
    	var k = true;//////
    	
    	//这是选择流向为送货的函数，还要再写一个入库时的操作
    	for(var i=0;i<data.length;i++){
    		data[i].outDate=date;
    		if(rowIsNull(i)){////
    			continue;////
    		}///
    		if(isNull(data[i].outShape)){/////
    			k=false;
    			toastr.info("请选择形状");
    			break;
    		}//////
    		if(isNull(data[i].outModel)){/////
    			toastr.info("请选择型号");
    			k=false;  
    			break;
    		}////
    		if(!isSpecValid(data[i].outSpec)){/////
    			toastr.info('焊片规格请填写为1*1*1的格式');
    			k=false;   
    			break;
    		}////
    		if(isNull(data[i].outWeight)){/////
    			toastr.info("请输入重量");
    			k=false;   		
    			break;
    		}////
			if(!threefloatnumber(data[i].outWeight)){
    			toastr.error("请输入三位小数！");
    			k = false;
    			break;
    		}
    		if(isNull(data[i].outFlow)){/////
    			toastr.info("请选择出厂流向");
    			k=false;  
    			break;
    		}////
    		
    	
    	if((data[i].outFlow=="发货")){    		
    		if(isNull(data[i].customerName)){
    			toastr.info("请输入收货人姓名");
    			k = false;
    			break;
    		}
    		if(isNull(data[i].price)){
    			toastr.info("请输入单价");
    			k = false;
    			break;
    		}
    		if(!isNull(data[i].price) && !twofloatnumber(data[i].price)){
    			toastr.error("请输入两位小数！");
    			k = false;
    			break;
    		}    			
        	data[i].outWeight=parseFloat(data[i].outWeight);
            data[i].price = parseFloat(data[i].price);
            data[i].totalPrice = parseFloat((data[i].outWeight*data[i].price).toFixed(2));          
            dataarray.push(data[i]);
            console.log("执行到这里了")
        }
    	
    	
    		//入库
    	else if((data[i].outFlow=="入库")){    		
    		data[i].customerName="";
			data[i].customerPhone="";
			data[i].price="";
			data[i].totalPrice="";    		
    		dataarray.push(data[i]);    		
    	}		
    }///for循环结束
    	if(dataarray.length==0 && k== true){
    		toastr.info("请输入至少一条记录");
    		k=false;
    		//break;
    	}
  
    	//判断dataarray是零时才提交
    	if(dataarray.length>=1 && k== true){
    		//$("#example-table").tabulator("setData",dataarray);
    		for(var i=0;i<dataarray.length;i++){
    	    	if(dataarray[i].outFlow == "入库"){
    	    		dataarray[i].outFlow=true;
    	    	}
    	    	else{
    	    		dataarray[i].outFlow=false;
    	    	}
    	    	}
    		//设置按钮不可动
		        $("#searchbutton").attr("disabled",true);
       	 $.ajax({
                type:"POST",
                url:"/plantSCM/HpOut/createHpOutRecord",
                contentType:"application/json;charset=UTF-8",
                data:JSON.stringify(dataarray),//将 JavaScript 值转换为 JSON 字符串
                dataType:"json",
                success:function(data){  
                	if(data.code==0){
                		//toastr.success(data.msg);
						 //setTimeout("window.location.href='http://localhost:8080/plantSCM/view/factory_hpoutrecord.jsp'",1000);
						 //setTimeout(function(){window.location.href = path+"factory_hpoutrecord.jsp";  },1500); 
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
                	else {
                		//toastr.error(data.msg);                   		
       			        //$("#searchbutton").attr("disabled",false);
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
                error:function(){
               	 toastr.error('请连接网络');
               	 $("#searchbutton").attr("disabled",false);
               	 
                }
             });  		
       	    		
    	}
    	/*else if(k == true) {
    		toastr.info('请输入至少一行数据');
    	}*/
    	
    }
    //从后台获取型号
        function getModel(){
    	var modelobject={};
    	//modellist从数据库获取
    	$.ajax({
    		type:"GET",
    		url:"/plantSCM/HpOut/getModel",//后台
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
        //空的时候返回true
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
                       <div class="col-xs-1 col-md-1"> 
                                                                                 出厂日期</div>
                       
                       <div class="col-xs-3 col-md-3">      
                                <div class='input-group date' id='datetimepicker1'>  
                                <input type='text' class="form-control" />  
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