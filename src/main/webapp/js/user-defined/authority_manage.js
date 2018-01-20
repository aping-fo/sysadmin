// ajax提交表单回调
function submitResult(data){
	//layer.msg(JSON.stringify(data));  //调试ajax返回的json数据
    if(data.success == true){
    	layer.msg("修改成功!", {
			time : 2000
		}, function() {
          window.location.href = pathStr+"/gameManage/roleManageUI";
		});
    }else{
        layer.msg(data.errorMsg);
    }
}
// 验证表单
$(document).ready(function() {$("#authorityForm").validate({
        submitHandler : function() {
        	layer.confirm('是否确定修改?', {
			  btn: ['确定', '在想想'], //可以无限个按钮
			  title: "提示",
			}, function(index, layero){
				submitForm("#authorityForm", pathStr+"/gameManage/authorityManageEdit", submitResult);
			}, function(index){
			  // 无操作
			});
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