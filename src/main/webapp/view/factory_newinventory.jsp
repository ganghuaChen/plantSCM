<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>新建盘点清仓</title>
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
    <script src="../js/dialog.js"></script>
    <script src="../js/path.js"></script>
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
    
    $(function(){
    	//在右上角添加用户名字
        var storage=window.localStorage;            
        $("#staff-name").html(storage["staffname"]);
    	//设置提示框的属性
    	toastr.options.timeOut = 1800;
    	toastr.options.positionClass = 'toast-top-center';
    	toastr.options.preventDuplicates = true;
    	
    	//日期
    	var picker = $('#datetimepicker1').datetimepicker({  
    	   	format: 'YYYY-MM-DD',         
    	   	locale: moment.locale('zh-cn'),
    	   	defaultDate: getTodyDate()
    	   	});
        
      //初始化表格
      $("#example-table").tabulator({
    	  layout:"fitColumns",
    	  columnVertAlign:"center", //align header contents to bottom of cell
    columns:[
	 {formatter:"rownum", align:"center", width:40},
        {title:"型号", field:"model", headerSort:false,editor:"select",editorParams:getModel(),width:80},
        //{title:"盘点时间", field:"inventoryDate",headerSort:false,widthGrow:1},//设置时间
        {//create column group
            title:"加工前",
            columns:[
			   
                //{title:"销量", field:"progress", align:"right", sorter:"number", width:80},
                {title:"胚料", field:"beforeBlanks", align:"center",headerSort:false,editor:true,widthGrow:1},
                {title:"废料", field:"beforeWaste", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"散料", field:"beforeBulk", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"半成品", field:"beforeSemi", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"成品", field:"beforeProduct", align:"center",headerSort:false,editor:true,widthGrow:1},
                {title:"呆料", field:"beforeDailiao", align:"center",headerSort:false,editor:true,widthGrow:1},
                //{title:"总重量", field:"beforeTotal", align:"center",headerSort:false,editor:false,width:80},//计算出的
            ],
        },
        {//create column group
            title:"加工后",
            columns:[
            	{title:"销量", field:"afterSale", align:"center",headerSort:false,editor:true,widthGrow:1},
                //{title:"胚料", field:"rating", align:"center", width:80},
                {title:"废料", field:"afterWaste", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"散料", field:"afterBulk", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"半成品", field:"afterSemi", align:"center",headerSort:false,editor:true,widthGrow:1},
                {title:"成品", field:"afterProduct", align:"center", headerSort:false,editor:true,widthGrow:1},
                {title:"呆料", field:"afterDailiao", align:"center", headerSort:false,editor:true,widthGrow:1},
                //{title:"总重量", field:"afterTotal", align:"center",headerSort:false,editor:false, width:80},
            ],
        },
        //{title:"误差", field:"dValue",headerSort:false,editor:false,validator:threefloatnumber,widthGrow:1},//算出来的
        {title:"操作",field:"operation",formatter:"tickCross",align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function(e, cell){cell.getRow().delete()}}
    ],
});
      
    
    	$("#add-row").click(function(){
    		$("#example-table").tabulator("addRow", {},{});
    		});
    	
        var tabledata = [
      	   {},{},{},{}
      	];
     	//load sample data into the table
     	$("#example-table").tabulator("setData", tabledata);
    });
 
    //判断表格第i行是否为空
    function rowIsNull(i){
    	var data = $("#example-table").tabulator("getData");   	
    	if((isNull(data[i].model)) && (isNull(data[i].beforeBlanks)) && (isNull(data[i].afterProduct))
    			&&(isNull(data[i].beforeWaste))&&(isNull(data[i].beforeBulk))&&(isNull(data[i].beforeSemi))
    			&&(isNull(data[i].beforeProduct))&&(isNull(data[i].beforeDailiao))&&(isNull(data[i].afterSale))
    			&&(isNull(data[i].afterWaste))&&(isNull(data[i].afterBulk))&&(isNull(data[i].afterDailiao))){
    		return true;
    	}
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
  function add(date){
  	var data = $("#example-table").tabulator("getData");  	
  	var dataarray=[];
  	var k=true;
  	for(var i=0;i<data.length;i++){
  		if(rowIsNull(i)){
  			continue;
  		}
          //data[i].inventoryDate = date;            
          if(date==undefined){
      		toastr.info("请选择时间");
      		k=false;
      		break;
      	}   		
  		if(isNull(data[i].model)){
  			toastr.info("请选择型号");
  			k=false;
  			break;
  		}

  		if((!threefloatnumber(data[i].beforeBlanks))||(!threefloatnumber(data[i].beforeWaste))||(!threefloatnumber(data[i].beforeBulk))||(!threefloatnumber(data[i].beforeSemi))
  				||(!threefloatnumber(data[i].beforeProduct))||(!threefloatnumber(data[i].beforeDailiao))||(!threefloatnumber(data[i].afterSale))||(!threefloatnumber(data[i].afterWaste))||
  				(!threefloatnumber(data[i].afterBulk))||(!threefloatnumber(data[i].afterSemi))||(!threefloatnumber(data[i].afterProduct))||(!threefloatnumber(data[i].afterDailiao))){
  					toastr.info("请输入三位以内小数");
  	    			k=false;
  	    			break;
  	    }
  		data[i].beforeBlanks = parseFloat(data[i].beforeBlanks);
			if(isNaN(data[i].beforeBlanks)){
				data[i].beforeBlanks = 0;
			}
  		data[i].afterProduct = parseFloat(data[i].afterProduct);
  		if(isNaN(data[i].afterProduct)){
  			data[i].afterProduct = 0;
  		}
  		data[i].beforeWaste=parseFloat(data[i].beforeWaste);
  		if(isNaN(data[i].beforeWaste)){
  			data[i].beforeWaste=0;
  		}
  		data[i].beforeBulk=parseFloat(data[i].beforeBulk);
  		if(isNaN(data[i].beforeBulk)){
  			data[i].beforeBulk=0;
  		}   
  		data[i].beforeSemi=parseFloat(data[i].beforeSemi);
  		if(isNaN(data[i].beforeSemi)){
  			data[i].beforeSemi=0;
  		}
  		data[i].beforeProduct=parseFloat(data[i].beforeProduct);
  		if(isNaN(data[i].beforeProduct)){
  			data[i].beforeProduct=0;
  		}  
  		data[i].beforeDailiao=parseFloat(data[i].beforeDailiao);
  		if(isNaN(data[i].beforeDailiao)){
  			data[i].beforeDailiao=0;
  		} 
  		data[i].afterSale=parseInt(data[i].afterSale);
  		if(isNaN(data[i].afterSale)){
  			data[i].afterSale=0;
  		} 
  		data[i].afterWaste=parseFloat(data[i].afterWaste);
  		if(isNaN(data[i].afterWaste)){
  			data[i].afterWaste=0;
  		} 
  		data[i].afterBulk=parseFloat(data[i].afterBulk);
  		if(isNaN(data[i].afterBulk)){
  			data[i].afterBulk=0;
  		} 
  		data[i].afterSemi=parseFloat(data[i].afterSemi);
  		if(isNaN(data[i].afterSemi)){
  			data[i].afterSemi=0;
  		} 
  		data[i].afterDailiao=parseFloat(data[i].afterDailiao);
  		if(isNaN(data[i].afterDailiao)){
  			data[i].afterDailiao=0;
  		}  
  		data[i].afterProduct = parseFloat(data[i].afterProduct);
  		if(isNaN(data[i].afterProduct)){
  			data[i].afterProduct = 0;
  		}
  			//计算
  			
  			data[i].beforeTotal = parseFloat((data[i].beforeBlanks+data[i].beforeWaste+data[i].beforeBulk+data[i].beforeSemi+data[i].beforeProduct+data[i].beforeDailiao).toFixed(3));   
  			data[i].afterTotal = parseFloat((data[i].afterSale+data[i].afterWaste+data[i].afterBulk+data[i].afterSemi+data[i].afterDailiao+data[i].afterProduct).toFixed(3));
  			if(!(data[i].beforeTotal>0)){
  				toastr.info("加工前总重量不能为空");
  				k=false;
  				break;
  			}
  			if( !(data[i].afterTotal>0)){
  				toastr.info("加工后总重量不能为空");
  				k=false;
  				break;
  			}
  			if(data[i].beforeTotal>0 && data[i].afterTotal>0){
  				data[i].dValue = data[i].afterTotal - data[i].beforeTotal;
  			}
  			data[i].inventoryDate = date;
  		dataarray.push(data[i]);  		
  	}//for结束
  	if(dataarray.length==0 && k==true){
  		toastr.info("请至少输入一条记录！");
  		k = false;
  		
  	}
  	
  	if(k == true && dataarray.length>0){
      			
              	if(dataarray.length>=1 && k == true){
              		
              		$("#example-table").tabulator("setData",dataarray);
              	    //设置按钮不可动
    		        $("#searchbutton").attr("disabled",true);
                  	$.ajax({
                          type:"POST",
                          url:"/plantSCM/FactoryPd/createFactoryPdRecord",
                          contentType:"application/json;charset=UTF-8",
                          data:JSON.stringify(dataarray),//将 JavaScript 值转换为 JSON 字符串
                          dataType:"json",
                          success:function(data){  
                          	if(data.code==0){
                          		//toastr.success(data.msg);
                          		//setTimeout(function(){window.location.href = path+"factory_inventory.jsp";  },1000);
                          		var d = dialog({								
		                    		title: '提示',
		                    		content: data.msg,
		                    		okValue: '确定',
		                    		ok: function () {
		                    			window.location.href = path+"factory_inventory.jsp";
		                    			return true;
		                    		}
		      
		                    	});
						     d.width(300);
		                     d.show();
								//setTimeout("window.location.href = 'http://localhost:8080/plantSCM/view/factory_inventory.jsp'",1000)     
								
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
               			        $("#searchbutton").attr("disabled",false);
                          	}
                          },
                          error:function(){
                            	 toastr.error('请连接网络');
                            	 $("#searchbutton").attr("disabled",false);
                            	 
                             }
                       });   	
              	}
  	    }
  }
    		
    
    
    
    //从后台获取型号
    function getModel(){
	var modelobject={};
	//modellist从数据库获取
	$.ajax({
		type:"GET",
		url:"/plantSCM/FactoryPd/getModel",//后台
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

    //验证输入是否为空或者全部为空字符串 或者为null或者为undefined 
    //空的返回true
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
                       <div class="col-xs-1 col-md-1"> 
                                                                                 盘点日期</div>
                       
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