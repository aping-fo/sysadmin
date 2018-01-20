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

  <title>增加代理</title>

  <link href="${BASE_PATH}/css/style.css" rel="stylesheet">
  <link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet">

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
                	我的代理
            </h3>
            <ul class="breadcrumb">
                <li class="active">添加代理</li>
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
                	添加一个新代理
            </header>
            <div class="panel-body">
                <form id="agentAddForm" class="form-horizontal adminex-form" method="post">
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理姓名</label>
                        <div class="col-sm-10">
                        	<input type="text" name="agent.Name" value="${subordinateAgent.Phone}" placeholder="请输入代理姓名"  class="form-control" />
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理级别</label>
                        <div class="col-sm-10">
                       		<select id = "AgentLevel" class="form-control m-bot15" name="agent.AgentLevel" >
                                	<option value="">选择代理级别</option>
                                <c:forEach var="item" items="${agentLevelList}" varStatus="status">
								    <c:if test="${item.PropertyValue > agent.AgentLevel}">
									  <option value="${item.PropertyValue}">${item.PropertyName}</option>
									</c:if>
								</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理手机号</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.Phone" placeholder="请输入代理手机号"  class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理帐号密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="agent.Password" id="password"  class="form-control" placeholder="请输入代理密码" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="confirmpassword"  class="form-control" placeholder="请输入再次输入代理密码" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理QQ号</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.QQ"  placeholder="请输入代理QQ号" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理下级代理数量上限</label>
                        <div class="col-sm-10"> 
                            <input type="text" id="MaxAgentCount" name="agent.MaxAgentCount"  placeholder="请输入最大代理数量" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 col-sm-2 control-label">上级代理ID</label>
                        <div class="col-lg-10">
                            <p class="form-control-static">${agent.ID}</p>
                             <input type="hidden" name="agent.ParentId" value="${agent.ID}"  class="form-control" />
                        </div>
                    </div>
                    <div class="form-group text-center">
							<button class="btn btn-primary" type="submit">确定添加 </button>
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
<!--common scripts for all pages-->
<script src="${BASE_PATH}/js/scripts.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			$("#AgentLevel").blur(function(){
				$("#MaxAgentCount").val("");
				var agentLevel =  $("#AgentLevel").val();
				if(agentLevel==1){
					$("#MaxAgentCount").removeAttr("disabled");
					$("#MaxAgentCount").val("100");
				}else if (agentLevel==2){
					$("#MaxAgentCount").removeAttr("disabled");
					$("#MaxAgentCount").val("50");
				}else if (agentLevel==3){
					$("#MaxAgentCount").attr("disabled","disabled");
					$("#MaxAgentCount").val("0");
				}else{
					$("#MaxAgentCount").val("0");
				}
			})
		})
	
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
				layer.msg("创建成功", {
					time : 2000
				}, function() {
					window.location.href = "${BASE_PATH}/agent/agentAuditing";
				});
			} else {
				layer.msg(data.errorMsg);
			}
		}

		// 验证表单
		$(document).ready(
				function() {
					$("#agentAddForm").validate(
							{
								submitHandler : function() {
									layer.confirm('是否确定添加么?', {
				          				  btn: ['确定', '在想想'], //可以无限个按钮
				          				  title: "提示",
				          				}, function(index, layero){
											submitForm("#agentAddForm","${BASE_PATH}/agent/agentAdd",submitResult);
				          				}, function(index){
				          				  // 无操作
				          				});
								},
								rules : {
									"agent.Name" : {
										required : true
									},
									"agent.AgentLevel" : {
										required : true
									},
									"agent.Phone" : {
										required : true,
										isMobile : true
									},
									"agent.Password" : {
										required : true,
										minlength : 6,
										maxlength : 16
									},
									confirmpassword : {
										required : true,
										equalTo : "#password"
									},
									"agent.QQ" : {
										required : true,
										digits : true,
										minlength : 5,
										maxlength : 10
									},
									"agent.MaxAgentCount" : {
										digits : true
									}
								},
								messages : {
									"agent.Name" : {
										required : "请输入代理姓名"
									},
									"agent.AgentLevel" : {
										required : "请选择代理"
									},
									"agent.Phone" : {
										required : "请输入手机号",
										isMobile : "手机号格式不正确"
									},
									"agent.Password" : {
										required : "请输入密码",
										minlength : "密码至少是6位数",
										maxlength : "密码最多是16位"
									},
									confirmpassword : {
										required : "请输入确认密码",
										equalTo : "确认密码和原密码不一致"
									},
									"agent.QQ" : {
										required : "请输入联系QQ",
										digits : "QQ格式不正确",
										minlength : "QQ至少是5位数",
										maxlength : "QQ最多10位"
									},
									"agent.MaxAgentCount" : {
										digits : "必须是纯数字"
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
