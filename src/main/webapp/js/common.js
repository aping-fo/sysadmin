/**
 * layer提示
 * @param msg
 * @param tag
 * @returns
 */
function tips(msg, tag) {
	layer.tips(msg, tag, {
		tips : [ 3, '#FF5722' ]
	});
}

/**
 * 提交表单
 * @param tag 表单tag
 * @param url 提交url
 * @param func 回调函数
 * @returns
 */
function submitForm(tag, url, func) {
    $.ajax({
        type : "POST",
        url : url,
        data : $(tag).serialize(),
        async : false,
        error : function(response) {
            layer.msg(response.responseText);
        },
        success : function(data) {
        	func(data);
        }
    });
}
