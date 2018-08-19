<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>未授权</title>
<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">  
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<style type="text/css">
.main{
    text-align: center; /*让div内部文字居中*/
    background-color: #FAEBD7;
    border-radius: 20px;
    width: 300px;
    height: 150px;
    margin: auto;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
}

</style>
</head>
<body style="background-color:#C0C0C0;">
    <div class="main">
        <h2 style="font-family:verdana;color:red;font-size:30px;">未授权,不能访问</h2>
		<br/>
		<p onclick="javascript:history.go(-1)"><button class="btn btn-warning">点击返回上一页</button> </p>
    </div>
</body>
</html>