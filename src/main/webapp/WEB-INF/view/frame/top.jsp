<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- header section start-->
<div class="header-section">

	<!--toggle button start-->
	<a class="toggle-btn"><i class="fa fa-bars"></i></a>
	<!--toggle button end-->
	<!--notification menu start -->
	<div class="menu-left">
		<!-- 使用天气插件 -->
		<ul class="notification-menu">
			<li> 
				<div id="tp-weather-widget"></div>
			</li>
		</ul>
	</div>
	<div class="menu-right">
		<ul class="notification-menu">
			<!-- PC端 个人资料全局显示 -->
			<li><a href="#" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown">
				<b>
					<c:forEach items="${agentLevelList}" var="property" >
						<c:if test="${agent.agentLevel==property.PropertyValue}">
							${property.PropertyName }:${agent.name}
						</c:if>
					</c:forEach>
				</b><span class="caret"></span>
			</a>
				<ul class="dropdown-menu dropdown-menu-usermenu pull-right">
					<li><a href="${BASE_PATH}/frame"><i class="fa fa-user"></i>我的信息</a></li>
					<li><a href="${BASE_PATH}/agent/editMyInformationUI"><i class="fa fa-wrench"></i>修改个人资料</a></li>
					<li><a href="${BASE_PATH}/loginOut"><i class="fa fa-sign-out"></i>退出系统</a></li>
				</ul></li>
		</ul>
	</div>
	<!--notification menu end -->

</div>
<script>(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.charset="utf-8";P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.seniverse.com/widget/chameleon.js"))</script>
<script>tpwidget("init", {
    "flavor": "slim",
    "location": "WX4FBXXFKE4F",
    "geolocation": "enabled",
    "language": "zh-chs",
    "unit": "c",
    "theme": "chameleon",
    "container": "tp-weather-widget",
    "bubble": "disabled",
    "alarmType": "badge",
    "background": "#FFFFFF",
    "uid": "UCA1F1DF49",
    "hash": "61b7a35a65ced18d06a9cb5619e0e12e"
});
tpwidget("show");</script>
<!-- header section end-->
