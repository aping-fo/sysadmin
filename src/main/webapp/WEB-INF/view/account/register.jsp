<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="description" content="" />
<meta name="author" content="ThemeBucket" />
<link rel="shortcut icon" href="favicon.ico" type="image/png" />

<title>注册</title>

<link href="${BASE_PATH}/css/style.css" rel="stylesheet" />
<link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet" />

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="${BASE_PATH}/js/html5shiv.js"></script>
    <script src="${BASE_PATH}/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-body">

	<div class="container">

		<form class="form-signin" method="post" id="registerForm" action="">
			<div class="form-signin-heading text-center">
				<h1 class="sign-title"><b>营口麻将</b></h1>
				<!--<img src="images/login-logo.png" alt=""/>-->
			</div>
			<div class="login-wrap">
				<ul id="myTab" class="nav nav-tabs" style="margin-bottom: 20px;">
					<li class="active"><a href="#personal" data-toggle="tab">
							代理注册 </a></li>
				</ul>
				<p><b>请输入个人信息</b></p>
				<input type="text" name="phone" placeholder="手机号码" class="form-control" maxlength="11" />
					<input type="password" name="password" placeholder="密码" class="form-control" id="password" maxlength="16" /> 
					<input type="password" name="confirmpassword" placeholder="确认密码" class="form-control" maxlength="16" /> 
					<input type="text" name="name" placeholder="代理姓名" class="form-control" maxlength="8" /> 
					<input type="text" name="qq" placeholder="联系QQ" class="form-control" maxlength="11" /> 
					<input type="hidden" name="agentLevel" value="3" /> 
					<input type="text" value="默认代理级别" class="form-control" maxlength="11" disabled/> 
				<button type="submit" class="btn btn-lg btn-login btn-block" />
				<!-- <i class="fa fa-check"></i> -->
				<span>提交</span>
				</button>
				<div class="registration">
					已注册 ?<a href="login" class=""> 登录 </a>
				</div>
			</div>
		</form>
	</div>


<jsp:include page="../frame/foot.jsp"></jsp:include>
	<!-- Placed js at the end of the document so the pages load faster -->

	<!-- Placed js at the end of the document so the pages load faster -->
	<script src="${BASE_PATH}/js/jquery-1.10.2.min.js"></script>
	<script src="${BASE_PATH}/js/bootstrap.min.js"></script>
	<script src="${BASE_PATH}/js/modernizr.min.js"></script>
	<script src="${BASE_PATH}/js/layer/layer.js"></script>
	<script src="${BASE_PATH}/js/jquery.validate.js"></script>
	<script src="${BASE_PATH}/js/common.js"></script>
	<script>
		//添加手机号验证
		jQuery.validator.addMethod("isMobile", function(value, element) {
			var length = value.length;
			var mobile = /^1\d{10}$/;
			return this.optional(element)
					|| (length == 11 && mobile.test(value));
		}, "请正确填写您的手机号码");

		// ajax提交表单回调
		function submitResult(data) {
			if (data.success == true) {
				layer.msg("恭喜您，注册成功!", {
					time : 2000
				}, function() {
					window.location.href = "${BASE_PATH}/login";
				});
			} else {
				layer.msg(data.errorMsg);
			}
		}

		// 验证表单
		$(document).ready(
				function() {
					$("#registerForm").validate(
							{
								submitHandler : function() {
									submitForm("#registerForm",
											"${BASE_PATH}/registerAction",
											submitResult);
								},
								rules : {
									phone : {
										required : true,
										isMobile : true
									},
									password : {
										required : true,
										minlength : 5
									},
									confirmpassword : {
										required : true,
										equalTo : "#password"
									},
									name : {
										required : true
									},
									qq : {
										required : true,
										digits : true,
										minlength : 5
									},
									agentLevel : {
										required : true
									}
								},
								messages : {
									phone : {
										required : "请输入手机号",
										isMobile : "手机号格式不正确"
									},
									password : {
										required : "请输入密码",
										minlength : "密码至少是6位"
									},
									confirmpassword : {
										required : "请输入确认密码",
										equalTo : "确认密码和原密码不一致"
									},
									name : {
										required : "请输入代理姓名"
									},
									qq : {
										required : "请输入联系QQ",
										digits : "QQ格式不正确",
										minlength : "QQ至少是5位数"
									},
									agentLevel : {
										required : "请选择代理"
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
