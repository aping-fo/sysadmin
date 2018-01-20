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

  <title>未审核代理编辑</title>

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
                	未审核代理
            </h3>
            <ul class="breadcrumb">
                <li class="active">编辑代理</li>
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
                	代理信息
            </header>
            <div class="panel-body">
                <form id="agentForm" class="form-horizontal adminex-form" action="" method="post">
                	<div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理ID</label>
                        <div class="col-sm-10">
                        	<p class="form-control-static">${subordinateAgent.ID}</p>
                            <input class="form-control" name="agent.ID" id="disabledInput" type="hidden" value="${subordinateAgent.ID }" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理姓名</label>
                        <div class="col-sm-10">
                        	<p class="form-control-static">${subordinateAgent.Name}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理级别</label>
                        <div class="col-sm-10">
                       		<select class="form-control tooltips input-sm m-bot15" data-original-title="修改审核代理级别" name="agent.AgentLevel" >
                               	<option value="">选择审核代理级别</option>
                                <c:forEach var="item" items="${agentLevelList}"  varStatus="status">
                                	<c:if test="${item.PropertyValue > 0 }">
									  	<option value="${item.PropertyValue}"  <c:if test="${item.PropertyValue == subordinateAgent.AgentLevel}">selected</c:if> >${item.PropertyName}</option>
								  	</c:if>
								</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理手机号</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.Phone" value="${subordinateAgent.Phone}" placeholder="请输入代理手机号" data-original-title="修改代理登录帐号" class="form-control tooltips" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理帐号密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="agent.Password"  class="form-control tooltips" placeholder="默认密码" data-original-title="修改代理密码" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理QQ号</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.QQ" value="${subordinateAgent.QQ}" placeholder="请输入代理QQ号" data-original-title="修改代理QQ"  class="form-control tooltips" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">代理下级代理数量上限</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.MaxAgentCount" value="${subordinateAgent.MaxAgentCount}" placeholder="请输入最大代理数量" data-original-title="修改代理的下级代理数量上限" class="form-control tooltips" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 col-sm-2 control-label">上级代理ID</label>
                        <div class="col-sm-10"> 
                            <input type="text" name="agent.ParentId" value="${subordinateAgent.ParentId}" placeholder="请输入上级代理ID" data-original-title="绑定代理的上级代理ID" class="form-control tooltips" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 col-sm-2 control-label">代理创建时间</label>
                        <div class="col-lg-10">
                            <p class="form-control-static">${subordinateAgent.CreateTime}</p>
                            <input type="hidden" id="auditing" name="auditing"  class="form-control tooltips" />
                        </div>
                    </div>
                    <div class="form-group text-center">
							<button  onclick="cancelEdit()" class="btn btn-default" type="button">取消</button>
							<button class="btn btn-primary" type="submit">确定修改 </button>
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
		function cancelEdit(){
			layer.confirm('是否放弃修改?', {
				  btn: ['确定', '在想想'], //可以无限个按钮
				  title: "提示",
				}, function(index, layero){
					location.href="${BASE_PATH}/agent/agentAuditing";
				}, function(index){
				  // 无操作
				});
		}
		
		 //添加手机号验证
	    jQuery.validator.addMethod("isMobile", function(value, element) {
	        var length = value.length;
	        var mobile = /^1\d{10}$/;
	        return this.optional(element)
	                || (length == 11 && mobile.test(value));
	    }, "请正确填写代理的手机号码");
	    
	    // ajax提交表单回调
	    function submitResult(data){
	    	//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
	        if(data.success == true){
	        	layer.msg("修改成功!", {
					time : 2000
				}, function() {
	              window.location.href = "${BASE_PATH}/agent/agentAuditing";
				});
	        }else{
	            layer.msg(data.errorMsg);
	        }
	    }
	    
	    // 验证表单
	    $(document).ready(
	            function() {
	                $("#agentForm").validate({
	                    submitHandler : function() {
	                    	layer.confirm('是否确定修改此代理信息并通过审核?', {
	          				  btn: ['确定', '只修改'], //可以无限个按钮
	          				  title: "提示",
	          				}, function(index, layero){
// 	          					alert(1);
	          					submitForm("#agentForm", "${BASE_PATH}/agent/agentAuditingEdit", submitResult);
	          				}, function(index){
	          					// 如果只修改,加个标识
	          					$("#auditing").val("1");
	          					submitForm("#agentForm", "${BASE_PATH}/agent/agentAuditingEdit", submitResult);
	          				});
	                    },
	                    rules : {
							"agent.AgentLevel" : {
								required : true
							},
							"agent.Phone" : {
								required : true,
								isMobile : true
							},
							"agent.MaxAgentCount" : {
								digits : true
							},
							"agent.ParentId" : {
								required : true,
								digits : true
							}
						},
						messages : {
							"agent.AgentLevel" : {
								required : "请选择代理级别"
							},
							"agent.Phone" : {
								required : "请输入手机号",
								isMobile : "手机号格式不正确"
							},
							confirmpassword : {
								required : "请输入确认密码",
								equalTo : "确认密码和原密码不一致"
							},
							"agent.QQ" : {
								required : "请输入联系QQ",
								digits : "QQ格式不正确",
								minlength : "QQ至少是5位数"
							},
							"agent.MaxAgentCount" : {
								digits : "必须是纯数字"
							},
							"agent.ParentId" : {
								required : "请绑定上级ID",
								digits : "ID是纯数字"
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
