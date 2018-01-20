package com.matete.agentmanage.controller;

import java.util.List;

import org.apache.commons.lang3.Validate;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.RecordRecharge;
import com.matete.agentmanage.model.ResponseResult;
import com.matete.agentmanage.service.AgentService;
import com.matete.agentmanage.service.RechargeService;

/**
 * 充值模块
 * 
 * @author wjp
 */
public class RechargeController extends Controller {
	public static final RechargeService rechargeService = new RechargeService();
	public static final AgentService agentService = new AgentService();

	/**
	 * 跳转到搜索页面
	 */
	@Before(RoleInterceptor.class)
	public void index() {
		// 查询所有充值选项
		List<Record> rechargeList = rechargeService.getPropertyList("Recharge",
				CommonUtils.getAgentBySession(this).getAgentLevel());
		setAttr("rechargeList", rechargeList);
		renderJsp("recharge_search.jsp");
	}

	/**
	 * 查询指定ID信息
	 */
	public void getRechargeObject() {
		String rechargeID = getPara("rechargeID");

		// 空参拦截
		Validate.notBlank(rechargeID);
		// 获取被充值人的信息
		Record rechargeablePerson = rechargeService.getRechargeObject(rechargeID);
		renderJson(rechargeablePerson);
	}

	/**
	 * 充值房卡
	 */
	public void rechargeRoomCard() {
		int ID = getParaToInt("ID");
		int RechargeCount = getParaToInt("RechargeCount");
		if (RechargeCount != GlobalSettings.RECHARGE_MAX_NUMBER) {
			if (ID == CommonUtils.getAgentBySession(this).getID()) {
				renderJson(new ResponseResult(false, "不能给自己充值"));
				return;
			}
		}
		// admin给自己充值
		if (CommonUtils.getAgentBySession(this).getAgentLevel() == GlobalSettings.AGENT_LEVEL_ADMIN) {
			if (ID == CommonUtils.getAgentBySession(this).getID()) {
				try {
					rechargeService.rechargeEoomCardMe(ID, RechargeCount);
					renderJson(new ResponseResult(true));
					return;
				} catch (Exception e) {
					e.printStackTrace();
					renderJson(new ResponseResult(false, "充值失败"));
					return;
				}
			}
		}
		// 验证是否余额足够
		if (agentService.getAgent(CommonUtils.getAgentBySession(this).getID().toString())
				.getCurHouseCardCount() < RechargeCount) {
			renderJson(new ResponseResult(false, "余额不足,充值失败!"));
			return;
		}
		// 获取是代理还是会员
		int sign = rechargeService.getRechargeObject(ID);
		if (sign == GlobalSettings.RECHARGE_OBJECT_UNKNOWN) {
			renderJson(new ResponseResult(false, "未查到充值人"));
			return;
		}
		boolean flag;
		// 是否可以给其充值
		flag = rechargeService.wouldRcharge(CommonUtils.getAgentBySession(this).getID(), ID, sign);
		if (!flag) {
			if (sign == GlobalSettings.RECHARGE_OBJECT_AGENT) {
				if (CommonUtils.getAgentBySession(this).getAgentLevel() == GlobalSettings.AGENT_LEVEL_THREE) {
					renderJson(new ResponseResult(false, "你只能给会员充值"));
					return;
				}
				renderJson(new ResponseResult(false, "此代理不属于你"));
				return;
			}
			if (sign == GlobalSettings.RECHARGE_OBJECT_MEMBER) {
				renderJson(new ResponseResult(false, "此会员不属于你"));
				return;
			}
		}
		// 充值
		flag = rechargeService.rechargeEoomCard(CommonUtils.getAgentBySession(this).getID(), ID, RechargeCount, sign,
				CommonUtils.getRealIp(getRequest()));
		if (flag) {
			renderJson(new ResponseResult(true));
		} else {
			renderJson(new ResponseResult(false, "充值失败"));
		}
	}

	/**
	 * 跳转到充值记录页面
	 */
	@Before(RoleInterceptor.class)
	public void rechargeRecordUI() {
		// 如果是搜索代理获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		renderJsp("recharge_list.jsp");
	}

	/**
	 * 获取充值记录数据
	 */
	public void getRechargeRecordList() {
		String searchContent = getSessionAttr("searchContent");
		removeSessionAttr("searchContent");
		Page<Record> recordRecharge = rechargeService.getRechargeRecordList(getParaToInt("pageIndex"),
				CommonUtils.getAgentBySession(this).getID(), searchContent);
		renderJson(recordRecharge);
	}

}
