package com.matete.agentmanage.controller;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.service.AccountService;
import com.matete.agentmanage.service.AgentService;
import com.matete.agentmanage.service.RechargeService;

/**
 * 框架控制器
 * 
 * @author wjp
 */
public class FrameController extends Controller {

	public static final RechargeService rechargeService = new RechargeService();
	public static final AgentService agentService = new AgentService();
	private static final AccountService accountService = new AccountService();

	/**
	 * 主框架
	 */
	public void index() {
		// 更新我的信息
		agentService.AgentCountAddOne(CommonUtils.getAgentBySession(this).getID());
		// 查询代理级别下拉
		List<Record> agentLevelList = accountService.getPropertyList(GlobalSettings.PROPERTY_KEY_AGENTLEVEL);
		// 排名
		int ranking = agentService.getAgentRanking(CommonUtils.getAgentBySession(this).getID());
		int moonRanking = agentService.getTheSameMonthAgentRanking(CommonUtils.getAgentBySession(this).getID());

		Agent agent = rechargeService.getLoginInformation(CommonUtils.getAgentBySession(this).getID());
		CommonUtils.delAgentBySession(this);
		setSessionAttr("agentLevelList", agentLevelList);
		setSessionAttr("agent", agent);
		setSessionAttr("ranking", ranking);
		setSessionAttr("moonRanking", moonRanking);
		render("index.jsp");
	}

}
