function openModel() {
			var ID = $("#ID").val();
			if (ID == "") {
				layer.msg("请输入ID");
			} else {
				$.ajax({
					url : pathStr+"/recharge/getRechargeObject",
					datatype : 'json',
					type : 'post',// ‘get’
					data : {
						rechargeID : ID
					},
					success : function(data) {
						if (data == null) {
							layer.msg("未查到会员");
						} else {
							if(data.GameID!=null){
								// 给会员扣除
								$("#user-definedID").html('<span id="gameID">被充值人ID : '+data.GameID+'</span>');
								$("#user-definedGenre").html('<span id="gameID">被充值人类别 : 会员</span>');
								$("#user-definedName").html('<span id="gameID">姓名 : '+data.Name+'</span>');
								var str = "";
								if(data.avatar==null){
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src="" alt="" /></div>'
								}else{
									 str = '<div id="picture" class="fileupload-new thumbnail" style="width: 80px; height: 80px;"><img src='+data.avatar+' alt="" /></div>'
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
				$("#gameID").html(data.GameID);
				$("#NickName").html(data.NickName);
				$("#Name").html(data.Name);
				$("#sumRechargeCount").html(sumRechargeCount);
				$("#Score").html(data.Score);
				var surplus = sumRechargeCount - data.Score;
				$("#surplus").html(surplus);
				if (data.avatar == null) {
					$("#picture").html('<img src="" alt="" />')
				} else {
					$("#picture").html('<img src='+data.avatar+' alt="" />')
				}
				var StateID = "";
				if (data.StateID == 1) {
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
					location.href= pathStr+"/manage/thawAccount?manageID="+manageID;
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
					window.location.href = pathStr+"/manage/blockedAccountUI";
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
									submitForm("#RechargeForm",pathStr+"/manage/blockedAccount",submitResult);
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
				location.href = pathStr+"/manage/blockedAccountUI?searchContent=" + value;
				layer.close(index);
			});
		}
		//后台用户分页
		function page(curr) {
			layer.load(2);
			$.getJSON(
					pathStr+'/manage/getFreezeMemberList',
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
							var sumRechargeCount = 0;
							var card = "";
							var StateID = "";
							if (card != null) {
								for (var j = 0; j < card.length; j++) {
									if (card[j].GameID == data.GameID) {
										sumRechargeCount = card[j].sumRechargeCount;
									}
								}
							}
							var str = "<tr><td>"
									+ data.GameID
									+ "</td><td>"
									+ "一天"
									+ "</td><td class='numeric'>"
									+ data.NickName
									+ "</td><td class='numeric'>"
									+ data.Name
									+ "</td><td class='numeric'>"
									+ sumRechargeCount
									+ "</td><td class='numeric'>"
									+ data.Score
									+ "</td><td class='numeric'>"
									+ data.sex
									+ "</td><td class='numeric'>"
									+ data.LastLoginTime
									+ "</td><td class='numeric'><a style='cursor:pointer' onclick='memberLook("
									+ JSON.stringify(data)
									+ ","
									+ sumRechargeCount
									+ ")'><span class='label label-info label-mini'>查看</span></a>"
									+"<a style='cursor:pointer' onclick='memberThawEdit("+data.GameID+")' ><span class='label label-danger label-mini' style='margin-left:5px;'>解冻</span></a>"
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