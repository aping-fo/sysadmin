<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="ThemeBucket">
	<link rel="shortcut icon" href="${BASE_PATH}/favicon.ico" type="image/png" />
	
	<title>系统管理</title> <!--icheck-->
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/minimal.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/red.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/green.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/blue.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/yellow.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/minimal/purple.css" rel="stylesheet">
	
	<link href="${BASE_PATH}/js/iCheck/skins/square/square.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/square/red.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/square/green.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/square/blue.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/square/yellow.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/square/purple.css" rel="stylesheet">
	
	<link href="${BASE_PATH}/js/iCheck/skins/flat/grey.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/flat/red.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/flat/green.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/flat/blue.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/flat/yellow.css" rel="stylesheet">
	<link href="${BASE_PATH}/js/iCheck/skins/flat/purple.css" rel="stylesheet">
	
	<link href="${BASE_PATH}/css/style.css" rel="stylesheet">
	<link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet">
</head>

<body class="sticky-header">

	<section> <jsp:include page="../frame/menu.jsp"></jsp:include>
	<!-- main content start-->
	<div class="main-content">
		<jsp:include page="../frame/top.jsp"></jsp:include>
		<!-- page heading start-->
		<div class="page-heading">
			<h3>系统管理</h3>
			<ul class="breadcrumb">
				<li><a href="${BASE_PATH}/gameManage/roleManageUI">角色管理</a></li>
				<li class="active">权限管理</li>
			</ul>
		</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
			<div class="row">
				<div class="col-md-12">
					<section class="panel"> <header class="panel-heading">
					权限管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改角色&nbsp;:&nbsp;“ ${role.RoleName } ”&nbsp;&nbsp;的权限 </header>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-6">
								<c:if test="${parentMenu==null}">
									<p>加载失败！</p>
								</c:if>
								<c:if test="${parentMenu!=null}">
								<form id="authorityForm" class="form-horizontal bucket-form" action="" method="post">
									<div class="form-group">
										<label class="col-sm-3 control-label">菜单功能</label>
										<div class="col-sm-9 icheck ">
											<!-- 加载所有权限菜单 -->
											<input type="hidden" name="RoleID" value="${role.RoleID }" />
												<c:forEach items="${parentMenu}" var="pf" >
													<div class="square single-row">
														<div class="checkbox">
															<input type="checkbox" name="ID" value="${pf.ID}" 
																<c:forEach items="${roleFunctionList}" var="rf" ><c:if test="${rf.FunctionID==pf.ID}">checked</c:if></c:forEach> />
															<label>${pf.MenuName }</label>
															<c:forEach items="${subsetMenu}" var="sf" >
																<c:if test="${sf.PID==pf.ID}">
																	<div class="flat-green single-row">
																	<div class="radio ">
																		<input type="checkbox" name="ID" value="${sf.ID}" 
																			<c:forEach items="${roleFunctionList}" var="rf" ><c:if test="${rf.FunctionID==sf.ID}">checked</c:if></c:forEach> /> 
																		<label>${sf.MenuName }</label>
																	</div>
																	</div>
																</c:if>
															</c:forEach>
														</div>
													</div>
												</c:forEach>
												<div class="form-group text-center">
													<button class="btn btn-primary" type="sumint">保存</button>
												</div>
											</div>
										</div>
									</form>
								</c:if>
							</div>
						</div>
					</div>
					</section>
				</div>
			</div>
		</div>
		<!--body wrapper end-->

		<jsp:include page="../frame/foot.jsp"></jsp:include>
	</div>
	<!-- main content end--> </section>

	<!-- Placed js at the end of the document so the pages load faster -->
	<script src="${BASE_PATH}/js/jquery.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${BASE_PATH}/js/bootstrap.min.js"></script>
	<script src="${BASE_PATH}/js/modernizr.min.js"></script>
	<script src="${BASE_PATH}/js/jquery.nicescroll.js"></script>

	<!--icheck -->
	<script src="${BASE_PATH}/js/iCheck/jquery.icheck.js"></script>
	<script src="${BASE_PATH}/js/icheck-init.js"></script>
	<!--common scripts for all pages-->
	<script src="${BASE_PATH}/js/scripts.js"></script>
	<script src="${BASE_PATH}/js/common.js"></script>
	<script src="${BASE_PATH}/js/layer/layer.js"></script>
	<script src="${BASE_PATH}/js/jquery.validate.js"></script>
	
	<script src="${BASE_PATH}/js/user-defined/authority_manage.js"></script>
</body>
</html>
