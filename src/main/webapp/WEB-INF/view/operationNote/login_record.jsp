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

  <title>操作记录</title>

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
                	操作记录
            </h3>
            <ul class="breadcrumb">
                <li class="active"> 登录记录 </li>
            </ul>
        </div>
        <!-- page heading end-->

        <!--body wrapper start-->
        <div class="wrapper">
            <div class="row">
            <div class="col-sm-12">
                <section class="panel">
                    <header class="panel-heading">
                        	我的登录记录信息
                    </header>
                    <div class="panel-body">
                        <table class="table table-hover general-table" >
                            <thead>
                            <tr>
                                <th>#</th>
<!--                                 <th>登录IP</th> -->
                                <th>登录地点</th>
                                <th>登录时间</th>
                                <th>登录设备</th>
                            </tr>
                            </thead>
                            <tbody id="dataContent">
                            </tbody>
                        </table>
	                        <span id="totalCount"></span>
							<div id="pagin" style="float: right;"></div>
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
	//后台用户分页
	function page(curr) {
		layer.load(2);
		$.getJSON('${BASE_PATH}/operationNote/getLoginNoteList',
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
						var DeviceId = "";
						if(data.DeviceId == 0){
							DeviceId = "移动";
						}else{
							DeviceId = "PC";
						}
						
						var str = "<tr><td>"
								+  (1+i)
								+ "</td><td>"
								+ data.Place
								+ "</td><td>"
								+ data.CreateTime
								+ "</td><td>"
								+ DeviceId
								+ "</td>";
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
