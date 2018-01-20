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

  <title>系统管理</title>

  <link href="${BASE_PATH}/css/style.css" rel="stylesheet">
  <link href="${BASE_PATH}/css/style-responsive.css" rel="stylesheet">
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
                	系统管理
            </h3>
            <ul class="breadcrumb">
                <li class="active"> 角色管理 </li>
            </ul>
        </div>
        <!-- page heading end-->

        <!--body wrapper start-->
        <div class="col-sm-12">
                <section class="panel">
                    <header class="panel-heading">
                        	角色列表
                    </header>
                    <div class="panel-body">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>角色名称</th>
                                <th>代理级别</th>
                                <th>操作</th>
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
        <!--body wrapper end-->

        <!--footer section start-->
        <jsp:include page="../frame/foot.jsp"></jsp:include>
        <!--footer section end-->
        <!-- Model编辑角色信息 -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                            <h4 class="modal-title">更改角色信息</h4>
                        </div>
                        <div class="modal-body">

                            <form class="form-horizontal"  role="form">
                                <div class="form-group">
                                    <label for="inputEmail1" class="col-lg-2 col-sm-2 control-label">角色名称</label>
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control" name="RoleName" id="RoleName" placeholder="输入角色名称">
                                         <input type="hidden" class="form-control" name="PID" id="PID">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPassword1" class="col-lg-2 col-sm-2 control-label">代理名称</label>
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control" name="PropertyName" id="PropertyName" placeholder="输入代理名称">
                                        <input type="hidden" class="form-control" name="RID" id="RID">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button type="button" onclick="submitFrom()" class="btn btn-primary">更改</button>
                                    </div>
                                </div>
                            </form>

                        </div>

                    </div>
                </div>
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
	//禁止鼠标右键菜单和F12打开控制台看源码
// 	document.oncontextmenu = function () { return false; };
// 	document.onkeydown = function () {
// 	 if (window.event && window.event.keyCode == 123) {
// 	     event.keyCode = 0;
// 	     event.returnValue = false;
// 	     return false;
// 	 }
// 	}; 
	
	// 编辑角色信息
	function openEdit(data){
		$("#RoleName").val(data.RoleName);
		$("#PropertyName").val(data.PropertyName);
		$("#PID").val(data.PID);
		$("#RID").val(data.RID);
		//弹出model
		$('#myModal').modal('show');
	}
	// 提交保存角色信息
	function submitFrom(){
		$.ajax({
	        url: '${BASE_PATH}/gameManage/editRole',
	        datatype: 'json',
	        type: 'post',// ‘get’
	        data:{RoleName:$("#RoleName").val(),PropertyName:$("#PropertyName").val(),PID:$("#PID").val(),RID:$("#RID").val()},
	        success: function (data) {
	        	if(data.success == true){
		        	layer.msg("修改成功!", {
						time : 1000
					}, function() {
		              window.location.href = "${BASE_PATH}/gameManage/roleManageUI";
					});
		        }else{
		            layer.msg(data.errorMsg);
		        }
	        }
		});
	}
	// 查看对应角色拥有的权限
	function authorityEdit(RID){
		window.location.href = "${BASE_PATH}/gameManage/authorityManageUI?RID="+RID;
	}
	//后台用户分页
	function page(curr) {
		layer.load(2);
		$.getJSON('${BASE_PATH}/gameManage/getRoleList',
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
								+  (1+i)
								+ "</td><td>"
								+ data.RoleName
								+ "</td><td>"
								+ data.PropertyName
								+ "</td><td class='numeric'><a style='cursor:pointer' onclick='openEdit("+JSON.stringify(data)+")' ><span class='label label-info label-mini'>编辑</span></a>"
								+ "<a style='cursor:pointer' onclick='authorityEdit("+data.AgentLevel+")' ><span class='label label-danger label-mini' style='margin-left:5px;'>权限</span></a></td></tr>";
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
