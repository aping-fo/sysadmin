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
<title>我的代理</title>

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
	<jsp:includepage="../frame/menu.jsp"></jsp:include> 
	<!-- left side end--> 
	
	<!-- main content start-->
	<div class="main-content">

		<!-- header section start-->
		<jsp:include page="../frame/top.jsp"></jsp:include>
		<!-- header section end-->

		<!-- page heading start-->
		<div class="page-heading">
			<h3>我的代理</h3>
			 <ul class="breadcrumb">
                <li class="active"> 代理列表 </li>
            </ul>
		</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-sm-12">
					<section class="panel"> <header class="panel-heading">
					代理信息 &nbsp;&nbsp;&nbsp;
					<a onclick = "openSearch()" title="搜索"><i class="fa fa-search"></i></a>
						<jsp:include page="../manage/point_out.jsp"></jsp:include>
					</header>
					<div class="panel-body">
						<section id="unseen">
						<table class="table table-bordered table-hover table-striped table-condensed">
							<thead>
								<tr>
									<th>代理ID</th>
									<th>手机号</th>
									<th class="numeric">姓名</th>
									<th class="numeric">推广码</th>
									<th class="numeric">代理级别</th>
									<th class="numeric">剩余房卡数</th>
									<th class="numeric">总房卡数</th>
									<th class="numeric">已代理数量</th>
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
						<h4 class="modal-title">查看代理</h4>
					</div>
					<form id="AgentForm" action="${BASE_PATH}/member/seeMemberInfoUI" method="post">
						<div class="modal-body">
							<div class="form-group">
								<label for="exampleInputEmail1">代理ID(推广码) : <span id="agentID"></span></label> 
								<input type="hidden" name="subordinateID" id="aid"   autocomplete="off" class="form-control placeholder-no-fix" />
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">姓名 : <span id="Name"></span></label> 
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">手机号  : <span id="Phone"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">密码  : <span>******</span></label>
								<span id="addInput" ></span>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">QQ号 : <span id="QQ"></span></label> 
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">代理级别  : <span id="AgentLevel"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">当前房卡数量 : <span id="CurHouseCardCount"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">总房卡数量 : <span id="TotalHouseCardCount"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">最大代理数: <span id="MaxAgentCount"></span></label>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">已代理数量: <span id="AgentCount"></span></label>
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
		function agentLook(data) {
			//model表单赋值
			$('#myModal').on('show.bs.modal', function () {
				$("#agentID").html(data.ID);
				$("#aid").val(data.ID);
				$("#Name").html(data.Name);
				$("#Phone").html(data.Phone);
				$("#QQ").html(data.QQ);
				$("#CurHouseCardCount").html(data.CurHouseCardCount);
				$("#TotalHouseCardCount").html(data.TotalHouseCardCount);
				$("#MaxAgentCount").html(data.MaxAgentCount);
				$("#AgentCount").html(data.AgentCount);
				// 代理级别
				$("#AgentLevel").html(data.AgentLevel);
			})
			
			//弹出model
			$('#myModal').modal('show');
		}
		
		// 搜索框
		function openSearch(){
			layer.prompt({
				  title: '搜索代理(ID/姓名)'
				}, function(value, index, elem){
					location.href="agent?searchContent="+value;
				  layer.close(index);
				});
		}
		
		// 点击代理ＩＤ
		function agentSubordinate(id){
			layer.confirm('你要查看ID:'+id+'代理的什么信息?', {
				  btn: ['下级会员', '下级代理'], //可以无限个按钮
				  title: "提示",
				}, function(index, layero){
					location.href="${BASE_PATH}/member/seeMemberInfoUI?subordinateID="+id;
				}, function(index){
					location.href="${BASE_PATH}/agent/seeAgentInfoUI?subordinateID="+id;
				});
		}
		
		// 跳转到编辑页面
		function agentEdit(id) {
			location.href="${BASE_PATH}/agent/getAgent?id="+id;
		}
        
		//后台用户分页
		function page(curr) {
			layer.load(2);
			$.getJSON(
						'${BASE_PATH}/agent/getAgentList',
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
							var str = "<tr><td>"
									+ "<a style='cursor:pointer' onclick = 'agentSubordinate("+data.ID+")'>"+data.ID+"</a>"
									+ "</td><td>"
									+ data.Phone
									+ "</td><td class='numeric'>"
									+ data.Name
									+ "</td><td class='numeric'>"
									+ data.ID
									+ "</td><td class='numeric'>"
									+ data.AgentLevel
									+ "</td><td class='numeric'>"
									+ data.CurHouseCardCount
									+ "</td><td class='numeric'>"
									+ data.TotalHouseCardCount
									+ "</td><td class='numeric'>"
									+ data.AgentCount
									+ "</td><td class='numeric'><a style='cursor:pointer' onclick='agentLook("+JSON.stringify(data)+")'><span class='label label-info label-mini'>查看</span></a>"
									+ "<a style='cursor:pointer' onclick='agentEdit("+data.ID+")' ><span class='label label-danger label-mini' style='margin-left:5px;'>编辑</span></a></td></tr>";
							$("#dataContent").append(str);
							}
							//显示分页
							laypage({
								cont : 'pagin', 
								pages : res.totalPage, //通过后台拿到的总页数
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
