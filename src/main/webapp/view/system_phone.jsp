<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html>

<html>
<head>
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
    <script>
   
    var datas=[];
        $(function () {
        	//在右上角添加用户名字
        	 var storage=window.localStorage;            
             $("#staff-name").html(storage["staffname"]);
        	//设置提示框的属性
        	toastr.options.timeOut = 1300;
        	toastr.options.positionClass = 'toast-top-center';
        	toastr.options.preventDuplicates = true;         	
        	//初始化表格
            $.ajax({
                    type:"get",
                    url:"/plantSCM/GetPhone",////////////////////////////////改成获取电话号码的函数
                    dataType:"json",
                    success:function(data){             	
                    	for(i in data.result) 
        	            {
                    		datas[i]={"id":data.result[i].id,"role":data.result[i].role,"phone":data.result[i].phone};
        	               //datas[i]={"outModel":data.result[i]};
        	              //console.log(datas[i]);
        	            }
                        		
            $("#example-table").tabulator({
            	
        	    layout:"fitColumns", 
        	    columns:[ 
        	    	{formatter:"rownum", align:"center", width:40},	 
        	    	{title:"ID",field:"id", align:"center",editor:false,visible:false},
        	        {title:"角色", field:"role", align:"center",editor:"select",editorParams:{"仓库":"仓库","工厂":"工厂","商务":"商务","领导":"领导"},headerSort:false,widthGrow:1,},
        	        {title:"电话号码",field:"phone",align:"center",editor:true,headerSort:false,widthGrow:1,},
        	        {title:"操作",field:"operation",formatter:AddFunctionAlty,align:"center",headerSort:false,editor:false,widthGrow:1,cellClick:function (e, cell){	        		        		        		             	
        	              	var temp = {
        	              			id:cell.getRow().getCells()[1].getValue()
        	              			//role:cell.getRow().getCells()[2].getValue(),
        	              			//phone:cell.getRow().getCells()[3].getValue()
        	                        //outModel:cell.getRow().getCells()[1].getValue()	                                   
        	                    };
        	              	//console.log(temp);
        	            	$.ajax({
        	                    type:"POST",
        	                    url:"/plantSCM/DeletePhone",///////////////改成删除电话记录的函数
        	                    data:temp,
        	                    dataType:"json",
        	                    success:function(data){
        	                    	
        	                    	if(data.code==0){
        	                    		cell.getRow().delete();    
        	                    		toastr.success(data.msg);
        	                    	}
        	                    	else{
        	                    		var msg=data.msg;
        	                    		toastr.error(msg);
        	                
        	                    	}
        	                        	              
        	                    },
        	          	       error : function(err){
        	          	    	toastr.error('发生错误');
        	                     }
        	                });		   	
        	        	}}
        	        
        	    ],
        	   
           
        	
        	});                   	
        	$("#add-row").click(function(){
        		$("#example-table").tabulator("addRow", {});
        		});	
        	$("#example-table").tabulator("setData", datas);
        	
                    }    
           });
        	
            });
            
            function AddFunctionAlty(value,row,index){
         	   return ['<button id="TableEditor" type="button" class="btn btn-default">删除</button>&nbsp;&nbsp;' ,
         		
         		   ].join("")
            }
            
            function getHtml(){
            	
            }
            //提交
            function add(){
            	
            	var data = $("#example-table").tabulator("getData");    	
            	var phone=[];
            	var k=true;
            	
            	for(var i=0;i<data.length;i++){
            		if(rowIsNull(i)){
            			continue;
            		}
            		if(isNull(data[i].role)){
            			k = false;
            			toastr.info("请选择角色");
            			break;
            		}
            		if(!isValid(data[i].phone)){
            		    k = false;
            			toastr.info("请输入11位正确电话号码");
            			break;		
            		}
            		phone.push(data[i]);
            		  		    		
            	}    
            	if(k==true && phone.length==0){
            		toastr.info("请输入至少一条记录");
            		k=false;
            	}
            	if(phone.length>=1 && k==true){    		
               	 $.ajax({
                        type:"POST",
                        url:"/plantSCM/SetPhone",///////////////////改成增加电话号码的函数
                        contentType:"application/json;charset=UTF-8",
                        data:JSON.stringify(phone),//将 JavaScript 值转换为 JSON 字符串
                        dataType:"json",
                        
               	success:function(data){
                	
                	if(data.code==0){
                		toastr.success(data.msg); 
                    	//setTimeout("window.location.href='http://localhost:8080/plantSCM/view/system_model.jsp'",1000);
                		setTimeout(function(){window.location.href = path+"system_phone.jsp";  },1500);
                	}
                	else{
                		var msg=data.msg;
                		toastr.error(msg);
                		setTimeout(function(){window.location.href = path+"system_phone.jsp";  },1500);
                	}
                    	              
                },
        	       error : function(err){
        	    	toastr.error('发生错误');
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
        function clickphone_shezhi(){
        	window.location.href = path+"system_phone.jsp";
        }
        function clickmodel_shezhi(){
        	window.location.href = path+"system_model.jsp";
        }
        function clickinform(){
        	window.location.href = path+"system_inform.jsp";
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
                   <div class="col-sm-7">
                       <table id="example-table"></table>
                       <button id="add-row" style="width:60px" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span></button>
                       </div>
                   </div>                
               </div></br>
			    <div class="col-xs-4 col-md-4">
                            <button id="searchbutton" style="width:60px" type="button" class="btn btn-primary" onclick=add()>增加</button>
                     </div>
      </div>
      </div>
   </div>
</body>
</html>