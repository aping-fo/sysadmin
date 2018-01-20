package com.matete.agentmanage.interceptor;

import java.util.List;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.model.Function;

/**
 * 角色拦截器
 * 
 * @author wjp
 *
 */
public class RoleInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		Controller controller = inv.getController();
		List<Function> functions = CommonUtils.getFunctionsBySession(controller);
		if (CommonUtils.getAgentBySession(controller).getAgentLevel() == GlobalSettings.AGENT_LEVEL_ADMIN) {
			// 管理员登陆直接放行
			inv.invoke();
			return;
		}
		if (functions == null) {
			controller.redirect("/");
		} else {
			// 遍历登陆角色所有权限
			for (Function function : functions) {
				// 获取当前访问的url地址
				String requestURL = controller.getRequest().getRequestURL().toString();
				String path = function.getAccessoryPath();
				String[] split = requestURL.split(path);
				if (split.length == 1) {
					if (requestURL.length() != split[0].length()) {
						inv.invoke();
						return;
					}
				}
			}
			// 拦截,没有权限访问
			controller.redirect("/error/error404.jsp");
			return;
		}
	}
}
