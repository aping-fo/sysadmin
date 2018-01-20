<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="ThemeBucket">
  <link rel="shortcut icon" href="${BASE_PATH}/favicon.ico" type="image/png" />

  <title>游戏系统管理</title>

  <link href="${BASE_PATH}/css/style.css" rel="stylesheet">
  <link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet">
  
  <!--pickers css-->
	<link rel="stylesheet" type="text/css" href="${BASE_PATH}/js/bootstrap-datetimepicker/css/datetimepicker-custom.css" />	

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
  
</head>

<body class="sticky-header">

<section>
    <!-- left side start-->
    <jsp:include page="../frame/menu.jsp"></jsp:include>
    <!-- left side end-->
    
    <!-- main content start-->
    <div class="main-content" >

        <!-- header section start-->
        <jsp:include page="../frame/top.jsp"></jsp:include>
        <!-- header section end-->

        <!-- page heading start-->
        <div class="page-heading">
            <h3>
                	游戏系统管理
            </h3>
            <ul class="breadcrumb">
                <li class="active">游戏公告</li>
            </ul>
        </div>
        <!-- page heading end-->

        <!--body wrapper start-->
        <section class="wrapper">
        <!-- page start-->

        <div class="row">
        <div class="col-lg-12">
        <section class="panel">
            <header class="panel-heading">
					发布游戏公告(系统、滚动、大厅、充值公告)
            </header>
            <div class="panel-body">
                <form method="post" id = "AfficheForm" class="form-horizontal bucket-form">
              		 <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">公告类型</label>
                        <div class="col-sm-10">
                       		<select id = "state" class="form-control m-bot15" name="state" >
                               	<option value="">选择公告类型</option>
                                <c:forEach var="item" items="${announcementList}" varStatus="status">
								    <c:if test="${item.PropertyValue > 0}">
									  <option value="${item.PropertyValue}">${item.PropertyName}</option>
									</c:if>
								</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
						<label class="col-sm-2 col-sm-2 control-label">发布时间</label>
                            <div class="col-md-10">
                            <input size="16" type="text" id="startTime" name="startTime" readonly class="form_datetime form-control" />
                        	</div>
					</div>
                    <div class="form-group">
                    	<label class="col-sm-2 col-sm-2 control-label">公告标题</label>
                    	<div class="col-md-10">
                    		<input maxlength="20" type="text" id="title" placeholder="请输入公告标题，长度限制二十字" name="title" class="form-control" />
                    	</div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">发布内容</label>
                        <div class="col-sm-10">
                            <textarea id = "content" placeholder="请输入公告内容，内容限制五十字" name="content" 
                            		  rows="5" onkeyup="changeInfo()" maxlength="50" class="form-control"></textarea>
                            <span id="count" >0/50</span>
                        </div>
                    </div>
					<div class="form-group text-center">
						<button class="btn btn-primary" type="submit">发布公告</button>
					</div>
                </form>
            </div>
        </section>
        </div>
        </div>
        <!-- page end-->
        </section>
        <!--body wrapper end-->

		<!--footer section start-->
        <jsp:include page="../frame/foot.jsp"></jsp:include>
        <!--footer section end-->
    </div>
    <!-- main content end-->
</section>

	<!-- Placed js at the end of the document so the pages load faster -->
	<script src="${BASE_PATH}/js/jquery-1.10.2.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${BASE_PATH}/js/bootstrap.min.js"></script>
	<script src="${BASE_PATH}/js/modernizr.min.js"></script>
	<script src="${BASE_PATH}/js/jquery.nicescroll.js"></script>
	<script src="${BASE_PATH}/js/layer/layer.js"></script>
	<script src="${BASE_PATH}/js/laypage/laypage.js"></script>
	<script src="${BASE_PATH}/js/jquery.validate.js"></script>
	<script src="${BASE_PATH}/js/common.js"></script>

	<!--pickers plugins-->
	<script type="text/javascript" src="${BASE_PATH}/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="${BASE_PATH}/js/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript" src="${BASE_PATH}/js/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<!--pickers initialization-->
	<script src="${BASE_PATH}/js/pickers-init.js"></script>
	<!--pickers initialization-->
	<!--common scripts for all pages-->
	<script src="${BASE_PATH}/js/scripts.js"></script>

	
	<script type="text/javascript">
		//获取键盘输入的字数，动态改变
		function changeInfo(){
			document.getElementById("count").innerHTML=document.getElementById("AdvertisingContent").value.length+"/50";
		}
		$("#AdvertisingContent").keyup(function(){
			if($("#AdvertisingContent").val().length>50){
			layer.msg("字数超过限制")
		}
		});
		//获取前时间	
		$(function(){
		        var date = new Date();
		        var seperator1 = "-";
		        var seperator2 = ":";
		        var year = date.getFullYear(); 
		        var month = date.getMonth() + 1;
		        var strDate = date.getDate();
		        var minutes = date.getMinutes();//分钟
		        if (month >= 1 && month <= 9) {
		            month = "0" + month;
		        }
		        if (strDate >= 0 && strDate <= 9) {
		            strDate = "0" + strDate;
		        }
		        if(minutes >=0 && minutes <=9){
		        	minutes = "0" + minutes;
		        }
		        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
		        + " " + (date.getHours()+1) + seperator2 + "00";
			    $("#startTime").val(currentdate);
			});
		
		// ajax提交表单回调
		function submitResult(data) {
			//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
			if (data.success == true) {
				layer.msg("发布成功", {
					time : 2000
				}, function() {
					window.location.href = "${BASE_PATH}/gameManage/gameAfficheUI";
				});
			} else {
				layer.msg(data.errorMsg);
			}
		}
		
		// 验证表单
		$(document).ready(
				function() {
					$("#AfficheForm").validate(
					{
						submitHandler : function() {
							submitForm("#AfficheForm","${BASE_PATH}/gameManage/advertiseAffiche",submitResult);
						},
						rules : {
							state : {
								required : true
							},
							startTime : {
								required : true
							},
							title : {
								required : true
							},
							content : {
								required : true
							}
						},
						messages : {
							state : {
								required : "输入公告类型"
							},
							startTime : {
								required : "请输入一个发布时间"
							},
							title : {
								required : "请输入公告标题"
							},
							content : {
								required : "请输入公告内容"
							}
						},
						errorElement : "em",
						//重写showErrors
						showErrors : function(errorMap, errorList) {
							$.each(errorList, function(i, v) {
								tips(v.message, v.element);
								return false;
							});
						},
						onsubmit : true,
						onfocusout : false,
						onkeyup : false,
						onclick : false
					});
				});
	</script>
</body>
</html>
