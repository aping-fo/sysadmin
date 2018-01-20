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
import com.matete.agentmanage.model.ResponseResult;
import com.matete.agentmanage.service.AccountService;
import com.matete.agentmanage.service.AgentService;

/**
 * 代理模块
 * 
 * @author wjp
 */
public class AgentController extends Controller {

	public static final AgentService agentService = new AgentService();
	public static final AccountService accountService = new AccountService();

	/**
	 * 跳到代理列表页面
	 */
	@Before(RoleInterceptor.class)
	public void index() {
		// 如果是搜索代理获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		renderJsp("agent_list.jsp");
	}

	/**
	 * 加载代理列表
	 */
	public void getAgentList() {
		String searchContent = getSessionAttr("searchContent");
		removeSessionAttr("searchContent");
		Page<Agent> agents = agentService.getAgentRecord(getParaToInt("pageIndex"),
				CommonUtils.getAgentBySession(this).getID(), searchContent);
		renderJson(agents);
	}

	/**
	 * 跳转到代理编辑页面
	 */
	public void getAgent() {
		String id = getPara("id");
		Validate.notBlank(id);
		// 查询代理级别下拉
		List<Record> agentLevelList = accountService.getPropertyList(GlobalSettings.PROPERTY_KEY_AGENTLEVEL);
		setAttr("agentLevelList", agentLevelList);
		Agent agent = agentService.getAgent(id);
		// 空参拦截
		setAttr("subordinateAgent", agent);
		renderJsp("agent_edit.jsp");
	}

	/**
	 * 更新代理信息
	 */
	public void agentEdit() {
		String ID = getPara("ID");
		String Name = getPara("Name");
		String Phone = getPara("Phone");
		String Password = getPara("Password");
		String QQ = getPara("QQ");
		int agentLevel = getParaToInt("AgentLevel");
		int MaxAgentCount;
		try {
			MaxAgentCount = getParaToInt("MaxAgentCount");
		} catch (Exception e) {
			MaxAgentCount = 0;
		}
		int AgentCount;
		try {
			AgentCount = getParaToInt("AgentCount");
		} catch (Exception e) {
			AgentCount = 0;
		}
		if (MaxAgentCount < AgentCount) {
			renderJson(new ResponseResult(false, "最大代理数不能小于" + AgentCount));
			return;
		}
		// 空参拦截
		Validate.notBlank(ID);
		Validate.notBlank(Name);
		Validate.notBlank(Phone);

		boolean flag = agentService.agentEdit(ID, Name, Phone, Password, QQ, MaxAgentCount, agentLevel);
		if (flag) {
			renderJson(new ResponseResult(true));
		} else {
			renderJson(new ResponseResult(false, "修改失败"));
		}

	}

	/**
	 * 跳转到增加代理页面
	 */
	@Before(RoleInterceptor.class)
	public void addUI() {
		// 查询代理级别下拉
		List<Record> agentLevelList = accountService.getPropertyList(GlobalSettings.PROPERTY_KEY_AGENTLEVEL);
		setAttr("agentLevelList", agentLevelList);
		renderJsp("agent_add.jsp");

	}

	/**
	 * 新增一个代理
	 */
	public void agentAdd() {
		boolean flag = false;
		// 判断是否可以创建代理
		flag = agentService.seeAgentCount(CommonUtils.getAgentBySession(this));
		if (flag) {
			Agent agent = getModel(Agent.class);
			// 空参拦截
			Validate.notBlank(agent.getPhone());
			Validate.notBlank(agent.getPassword());
			// 注册时校验手机号是否被注册
			flag = accountService.verificationPhone(agent.getPhone());
			if (!flag) {
				renderJson(new ResponseResult(false, "手机号码已存在"));
				return;
			}
			if (agentService.agentAdd(agent)) {
				// 已代理数+1
				agentService.AgentCountAddOne(agent.getParentId());
				renderJson(new ResponseResult(true));
			} else {
				renderJson(new ResponseResult(false, "添加失败"));
			}
			return;
		}
		renderJson(new ResponseResult(false, "开通代理数量已达到上限"));
	}

