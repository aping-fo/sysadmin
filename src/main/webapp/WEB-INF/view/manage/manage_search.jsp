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

	<title>管理</title> <!--dynamic table-->
	<link href="${BASE_PATH}/js/advanced-datatable/css/demo_page.css"
		rel="stylesheet" />
	<link href="${BASE_PATH}/js/advanced-datatable/css/demo_table.css" rel="stylesheet" />
	<link rel="stylesheet" href="${BASE_PATH}/js/data-tables/DT_bootstrap.css" />

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
		<!-- left side end--> <!-- main content start-->
	<div class="main-content">
		<!-- header section start-->
		<jsp:include page="../frame/top.jsp"></jsp:include>
		<!-- header section end-->

		<!-- page heading start-->
		<div class="page-heading">
			<h3>管理会员&代理</h3>
			<ul class="breadcrumb">
				<ul class="breadcrumb">
					<li class="active">减少房卡</li>
				</ul>
		</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-sm-12">

					<section class="panel"> <header class="panel-heading">
					减少房卡 </header>
					<div class="panel-body">
						<div class="adv-table">
							<form id="RechargeForm" class="form-horizontal adminex-form" method="post">
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">被充错人ID</label>
									<div class="col-sm-10">
		                                <input type="text" id="ID" name="ID" placeholder="请输入被扣除者ID" class="form-control">
                                        <span class="input-group-btn">
                                          <button class="btn btn-default" onclick="openModel()" type="button">搜索</button>
                                        </span>
		                            </div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">扣除房卡数量</label>
									<div class="col-sm-10">
										<input type="text" id="num" name="cradNum" placeholder="请输入扣除的房卡数量" class="form-control">
									</div>
								</div>
								<div class="form-group text-center">
									<button class="btn btn-primary"  type="submit">确定扣除</button>
								</div>
							</form>
						</div>
					</div>
					</section>
				</div>
			</div>
		</div>
		<!--body wrapper end-->

		<!-- Modal -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="myModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">查看信息</h4>
					</div>
					<form action="memberEdit" method="get">
						<div class="modal-body">
							<div class="form-group">
								<label for="exampleInputEmail1" id = "user-definedID" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "user-definedGenre" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "user-definedName" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "user-definedNum" ></label>
							</div>
						</div>
					</form>
					<div class="modal-footer">
						<button data-dismiss="modal" class="btn btn-default" type="button">确定</button>
					</div>
				</div>
			</div>
		</div>
		<!-- modal -->

		<!--footer section start-->
		<jsp:include page="../frame/foot.jsp"></jsp:include>
		<!--footer section end-->


	</div>
	<!-- main content end--> </section>

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

		function openModel() {
			var ID = $("#ID").val();
			if (ID == "") {
				layer.msg("请输入ID");
			} else {
				$.ajax({
					url : "${BASE_PATH}/recharge/getRechargeObject",
					datatype : 'json',
					type : 'post',// ‘get’
					data : {
						rechargeID : ID
					},
					success : function(data) {
						if (data == null) {
							layer.msg("未查到充值人");
						} else {
							if(data.id==null){
								// 给代理扣除
								$("#user-definedID").html('<span id="gameID">被充值人ID : '+data.ID+'</span>');
								$("#user-definedGenre").html('<span id="gameID">被充值人类别 : 代理</span>');
								$("#user-definedName").html('<span id="gameID">姓名 : '+data.Name+'</span>');
								$("#user-definedNum").html('<span id="gameID">手机号 : '+data.Phone+'</span>');
								
							}else{
								// 给会员扣除
								$("#user-definedID").html('<span">被充值人ID : '+data.id+'</span>');
								$("#user-definedGenre").html('<span">被充值人类别 : 会员</span>');
								$("#user-definedName").html('<span">微信昵称 : '+data.name+'</span>');
								var str = "";
								if(data.head==null){
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src="" alt="" /></div>'
								}else{
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src='+data.head+' alt="" /></div>'
								}
								$("#user-definedNum").html('<span">头像 : '+str+'</span>');
							}
							//弹出model
							$('#myModal').modal('show');
						}
					}
				});
			}
		}

		// ajax提交表单回调
		function submitResult(data) {
			//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
			if (data.success == true) {
				layer.msg("扣除成功", {
					time : 2000
				}, function() {
					window.location.href = "${BASE_PATH}/manage";
				});
			} else {
				layer.msg(data.errorMsg);
			}
		}

		// 验证表单
		$(document).ready(
				function() {
					$("#RechargeForm").validate(
							{
								submitHandler : function() {
									if(${agent.ID}==$("#ID").val()){
										layer.msg("不能以自己为扣除对象");
									}else{
										layer.confirm('确定扣除ID:<font color="red"><b>'+$("#ID").val()+'</b></font>用户<font color="red"><b>'+$("#num").val()+'</b></font>张房卡?', {
											  btn: ['确定', '在想想'], //可以无限个按钮
											  title: "提示",
											}, function(index, layero){
												submitForm("#RechargeForm","${BASE_PATH}/manage/deductRoomCard",submitResult);
											}, function(index){
											  // 无操作
											});
									}
								}, 
								rules : {
									ID : {
										required : true,
										digits : true
									},
									cradNum : {
										required : true,
										digits : true
									}
								},
								messages : {
									ID : {
										required : "请输入ID",
										digits : "ID是纯数字"
									},
									cradNum : {
										required : "请输入扣除数量",
										digits : "房卡数量是纯数字"
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
