package com.matete.agentmanage.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * 登录校验
 */
public class LoginValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateRequiredString("telephone", "phoneMsg", "请输入手机号");
		validateRequiredString("password", "passMsg", "请输入密码");
	}

	@Override
	protected void handleError(Controller c) {
		c.keepPara("telephone");
		c.render("login");
	}

}
