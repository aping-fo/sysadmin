<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">
<meta name="author" content="ThemeBucket">
<link rel="shortcut icon" href="${BASE_PATH}/favicon.ico" type="image/png" />
<title>充值</title>

<!--responsive table-->
<link href="${BASE_PATH}/css/table-responsive.css" rel="stylesheet" />

<link href="${BASE_PATH}/css/style.css" rel="stylesheet">
<link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet" >

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
			<h3>充值</h3>
			 <ul class="breadcrumb">
                <li class="active"> 充值记录</li>
            </ul>
		</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-sm-12">
					<section class="panel">
					<header class="panel-heading">
					充值信息 &nbsp;&nbsp;&nbsp;
					<a onclick = "openSearch()" title="搜索" ><i class="fa fa-search"></i></a>
					<jsp:include page="../manage/point_out.jsp"></jsp:include>
					</header>
					<div class="panel-body">
						<section id="unseen">
						<table class="table table-bordered table-hover table-striped table-condensed">
							<thead>
								<tr>
									<th>被充值人ID</th>
									<th>充值IP</th>
									<th class="numeric">类型</th>
									<th class="numeric">充值人ID</th>
									<th class="numeric">充值数量</th>
									<th class="numeric">充值时间</th>
									<th class="numeric">充值人姓名</th>
									<th class="numeric">充值人代理级别</th>
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

		<!--footer section start-->
		<jsp:include page="../frame/foot.jsp"></jsp:include>
		<!--footer section end-->
	</div>
	<!-- main content end--> 
	<!-- Modal -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="myModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">充值详情</h4>
					</div>
					<form action="agent/agentEdit" method="post">
						<div class="modal-body">
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeablePersonID" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeablePersonGenre" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeablePersonProperty" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeablePersonName" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeablePersonNum" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeableNum" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "AgentName" ></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1" id = "rechargeableTime" ></label>
							</div>
						</div>
						<div class="modal-footer">
							<button data-dismiss="modal" class="btn btn-default" type="button">确定</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- modal --> <!-- main content end--> 
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
	<!--common scripts for all pages-->
	<script src="${BASE_PATH}/js/scripts.js"></script>
	
	<script type="text/javascript">
	
			//详情页面
			function rechargeLook(recharge) {
				// 查询被充值人信息
				$.ajax({
						url : "${BASE_PATH}/recharge/getRechargeObject",
						datatype : 'json',
						type : 'post',
						data : {
							rechargeID : recharge.ToId
						},
						success : function(data) {
							//弹出model
							if(data.id == null){
								var AgentLevel = "";
								switch(data.AgentLevel)
								{
								case 0:
									AgentLevel = "公司账号";
								  break;
								case 1:
									AgentLevel = "合作伙伴";
								  break;
								case 2:
									AgentLevel = "二级代理";
								  break;
								case 3:
									AgentLevel = "三级代理";
								  break;
								default:
									AgentLevel = "无";
								};
								// 给代理充值
								$("#rechargeablePersonID").html('<span>被充值人ID : '+data.ID+'</span>');
								$("#rechargeablePersonGenre").html('<span>被充值人类别 : 代理</span>');
								$("#rechargeablePersonName").html('<span>姓名 : '+data.Name+'</span>');
								$("#rechargeablePersonProperty").html('<span>代理级别 : '+AgentLevel+'</span>');
								$("#rechargeablePersonNum").html('<span>手机号 : '+data.Phone+'</span>');
								
							}else{
								// 给会员充值
								$("#rechargeablePersonID").html('<span>被充值人ID : '+data.id+'</span>');
								$("#rechargeablePersonGenre").html('<span>被充值人类别 : 会员</span>');
								$("#rechargeablePersonName").html('<span>微信号 : '+data.account+'</span>');
								$("#rechargeablePersonProperty").html('<span>微信昵称 : '+data.name+'</span>');
								$("#rechargeablePersonNum").html('');
							}
							$("#rechargeableNum").html('<span>充值数量 : '+recharge.RechargeCount+'</span>');
							$("#AgentName").html('<span>充值人姓名 : ${agent.Name}</span>');
							$("#rechargeableTime").html('<span>充值时间 : '+recharge.CreateTime+'</span>');
				 			//弹出model
				 			$('#myModal').modal('show');
						}
					});
				}
		
		// 搜索框
		function openSearch(){
			layer.prompt({
				  title: '搜索被充值人ID'
				}, function(value, index, elem){
					location.href="${BASE_PATH}/recharge/rechargeRecordUI?searchContent="+value;
				  	layer.close(index);
				});
		}
		
		// 跳转到编辑页面
		function agentEdit(id) {
			location.href="${BASE_PATH}/agent/getAgent?id="+id;
		}
        
		//后台用户分页
		function page(curr) {
			layer.load(2);
			$.getJSON('${BASE_PATH}/recharge/getRechargeRecordList',{pageIndex : curr || 1},
						function(res) {
							layer.closeAll('loading');
							//数据处理
							$("#totalCount").text(
									"共  " + res.totalRow + " 条记录");
							$("#dataContent").empty();
							for (var i = 0; i < res.list.length; i++) {
								//添加列表数据
								var data = res.list[i];
								var RechargeObject = "";
								var AgentLevel = "";
								switch(data.RechargeObject)
								{
								case 0:
									RechargeObject = "代理";
								  break;
								case 1:
									RechargeObject = "会员";
								  break;
								default:
									RechargeObject = "无";
								};
								switch(${agent.AgentLevel}){
								case 0:
									AgentLevel = "公司账号";
								  break;
								case 1:
									AgentLevel = "合作伙伴";
								  break;
								case 2:
									AgentLevel = "二级代理";
								  break;
								case 3:
									AgentLevel = "三级代理";
								  break;
								default:
									AgentLevel = "无";
								};
							var str = "<tr><td>"
									+ data.ToId
									+ "</td><td>"
									+ data.RechargeIP
									+ "</td><td class='numeric'>"
									+ RechargeObject
									+ "</td><td class='numeric'>"
									+ ${agent.ID}
									+ "</td><td class='numeric'>"
									+ data.RechargeCount
									+ "</td><td class='numeric'>"
									+ data.CreateTime
									+ "</td><td class='numeric'>"
									+ "${agent.Name}"
									+ "</td><td class='numeric'>"
									+ AgentLevel
									+ "</td><td class='numeric'><a style='cursor:pointer' onclick='rechargeLook("+JSON.stringify(data)+")'><span class='label label-info label-mini'>详情</span></a>"
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
