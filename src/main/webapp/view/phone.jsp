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
    <script type="text/javascript" src="/plantSCM/js/jquery-ui.min.js"></script>
    <link href="/plantSCM/css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="/plantSCM/js/tabulator.min.js"></script>
    <script src="/plantSCM/js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-select.min.css"  /> 
    <script src="/plantSCM/js/defaults-zh_CN.min.js"></script>
    <script src="/plantSCM/js/moment-with-locales.min.js"></script>  
    <link  rel="stylesheet" href="/plantSCM/css/bootstrap-datetimepicker.min.css">  
    <script src="/plantSCM/js/bootstrap-datetimepicker.min.js"></script>
    <link  rel="stylesheet" href="/plantSCM/css/toastr.min.css">  
    <script src="/plantSCM/js/toastr.min.js"></script>
    <script src="../js/path.js"></script>
	<script type="text/javascript">
	
	 //默认日期
    $(function(){
    	//在右上角添加用户名字
        var storage=window.localStorage;            
        $("#staff-name").html(storage["staffname"]);
    	//设置提示框的属性
    	toastr.options.timeOut = 1300;
    	toastr.options.positionClass = 'toast-top-center';
    	toastr.options.preventDuplicates = true;
	//初始化表格
    $("#example-table").tabulator({
	    //height:120, // set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
	    layout:"fitColumns", //fit columns to width of table (optional)
	    columns:[ //Define Table Columns
	    	{formatter:"rownum", align:"center", width:60},
	    	//{title:"编号",formatter:function(value,row,index){return index+1;}},
	    	{title:"角色",field:"role",editor:"select",editorParams:{"仓库":"仓库","工厂":"工厂","商务":"商务","领导":"领导"},headerSort:false},       
	        {title:"联系电话", field:"staffPhone",headerSort:false,editor:true,widthGrow:2},//如果选择入库则这几行disabled
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

function add(){
	var data = $("#example-table").tabulator("getData");
	console.log(data);
	var dataarray=[];
	var k = true;
	for(var i=0;i<data.length;i++){
		if(rowIsNull(i)){
			continue;
		}
		if(isNull(data[i].role)){
			k = false;
			toastr.info("请选择角色");
			break;
		}
		if(!isValid(data[i].staffPhone)){
		    k = false;
			toastr.info("请输入11位正确电话号码");
			break;		
		}
		dataarray.push(data[i]);
	}
	console.log(dataarray);
	if(k==true && dataarray.length==0){
		toastr.info("请输入至少一条记录");
		k=false;
	}
	if(dataarray.length>=1 && k==true){
		$.ajax({
                type:"POST",
                url:"/plantSCM/HpOut/addphone",////////////////////////////////////////增加电话号码
                contentType:"application/json;charset=UTF-8",
                data:JSON.stringify(dataarray),//将 JavaScript 值转换为 JSON 字符串
                dataType:"json",
                success:function(data){  
                	if(data.code==0){
                		toastr.success(data.msg);
						 //setTimeout("window.location.href='http://localhost:8080/plantSCM/view/factory_hpoutrecord.jsp'",1000);
						 setTimeout(function(){window.location.href = path+"system_phone.jsp";  },1500);               		
                	}
                	else {
                		toastr.error(data.msg);                   		
       			        //$("#searchbutton").attr("disabled",false);
                	}
                 
                },
                error:function(){
               	 toastr.error('出现错误');
               	 $("#searchbutton").attr("disabled",false);             	 
                }
             });  		
	}
	
	 
}
//验证手机号码是否合法
       function isValid(Data){           	
    	   var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
           if (!myreg.test(Data)){
               return false;
           } 
		   else {
               return true;
           }
       }

//判断表格第i行是否为空.
    function rowIsNull(i){
    	var data = $("#example-table").tabulator("getData");
    	if(isNull(data[i].role) && isNull(data[i].phone)){
    		return true;
    	}
    	//有一个项不为空则返回false
    	return false;
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
	</head><body>
          <!--水平导航栏-->
          <header>
                <nav class="navbar navbar-default fixed" id="header-nav" role="navigation" style="width:100%">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="#">进销存管理系统</a>
                        </div>
                        <div class="fl">
                            <ul class="nav navbar-nav">
                                <li class="role-navbar-nav active" id="factory-navbar-nav"><a href="javascript:void(0)" onclick="systemmanage()">系统管理</a></li>
                            </ul>
							<ul class="nav navbar-nav">
                                <li class="role-navbar-nav " id="factory-navbar-nav"><a href="javascript:void(0)" onclick="businessmanage()">商务</a></li>
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
            <a href="javascript:void(0);" onclick="clickinform()">
            <i class="glyphicon glyphicon-envelope"></i>
                                        通知列表           
            </a>
            </li>          
            <li style="background-color:#F0FFFF;">
            <a href="javascript:void(0);" onclick="clickphone_shezhi()">
             <i class="glyphicon glyphicon-edit"></i>
                           电话设置
            </a>
            </li>    
             <li>
            <a href="javascript:void(0);" onclick="clickmodel_shezhi()">
             <i class="glyphicon glyphicon-edit"></i>
                           型号设置
            </a>
            </li>                             
            </ul>
            </div>
             <!--垂直导航栏结束-->        
           <div class="col-xs-11 col-md-11">          
                <div class="row">                                                                
               </div>       
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                   <div class="col-sm-4">
                       <table id="example-table"></table>
					   <button id="add-row" style="width:60px" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                       </div>
                   </div>                
               </div>
			
			   </br>
			   <div class="col-xs-4 col-md-4">
                            <button id="searchbutton" style="width:60px" type="button" class="btn btn-primary" onclick=add() >提交</button>
                     </div>
      </div>
      </div>
   </div>
</body>
	
	</html>
	