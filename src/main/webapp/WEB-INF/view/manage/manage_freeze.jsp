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
	<link href="${BASE_PATH}/js/advanced-datatable/css/demo_page.css" rel="stylesheet" />
	<link href="${BASE_PATH}/js/advanced-datatable/css/demo_table.css" rel="stylesheet" />
	<link rel="stylesheet" href="${BASE_PATH}/js/data-tables/DT_bootstrap.css" />
	<link href="${BASE_PATH}/css/table-responsive.css" rel="stylesheet" />~
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
	<div class="main-content">

		<!-- header section start-->
		<jsp:include page="../frame/top.jsp"></jsp:include>
		<!-- header section end-->

		<!-- page heading start-->
		<div class="page-heading">
			<h3>管理会员&代理</h3>
			<ul class="breadcrumb">
				<ul class="breadcrumb">
					<li class="active">冻结账户</li>
				</ul>
		</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-sm-12">
					<section class="panel"> 
					<header class="panel-heading">冻结会员</header>
					<div class="panel-body">
						<div class="adv-table">
							<form id="RechargeForm" class="form-horizontal adminex-form" method="post">
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">冻结会员ID</label>
									<div class="col-sm-10">
		                                <input type="text" id="ID" name="ID" placeholder="请输入冻结ID" class="form-control">
                                        <span class="input-group-btn">
                                          <button class="btn btn-default" onclick="openModel()" type="button">搜索</button>
                                        </span>
		                            </div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 col-sm-2 control-label">冻结时长</label>
                                    <div class="col-md-10">
										<select id="AgentLevel" class="form-control m-bot15"
											name="freezeTime">
											<option value="">选择冻结时间</option>
											<c:forEach var="item" items="${freezeTimeList}"
												varStatus="status">
													<option value="${item.PropertyValue}">${item.PropertyName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group text-center">
									<button class="btn btn-primary"  type="submit">确定冻结</button>
									<hr />
								</div>
							</form>
						</div>
					</div>
					<header class="panel-heading">
					已冻结会员 &nbsp;&nbsp;&nbsp; <a onclick="openSearch()" title="搜索" ><i class="fa fa-search"></i></a>
					<jsp:include page="point_out.jsp"></jsp:include>
					</header>
					<div class="panel-body">
						<section id="unseen">
						<table
							class="table table-bordered table-hover table-striped table-condensed">
							<thead>
								<tr>
									<th>会员ID</th>
									<th>解封日期</th>
									<th class="numeric">微信昵称</th>
									<th class="numeric">真实姓名</th>
									<th class="numeric">总购房卡数</th>
									<th class="numeric">剩余房卡数</th>
									<th class="numeric">性别</th>
									<th class="numeric">上次登录时间</th>
									<th class="numeric">操作</th>
								</tr>
							</thead>
							<tbody id="dataContent">
							</tbody>
						</table>
							<span id="totalCount"></span>
							<div id="pagin" style="float: right;"></div>
						</section>
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
		<!-- Modal -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="myModalFreeze" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">查看会员</h4>
					</div>
					<form action="memberEdit" method="get">
						<div class="modal-body">
							<div class="form-group">
								<label for="exampleInputEmail1">头像 </label> 
	                               <div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;" ></div>
							</div>
							<div class="form-group">
							<label for="exampleInputEmail1">会员ID : <span id="gameID"></span></label> 
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">微信昵称 : <span id="NickName"></span></label> 
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">会员状态  : <span id="IdentityID"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">创建时间  : <span id="Name"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">总房卡数量 : <span id="sumRechargeCount"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">剩余房卡数量 : <span id="Score"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">消耗房卡数量 : <span id="surplus"></span></label>
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

	<!--pickers plugins-->
	<!--pickers initialization-->
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
						if (data== null) {
							layer.msg("未查到会员");
						} else {
							if(data.id!=null){
								$("#user-definedID").html('<span">会员ID : '+data.id+'</span>');
								$("#user-definedGenre").html('<span">被充值人类别 : 会员</span>');
								$("#user-definedName").html('<span">微信昵称 : '+data.name+'</span>');
								var str = "";
								if(data.head==null){
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src="" alt="" /></div>'
								}else{
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src='+data.head+' alt="" /></div>'
								}
								$("#user-definedNum").html('<span">头像 : '+str+'</span>');
								//弹出model
								$('#myModal').modal('show');
							}else{
								layer.msg("未查到会员");
							}
							
						}
					}
				});
			}
		}
		//详情页面
		function memberLook(data, sumRechargeCount) {
			//model表单赋值
			$('#myModalFreeze').on('show.bs.modal', function() {
				$("#gameID").html(data.id+"<b>(微信号:"+data.account+"<b/>)");
				$("#NickName").html(data.name);
				$("#Name").html(data.createTime);
				$("#sumRechargeCount").html(sumRechargeCount);
				$("#Score").html(data.card);
				var surplus = sumRechargeCount - data.card;
				$("#surplus").html(surplus);
				if (data.head == null) {
					$("#picture").html('<img src="" alt="" />')
				} else {
					$("#picture").html('<img src='+data.head+' alt="" />')
				}
				var StateID = "";
				if (data.status == 1) {
					StateID = "正常";
				} else {
					StateID = "冻结";
				}
				$("#IdentityID").html(StateID);
			})

			//弹出model
			$('#myModalFreeze').modal('show');
		}
		// 解冻会员
		function memberThawEdit(manageID){
			layer.confirm('你要解冻ID:'+manageID+'会员?', {
				  btn: ['确定', '再想想'], //可以无限个按钮
				  title: "提示",
				}, function(index, layero){
					location.href="${BASE_PATH}/manage/thawAccount?manageID="+manageID;
				}, function(index){
				});
		}
		// ajax提交表单回调
		function submitResult(data) {
			//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
			if (data.success == true) {
				layer.msg("冻结成功", {
					time : 1500
				}, function() {
					window.location.href = "${BASE_PATH}/manage/blockedAccountUI";
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
									submitForm("#RechargeForm","${BASE_PATH}/manage/blockedAccount",submitResult);
								},
								rules : {
									ID : {
										required : true,
										digits : true
									},
									freezeTime : {
										required : true
									}
								},
								messages : {
									ID : {
										required : "请输入ID",
										digits : "ID是纯数字"
									},
									freezeTime : {
										required : "请选择一个选项"
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
		// 搜索框
		function openSearch() {
			layer.prompt({
				title : '搜索会员(ID/昵称)'
			}, function(value, index, elem) {
				location.href = "${BASE_PATH}/manage/blockedAccountUI?searchContent=" + value;
				layer.close(index);
			});
		}
		//后台用户分页
		function page(curr) {
			layer.load(2);
			$.getJSON(
					'${BASE_PATH}/manage/getFreezeMemberList',
					{
						pageIndex : curr || 1
					},
					function(res) {
						layer.closeAll('loading');
						//数据处理
						$("#totalCount").text(
								"共  " + res.totalRow + " 条记录");
						$("#dataContent").empty();
						for (var i = 0; i < res.list.length; i++) {
							//添加列表数据
							var data = res.list[i];
							var sumRechargeCount = data.card+data.cardConsume;
// 							var card = ${roomCard}; // 更換会员表后获取总房卡数方式变化如上
// 							var StateID = "";
// 							if (card != null) {
// 								for (var j = 0; j < card.length; j++) {
// 									if (card[j].GameID == data.GameID) {
// 										sumRechargeCount = card[j].sumRechargeCount;
// 									}
// 								}
// 							}
							var str = "<tr><td>"
									+ data.id
									+ "</td><td>"
									+ new Date(parseInt(data.forbidTime)).toLocaleString().replace(/:\d{1,2}$/,' ')
									+ "</td><td class='numeric'>"
									+ data.name
									+ "</td><td class='numeric'>"
									+ data.account
									+ "</td><td class='numeric'>"
									+ sumRechargeCount
									+ "</td><td class='numeric'>"
									+ data.card
									+ "</td><td class='numeric'>"
									+ data.sex
									+ "</td><td class='numeric'>"
									+ data.loginTime
									+ "</td><td class='numeric'><a style='cursor:pointer' onclick='memberLook("
									+ JSON.stringify(data)
									+ ","
									+ sumRechargeCount
									+ ")'><span class='label label-info label-mini'>查看</span></a>"
									+"<a style='cursor:pointer' onclick='memberThawEdit("+data.id+")' ><span class='label label-danger label-mini' style='margin-left:5px;'>解冻</span></a>"
									+ "</td></tr>";
							$("#dataContent").append(str);
						}
						//显示分页
						laypage({
							cont : 'pagin',
							pages : res.totalPage,
							curr : curr || 1,
							skip : true,
							skin : 'molv',
							groups : 3,
							jump : function(obj, first) {
								if (!first) {
									page(obj.curr);
								}
							}
						});
					});
		};
		//运行
		page();
	</script>
</body>
</html>
