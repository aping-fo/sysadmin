<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- left side start-->
<div class="left-side sticky-left-side">

	<!--logo and iconic logo start-->
	<div class="logo">
		<a href="index"><img src="${BASE_PATH}/images/logo.png" alt="Logo" /></a>
	</div>

	<div class="logo-icon text-center">
		<a href="index"><img src="${BASE_PATH}/images/logo_icon.png"
			alt="" /></a>
	</div>
	<!--logo and iconic logo end-->

	<div class="left-side-inner">

		<!-- visible to small devices only -->
		<div class="visible-xs hidden-sm hidden-md hidden-lg">
			<div class="media logged-user">
				<div class="media-body">
					<h4>
						<a href="#">${agent.name}</a>
					</h4>
					手机号:<span>${agent.phone}</span><br /> 推广码:<span>${agent.ID}</span>
				</div>
			</div>

			<h5 class="left-nav-title">帐户信息</h5>
			<ul class="nav nav-pills nav-stacked custom-nav">
				<!-- <li><a href="#"><i class="fa fa-user"></i> <span>个人信息</span></a></li>
				<li><a href="#"><i class="fa fa-cog"></i> <span>设置</span></a></li> -->
				<li><a href="${BASE_PATH}/loginOut"><i class="fa fa-sign-out"></i><span>退出系统</span></a></li>
			</ul>
		</div>

		<!--sidebar nav start-->
		<ul class="nav nav-pills nav-stacked custom-nav">
			<!-- 单挑选项 -->
			<c:if test="${functions == null}">
				<li><a href=""><i class="fa fa-users"></i><span>无菜单选项联系上级获取</span></a></li>
			</c:if>
			<c:if test="${functions != null}">
				<c:forEach items="${functions }" var="pm" >
					<c:if test="${pm.Priority == 0 }">
						<c:if test="${pm.AccessoryPath == ''}">
							<li class="menu-list"><a href=""><i class="${pm.ClassForm }"></i><span>${pm.MenuName }</span></a>
								<ul class="sub-menu-list">
									<c:forEach items="${functions }" var="sm" >
										<c:if test="${pm.ID==sm.PID }">
											<li><a href='${BASE_PATH}${sm.AccessoryPath }'>${sm.MenuName }</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</li> 
						</c:if>
						<c:if test="${pm.AccessoryPath != ''}">
							<li><a href="${BASE_PATH}${pm.AccessoryPath}"><i class="${pm.ClassForm }"></i><span>${pm.MenuName }</span></a></li> 
						</c:if>
					</c:if>
				</c:forEach>
			</c:if>
		</ul>
		<!--sidebar nav end-->

	</div>
</div>