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
    <script src="../js/path.js"></script>
    <script>
   
	//在右上角添加用户名字
        	 var storage=window.localStorage;            
             $("#staff-name").html(storage["staffname"]);
        	//设置提示框的属性
        	toastr.options.timeOut = 1300;
        	toastr.options.positionClass = 'toast-top-center';
        	toastr.options.preventDuplicates = true;
    var datas  = [];
    $(function (){
    	$.ajax({
            type:"get",
            url:"/plantSCM/WarehouseInventory/getHjInventoryRecord",
            dataType:"json",
            success:function(data){  
            	for(i in data.result) 
	            {
	               datas[i]={"number":data.result[i].hjkcId,"hjType":data.result[i].hjType,"hjFactory":data.result[i].hjFactory,"hjActualNumber":data.result[i].hjActualNumber};
	              
	            }

            	
  
    	
    	$('#tabletest').bootstrapTable({
    	
 	        type:'get',
 	        
			cache: false,
			height: 400,
			striped: true,
			//pagination: true,
			pageSize: 10,
			pageNumber:1,
			pageList: [10, 20, 50, 100],
			search: true,
			//showColumns: true,
			//showRefresh: false,
			//showExport: false,
			//exportTypes: ['csv','txt','xml'],
			//search: true,
			clickToSelect: true,
			maintainSelected : true,
			sidePagination: "client",  
			//分页方式：client客户端分页，server服务端分页（*）
			uniqueId: "id",  
			columns: 
			[
			    {checkbox: true},
			    {
                    title: '编号',
                    formatter: function (value, row, index) {
                    return index+1;
                     }
                   },
				{field:"hjType",title:"种类",align:"center",valign:"middle"},
				{field:"hjFactory",title:"厂家",align:"center",valign:"middle"},
				{field:"hjActualNumber",title:"应存数量",align:"center",valign:"middle"},
			
			],
			
			data:datas,
		});	
 	       
    }    
    });
    })
    	
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
     function logoff(){
      	  localStorage.clear();
      	  window.location.href='logoff';
        }
    
    function printrecord(){
    	var printdata=$('#tabletest').bootstrapTable('getAllSelections');
    	
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
              
             {
                 field: 'hjType',
                 title: '种类',                                        
                
             }, {
                 field: 'hjFactory',
                 title: '厂家', 
             },  {
                 field: 'hjActualNumber',
                 title: '实际存量',
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
            <li>
            <!-- <a  href="javascript:void(0);" onclick="clicksonghuo()"> -->
            <a href="#systemSetting1" class="nav-header collapsed" data-toggle="collapse"  >
            <i class="glyphicon glyphicon-edit"></i>
                                   送货管理                    
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>                               
            </a>
            <ul id="systemSetting1" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li><a href="javascript:void(0)" onclick="clicksonghuomanage()"><i></i>送货管理</a></li>
            <li><a href="javascript:void(0)" onclick="clickstatistics()"><i></i>送货统计</a></li>
            </ul>
            </li>
            <li>
            <a href="#systemSetting2" class="nav-header collapsed" data-toggle="collapse" >            
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
            <a href="#systemSetting3" class="nav-header collapsed" data-toggle="collapse" >
            <i class="glyphicon glyphicon-edit"></i>
                                         库存管理
            <span class="pull-right glyphicon glyphicon-chevron-down"></span>
            </a>
            <ul id="systemSetting3" class="nav nav-list collapse secondmenu" style="height: 0px;">
            <li><a href="javascript:void(0)" onclick="clickhpinventory()">焊片库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhjinventory()">焊剂库存</a></li>
            <li><a href="javascript:void(0)" onclick="clickhpprint()">焊片打印</a></li>
            <li style="background-color:#F0FFFF;"><a href="javascript:void(0)" onclick="clickhjprint()">焊剂打印</a></li>
            </ul>
            </li>
                      
            </ul>
            </div>
             <!--垂直导航栏结束-->
        
           <div class="col-xs-11 col-md-11">
                    <div class="row">
                  
                       
                       <div class="col-xs-8 col-md-8">      
                           <table class="table table-bordered" id='tabletest'>
                            <tr>
                                <th>编号</th>
                                 <th>种类</th>
                                 <th>厂家</th>
                                 <th>应存数量</th>
                                 <th>操作</th>
                                 
                           </tr>
                         </table>    
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
               <div class="row">
                   <div class="panel-body" style="padding-bottom:0px;">                                     
                    
                         <button id="printbutton"  type="button" class="btn btn-primary"  onclick="printrecord()">打印</button>
                  </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>