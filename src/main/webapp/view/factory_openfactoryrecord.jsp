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
    <script src="/plantSCM/js/bootstrap-table.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="/plantSCM/css/bootstrap-table.min.css"  /> 
    <script src="/plantSCM/js/bootstrap-table-zh-CN.min.js" charset="utf-8"></script>
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
        	//设置选择型号框的属性
        	 $('#select1').selectpicker({
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
            //点击编辑按钮触发以下事件，delegate修复了翻页后按钮无效的问题
             $("body").on('click','#tb_departments tr .edit1', function () {           	
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
                  $(this).parent().parent().children(".model").each(function(){  
    				
						var oldtext=$(this).text();
						$(this).html("<select id='select8'></select>");  
						getModelTable(oldtext);
						
    		       });				   
    				  $(this).parent().parent().children(".editable").each(function(){  
    				   var k=this.clientWidth;    				 
    		           var value = $(this).text();    		        
    		          $(this).html("<input type='text' style='width:"+k+"px;' value='"+value+"'>");
    		       });
             });            
        }); 
        //获取产品型号
        function getModel(){
        	$.ajax({
                type:"GET",
                url:"/plantSCM/OpenFactory/getModel",//后台
                success:function(data){
                	if(data.code==0){
                		result=data.result;
                		for(var i=0;i<result.length;i++){
                   		 var text=result[i];
                   		 var value=i+2;
                   		 $("#select1").append("<option value='"+value+"'>"+text+"</option>");
                   	     }
                   	     $('#select1').selectpicker('refresh');
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
                   model:$("#select1").find("option:selected").text()
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
                  url:"/plantSCM/OpenFactory/getOpenFactory",
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
                   model:$("#select1").find("option:selected").text()
                };
        	$.ajax({
                type:"GET",
                url:"/plantSCM/OpenFactory/getOpenFactory",
                data:temp,
                dataType:"json",
                success:function(data){                	
                	if(data.code==0){
                		result=data.result;                		
                	     $('#tb_departments').bootstrapTable({                           
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
                             columns: [                    	
                             	 {
                                title: '',
                                formatter: function (value, row, index) {
                                return index+1;
                                 }
                               },
                             {
                                 field: 'openDate',
                                 title: '开炉日期',
                                 class: 'timeeditable',
                                 sortable : true,
                                
                             }, {
                                 field: 'model',
                                 title: '产品型号',
                                 class: 'model',
                                 sortable : true
                             }, {
                                 field: 'agWeight',
                                 title: '银',
                                 class: 'editable',
                                 sortable : true,
                                
                             }, {
                                 field: 'cuWeight',
                                 title: '铜',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'znWeight',
                                 title: '锌',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'cdWeight',
                                 title: '镉',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'snWeight',
                                 title: '锡',
                                 class: 'editable',
                                 sortable : true
                             } , {
                                 field: 'wasteWeight',
                                 title: '废料',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'batchYlWeight',
                                 title: '消耗总量',
                                 //class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'batchBlanksWeight',
                                 title: '胚料产出',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'fireNumber',
                                 title: '炉数',
                                 class: 'editable',
                                 sortable : true
                             }, {
                                 field: 'averageConsume',
                                 title: '每炉平均损耗',                                 
                                 sortable : true
                             },{
                                 field: 'proportion',
                                 title: '总产出比',                                
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
    	   return ['<button id="TableEditor" type="button" class="edit1 btn btn-default btn-xs edit  " delsong="1">编辑</button>&nbsp;',
    		   '<button id="TableSave" type="button" class="btn btn disabled btn-xs save" disabled="disabled">保存</button>&nbsp;',
    		   '<button id="Tablequxiao" type="button" class="btn btn-default btn-xs quxiao">取消</button>',
    		   
    		   ].join("")
       }

       //按钮的事件 编辑以及保存
       window.operateEvents={
		   "click #TableEditor":function(e,value,row,index){	
		   },
		   "click #TableSave":function(e,value,row,index){
			     $("body").one('click','#tb_departments tr .save', function () {
	            	var obj =$(this).parent().parent().children(".editable");
	  			    var obj2 = $(this).parent().parent().children(".timeeditable");
					var obj3=$(this).parent().parent().children(".model");
	  			    var open_date = obj2.first().find("input").val();	            	
	            	 var model=obj3.first().find("option:selected").text();    
	            	 var ag_weight = obj.eq(0).find("input").val();
	            	 var cu_weight = obj.eq(1).find("input").val();
		  		     var zn_weight=obj.eq(2).find("input").val();
		  			 var cd_weight=obj.eq(3).find("input").val();
		  			 var sn_weight=obj.eq(4).find("input").val();
		  			 var waste_weight=obj.eq(5).find("input").val();
		  			 var batch_blanks_weight=obj.eq(6).find("input").val();
		  			 var fire_number=obj.eq(7).find("input").val();
	  			    var newData = {
	  			    		    id:row.id,
	  				    		openDate: open_date,
	  				    		model: model,
	  				    		agWeight:Number(ag_weight),
	  				    		cuWeight:Number(cu_weight),
	  				    		znWeight:Number(zn_weight),
	  				    		cdWeight:Number(cd_weight),
	  				    		snWeight:Number(sn_weight),
	  				    		wasteWeight:Number(waste_weight),
	  				    		batchBlanksWeight:Number(batch_blanks_weight),
	  				    		fireNumber:fire_number
			    		
	  				    };
						
	  			  //如果输入合法则发送请求到后台修改数据
	  			  if(isValid(newData)){	 
	                newData["fire_number"]=Number(newData["fire_number"]);
				    newData.batchYlWeight=newData.agWeight+newData.cuWeight+newData.znWeight+newData.cdWeight+newData.snWeight+newData.wasteWeight;
					if(newData.batchYlWeight==0){
					     toastr.info('消耗总量不能为0');
					}else{
					   newData.averageConsume=parseFloat(((newData.batchYlWeight-newData.batchBlanksWeight)/newData.fireNumber).toFixed(3));
    			       newData.proportion=parseFloat((newData.batchBlanksWeight/newData.batchYlWeight).toFixed(3));
					   			//给后台发送ajax请求，修改数据
	  				  $.ajax({
		                      type:"POST",
		                      url:"/plantSCM/OpenFactory/modifyOpenFactory",
		                      contentType:"application/json;charset=UTF-8",
		                      data:JSON.stringify(newData),
		                      dataType:"json",
		                      success:function(data){  	        	          
		                      if(data.code==0){							   
		                      $("#tb_departments").bootstrapTable('updateRow', {
		      				        index: index,
		      				        row: newData
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
		                    	   $("#tb_departments").bootstrapTable('updateRow', {
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
					   
					}											  	 			
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
			if(newData["openDate"]==""){
			   toastr.info("日期不能为空");
			   return false;
			}
			if(newData["model"]==""){
			   toastr.info("型号不能为空");
			   return false;
			}
			if(!isThreeFloat(newData["agWeight"])){
			   toastr.info("银重量为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["cuWeight"])){
			   toastr.info("铜重量为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["znWeight"])){
			   toastr.info("锌重量为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["cdWeight"])){
			   toastr.info("镉重量为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["snWeight"])){
			   toastr.info("锡重量为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["wasteWeight"])){
			   toastr.info("废料为不超三位小数的数");
			   return false;
			}
			if(!isThreeFloat(newData["batchBlanksWeight"])){
			   toastr.info("胚料产出总量为不超三位小数的数");
			   return false;
			}
			if(!isInteger(newData["fireNumber"])){
			   toastr.info("炉数应为正整数");
			   return false;
			}		   
		   return true;
        }      
	   //判断为正整数
	   function isInteger(s){  
	   var re = /^[0-9]*[1-9][0-9]*$/ ;
        return re.test(s);
       }
       //验证某一个数字是否是不超过三位的小数
        function isThreeFloat2(data){       	
       	if(isNaN(data)){
       		return false;
       	}
       	else{
       		data=data+"";
       	}
           if(data.split('.').length > 1 && data.split('.')[1].length>3){
           	
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
			    if(data<0){
        		return false;
        	     }
        		data=data+"";
        	}
            if(data.split('.').length > 1 && data.split('.')[1].length>3){
            	
                return false;
            }
        	return true;
        }
		 //验证某一个数字是否是不超过三位的正小数
        function isThreeFloat2(data){
        	
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
        function addnewfactory(){
        	window.location.href = path+"factory_newfactory.jsp";
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
                 <div style="white-space:pre;float:left;">  产品型号</div>
                 <div style="float:left;">
                        <select id="select1" class="selectpicker" data-live-search="true" data-live-search-placeholder="搜索" data-width="100px">                             
                            <option value="1">全部</option>                                                            
                        </select>
                 </div> 
                 <div style="float:left;">
                        &nbsp;
                        <button id="searchbutton"  type="button" class="btn btn-primary"  onclick="search()">搜索</button>
                         &nbsp;
                        <button id="newfactorybutton"  type="button" class="btn btn-primary"  onclick="addnewfactory()">新增开炉登记</button>
                 </div>                                                          
               </div>       
               <div class="row">
                  <div class="panel-body" style="padding-bottom:0px;">
                       <table id="tb_departments"></table>
                   </div>
               </div>
      </div>
      </div>
   </div>
</body>
</html>