	/**
	 * 跳到审核代理页面
	 */
	@Before(RoleInterceptor.class) // 权限拦截
	public void agentAuditing() {
		// 如果是搜索代理获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		renderJsp("agent_auditing.jsp");
	}

	/**
	 * 跳转到修改未审核代理页面
	 */
	public void agentAuditingEditUI() {
		// System.out.println(getRequest().getRequestURL());
		String ID = getPara("ID");
		// 空参拦截
		Validate.notBlank(ID);
		// 查询代理级别下拉
		List<Record> agentLevelList = accountService.getPropertyList("AgentLevel");
		// 查询修改代理信息
		Agent agent = agentService.getAgent(ID);
		setAttr("agentLevelList", agentLevelList);
		setAttr("subordinateAgent", agent);
		renderJsp("agentAuditing_edit.jsp");
	}

	/**
	 * 更新未审核的代理信息(包含通过审核)
	 */
	public void agentAuditingEdit() {
		String auditing = getPara("auditing");
		Agent agent = getModel(Agent.class);
		// 空参校验
		Validate.notBlank(agent.getPhone());
		// 判断是否存在此父级代理
		Agent ParentAgent = agentService.existAgent(agent);
		if (ParentAgent != null) {
			// 判断该代理是否达到最大代理量
			if (ParentAgent.getAgentCount() >= ParentAgent.getMaxAgentCount()) {
				renderJson(new ResponseResult(false, "代理数量达到上限"));
				return;
			}
			// 判断该填写的代理是否有资格接受该审核代理
			if (ParentAgent.getAgentLevel() < agent.getAgentLevel()) {
				// 更新未审核代理信息
				boolean flag = agentService.agentAuditingEdit(auditing, agent);
				if (flag) {
					//
					agentService.AgentCountAddOne(agent.getParentId());
					renderJson(new ResponseResult(true));
				} else {
					renderJson(new ResponseResult(false, "修改失败"));
				}
			} else {
				renderJson(new ResponseResult(false, "上级代理不能低于此申请代理级别"));
			}
		} else {
			renderJson(new ResponseResult(false, "上级代理不存在"));
		}
	}

	/**
	 * 查询未通过审核的代理列表
	 */
	public void getAgentAuditingList() {
		String searchContent = getSessionAttr("searchContent");
		removeSessionAttr("searchContent");
		Page<Agent> agents = agentService.getAgentAuditingList(getParaToInt("pageIndex"), searchContent);
		renderJson(agents);
	}

	/**
	 * 审核通过
	 */
	public void agentAuditingVia() {
		String ID = getPara("ID");
		// 空参拦截
		Validate.notBlank(ID);
		agentService.agentAuditingVia(ID);
		renderJsp("agent_auditing.jsp");
	}

	/**
	 * 跳转到修改我的信息页面
	 */
	public void editMyInformationUI() {
		// 更新我的代理数
		agentService.AgentCountAddOne(CommonUtils.getAgentBySession(this).getID());
		// 查询代理等级名称
		Record agentLevelName = agentService.getAgentLevelName(CommonUtils.getAgentBySession(this).getAgentLevel());
		setAttr("agentLevelName", agentLevelName);
		renderJsp("agent_edit_me.jsp");
	}

	/**
	 * 跳转到旗下指定代理的所有代理界面
	 */
	public void seeAgentInfoUI() {
		int subordinateID = getParaToInt("subordinateID");
		// 如果是搜索代理获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("subordinateID", subordinateID);
		setSessionAttr("searchContent", searchContent);
		renderJsp("subordinateAgent_list.jsp");
	}

	/**
	 * 查看旗下代理的代理列表
	 */
	public void getSubordinateAgentList() {
		int subordinateID = getSessionAttr("subordinateID");
		String searchContent = getSessionAttr("searchContent");
		removeSessionAttr("searchContent");
		removeSessionAttr("subordinateID");
		Page<Agent> agents = agentService.getAgentRecord(getParaToInt("pageIndex"), subordinateID, searchContent);
		renderJson(agents);
	}

	/**
	 * 查看上级代理ID
	 */
	public void seeSubordinateAgentID() {
		String subordinateID = getPara("subordinateID");
		Agent agent = agentService.getAgent(subordinateID);
		renderJson(agent.getParentId());
	}
}
