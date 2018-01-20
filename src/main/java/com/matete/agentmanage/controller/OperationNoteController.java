package com.matete.agentmanage.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.model.RecordLogin;
import com.matete.agentmanage.service.AccountService;

/**
 * 
 * 操作记录模块
 * 
 * @author wjp
 */
public class OperationNoteController extends Controller {
	private static final AccountService accountService = new AccountService();

	/**
	 * 跳转到登录记录页面
	 */
	public void index() {
		renderJsp("login_record.jsp");
	}

	/**
	 * 查询登录记录信息
	 */
	public void getLoginNoteList() {
		// 获取登录的信息
		Page<RecordLogin> loginNote = accountService.getLoginNote(CommonUtils.getAgentBySession(this).getID(),
				getParaToInt("pageIndex"));
		renderJson(loginNote);
	}

}
