package com.matete.agentmanage.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.service.AgentService;

/**
 * 登录拦截器
 * 
 */
public class LoginInterceptor implements Interceptor {
	private final AgentService agentService = new AgentService();

	@Override
	public void intercept(Invocation inv) {
		Controller controller = inv.getController();
		Agent loginAgent = CommonUtils.getAgentBySession(controller);
		if (loginAgent != null) {
			Agent agent = agentService.getAgent(loginAgent.getID().toString());
			// 检查是否被人顶掉
			if (agent.getLoginStatus() == loginAgent.getLoginStatus()) {
				inv.invoke();
			} else {
				// 加一遍验证,防止上面对比中考虑到内存地址值比较
				if (agent.getLoginStatus().toString().equals(loginAgent.getLoginStatus().toString())) {
					// 通过跳转到用户点击的页面(放行)
					inv.invoke();
					return;
				}
				CommonUtils.delAgentBySession(controller);
				controller.redirect("/error/eLoggedIn.jsp");
			}
		} else {
			controller.redirect("/");
		}
	}
}
