<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <meta name="description" content=""/>
    <meta name="author" content="ThemeBucket"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/png" />

    <title>登录</title>

    <link href="${BASE_PATH}/css/style.css" rel="stylesheet"/>
    <link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="${BASE_PATH}/js/html5shiv.js"></script>
    <script src="${BASE_PATH}/js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-body">
<div class="container">

    <form class="form-signin" method="post" id="loginForm">
        <div class="form-signin-heading text-center">
            <h1 class="sign-title"><b>营口麻将</b><sup>2017</sup></h1>
        </div>
        <div class="login-wrap">
        	<ul id="myTab" class="nav nav-tabs" style="margin-bottom: 20px;">
					<li class="active"><a href="#personal" data-toggle="tab">
							代理登录 </a></li>
				</ul>
        	
			<input type="text" class="form-control" name="phone" placeholder="手机号" />
			<input type="password" class="form-control" name="password" placeholder="密码"/>
			<div class="row">
					<div class="col-sm-6">
						<input type="text" id="code" class="form-control" name="verifyCode"
							maxlength="4" placeholder="请输入验证码">
					</div>
					<div class="col-sm-6 text-center">
						<img style='cursor:pointer' src="${BASE_PATH}/verifyCode?date="+ (new Date()).getTime()
							onclick="this.src='${BASE_PATH}/verifyCode?date='+new Date().getTime()"
							id="verifyCode" alt="点击更换验证码" />
					</div>
				</div>
			
            <button class="btn btn-lg btn-login btn-block" type="submit"/>
               <!--  <i class="fa fa-check"> -->
                	<span>登录</span>
                <!-- </i> -->
            </button>
            <div class="registration">
                没有帐号?
                <a class="" href="register">
                    注册
                </a>
            </div>
            <label class="checkbox">
                <input style='cursor:pointer' type="checkbox" value="remember-me"> 记住帐号
                <span class="pull-right">
                    <a data-toggle="modal" href="#myModal">忘记密码?</a>

                </span>
            </label>

        </div>
    </form>
        <!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">忘记密码 ?</h4>
                    </div>
                    <div class="modal-body">
                        <b><p>请联系你的上级代理以便重置密码 .</p></b>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">我知道了</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal -->
</div>
<jsp:include page="../frame/foot.jsp"></jsp:include>

<!-- Placed js at the end of the document so the pages load faster -->

<!-- Placed js at the end of the document so the pages load faster -->
<script src="${BASE_PATH}/js/jquery.min.js"></script>
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
    function submitResult(data){
    	//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
        if(data.success == true){
              window.location.href = "${BASE_PATH}/frame";
        }else{
			$("#code").val("");
        	layer.msg(data.errorMsg);
			$("#verifyCode").attr("src","${BASE_PATH}/verifyCode?date="+ new Date().getTime());
        }
    }
    
    // 验证表单
    $(document).ready(
            function() {
                $("#loginForm").validate({
                    submitHandler : function() {
                    	layer.msg('登陆中', {
                    		  icon: 16
                    		  ,shade: 0.01
                    		});
                        submitForm("#loginForm", "${BASE_PATH}/loginAction", submitResult);
                    },
                    rules : {
                        phone : {
                            required : true,
                            isMobile : true
                        },
                        password : {
                            required : true
                        },
    					verifyCode : {
    						required : true
    					}
                    },
                    messages : {
                        phone : {
                            required : "请输入手机号",
                            isMobile : "手机号格式不正确"
                        },
                        password : {
                            required : "请输入密码"
                        },
    					verifyCode : {
    						required : "请输入验证码"
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
