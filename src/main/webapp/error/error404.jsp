<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<meta name="description" content=""/>
<meta name="author" content="ThemeBucket"/>
<link rel="shortcut icon" href="#" type="image/png"/>

<title>404 Page</title>

<link href="${BASE_PATH}/css/style.css" rel="stylesheet"/>
<link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet"/>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="error-page">

	<section>
		<div class="container ">

			<section class="error-wrapper text-center">
				<h1>
					<img alt="" src="${BASE_PATH}/images/404-error.png"/>
				</h1>
				<h2>网页未找到</h2>
				<h3>也可能是无权限访问。。。</h3>
				<a class="back-btn" href="${BASE_PATH}/"> 回到首页</a>
			</section>

		</div>
	</section>

	<!-- Placed js at the end of the document so the pages load faster -->
	<script src="${BASE_PATH}/js/jquery.min.js"></script>
	<script src="${BASE_PATH}/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="${BASE_PATH}/js/bootstrap.min.js"></script>
	<script src="${BASE_PATH}/js/modernizr.min.js"></script>


	<!--common scripts for all pages-->
	<!--<script src="js/scripts.js"></script>-->

</body>
</html>
