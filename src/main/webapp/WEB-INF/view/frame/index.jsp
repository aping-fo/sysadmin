<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<meta name="keywords" content="admin, dashboard, bootstrap, template, flat, modern, theme, responsive, fluid, retina, backend, html5, css, css3" />
	<meta name="description" content="" />
	<meta name="author" content="ThemeBucket" />
	<link rel="shortcut icon" href="${BASE_PATH}/favicon.ico" type="image/png" />
	
	<title>我的信息</title>
	
	<!--icheck-->
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/minimal.css"
		rel="stylesheet" />
	<link href="${BASE_PATH}/js/iCheck/skins/square/square.css"
		rel="stylesheet" />
	<link href="${BASE_PATH}/js/iCheck/skins/square/red.css"
		rel="stylesheet" />
	<link href="${BASE_PATH}/js/iCheck/skins/square/blue.css"
		rel="stylesheet" />
	<!--dashboard calendar-->
	<link href="${BASE_PATH}/css/clndr.css" rel="stylesheet" />
	
	<!--Morris Chart CSS -->
	<link rel="stylesheet" href="${BASE_PATH}/js/morris-chart/morris.css" />
	
	<!--common-->
	<link href="${BASE_PATH}/css/style.css" rel="stylesheet" />
	<link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet" />




<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="${BASE_PATH}/js/html5shiv.js"></script>
  <script src="${BASE_PATH}/js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="sticky-header">
	<section> 
		<jsp:include page="menu.jsp"></jsp:include> 
	<div class="main-content">

		<jsp:include page="top.jsp"></jsp:include>

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-md-12">
					<!--statistics start-->
					<div class="row state-overview">
						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel red">
								<div class="symbol">
									<i class="fa fa-star"></i>
								</div>
								<div class="state-value">
									<div class="value">
										<c:if test="${agent.agentLevel==0}">
											公司账号
										</c:if> <c:if test="${agent.agentLevel==1}">
											地区代理
										</c:if> <c:if test="${agent.agentLevel==2}">
											二级代理
										</c:if> 
										<c:if test="${agent.agentLevel==3}">
											三级代理
										</c:if>
									</div>
									<div class="title">代理级别</div>
								</div>
							</div>
						</div>

						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel green">
								<div class="symbol">
									<i class="fa fa-heart"></i>
								</div>
								<div class="state-value">
									<div class="value">${agent.ID}</div>
									<div class="title">推广码</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row state-overview">
						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel purple">
								<div class="symbol">
									<i class="fa fa-hdd-o"></i>
								</div>
								<div class="state-value">
									<div class="value">${agent.totalHouseCardCount}</div>
									<div class="title">总房卡数</div>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel blue">
								<div class="symbol">
									<i class="fa fa-credit-card"></i>
								</div>
								<div class="state-value">
									<div class="value">${agent.curHouseCardCount}</div>
									<div class="title">当前房卡数量</div>
								</div>
							</div>
						</div>
					</div>
					<c:if test="${agent.AgentLevel !=3 }">
						<div class="row state-overview">
							<div class="col-md-6 col-xs-12 col-sm-6">
								<div class="panel red">
									<div class="symbol">
										<i class="fa fa-tags"></i>
									</div>
									<div class="state-value">
										<div class="value">${agent.maxAgentCount}</div>
										<div class="title">最大代理数量</div>
									</div>
								</div>
							</div>
	
							<div class="col-md-6 col-xs-12 col-sm-6">
								<div class="panel green">
									<div class="symbol">
										<i class="fa fa-eye"></i>
									</div>
									<div class="state-value">
										<div class="value">${agent.agentCount}</div>
										<div class="title">已代理数量</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row state-overview">
						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel purple">
								<div class="symbol">
									<i class="fa fa-bar-chart-o"></i>
								</div>
								<div class="state-value">
									<c:if test="${ranking!=0}">
										 <div class="value">${ranking} 名</div>
									</c:if>
									<c:if test="${ranking==0}">
										 <div class="value">未上排行榜</div>
									</c:if>
									<div class="title">总排名</div>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-xs-12 col-sm-6">
							<div class="panel blue">
								<div class="symbol">
									<i class="fa fa-signal"></i>
								</div>
								<div class="state-value">
									<c:if test="${moonRanking!=0}">
										 <div class="value">${moonRanking} 名</div>
									</c:if>
									<c:if test="${moonRanking==0}">
										 <div class="value">未上排行榜</div>
									</c:if>
									<div class="title">当月排名</div>
								</div>
							</div>
						</div>
					</div>
					
					<!--statistics end-->
				</div>
			</div>
		</div>
		<!--body wrapper end-->

		<!--footer section start-->
		<jsp:include page="foot.jsp"></jsp:include>
		<!--footer section end-->
	</div>
	<!-- main content end--> 
	</section>

	<!-- Placed js at the end of the document so the pages load faster -->
	<script src="${BASE_PATH}/js/jquery.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${BASE_PATH}/js/bootstrap.min.js"></script>
	<script src="${BASE_PATH}/js/modernizr.min.js"></script>
	<script src="${BASE_PATH}/js/jquery.nicescroll.js"></script>

	<!--easy pie chart-->
	<script src="${BASE_PATH}/js/easypiechart/jquery.easypiechart.js"></script>
	<script src="${BASE_PATH}/js/easypiechart/easypiechart-init.js"></script>

	<!--Sparkline Chart-->
	<script src="${BASE_PATH}/js/sparkline/jquery.sparkline.js"></script>
	<script src="${BASE_PATH}/js/sparkline/sparkline-init.js"></script>

	<!--icheck -->
	<script src="${BASE_PATH}/js/iCheck/jquery.icheck.js"></script>
	<script src="${BASE_PATH}/js/icheck-init.js"></script>

	<!-- jQuery Flot Chart-->
	<script src="${BASE_PATH}/js/flot-chart/jquery.flot.js"></script>
	<script src="${BASE_PATH}/js/flot-chart/jquery.flot.tooltip.js"></script>
	<script src="${BASE_PATH}/js/flot-chart/jquery.flot.resize.js"></script>

	<!--Morris Chart-->
<!-- 	<script src="${BASE_PATH}/js/morris-chart/morris.js"></script> -->
	<script src="${BASE_PATH}/js/morris-chart/raphael-min.js"></script>

	<!--Calendar-->
	<script src="${BASE_PATH}/js/calendar/clndr.js"></script>
	<script src="${BASE_PATH}/js/calendar/evnt.calendar.init.js"></script>
	<script src="${BASE_PATH}/js/calendar/moment-2.2.1.js"></script>
	<script src="${BASE_PATH}/js/underscore-min.js"></script>

	<!--common scripts for all pages-->
	<script src="${BASE_PATH}/js/scripts.js"></script>

	<!--Dashboard Charts-->
<!-- 	<script src="${BASE_PATH}/js/dashboard-chart-init.js"></script> -->
</body>
</html>
