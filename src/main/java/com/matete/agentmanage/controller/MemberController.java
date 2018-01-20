package com.matete.agentmanage.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.service.MemberService;

/**
 * 会员模块
 * 
 * @author wjp
 */
public class MemberController extends Controller {

	public static final MemberService memberService = new MemberService();

	/**
	 * 跳转到会员列表页面
	 */
	public void index() {
		// 如果是搜索会员获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		// 查询会员的总房卡数
		List<Record> roomCard = memberService.getMemberRoomCard(CommonUtils.getAgentBySession(this).getID());
		setAttr("roomCard", roomCard);
		renderJsp("member_list.jsp");
	}

	/**
	 * 查询会员列表数据
	 */
	public void getMemberList() {
		int signID;
		try {
			signID = getSessionAttr("subordinateID");
			removeSessionAttr("subordinateID");
		} catch (Exception e) {
			signID = CommonUtils.getAgentBySession(this).getID();
		}
		// 获取搜索会员内容
		String searchContent = getSessionAttr("searchContent");
		// 删除域中的内容
		removeSessionAttr("searchContent");
		// 查询会员数据
		Page<Record> mombers = memberService.getMemberRecord(signID, getParaToInt("pageIndex"), searchContent);
		renderJson(mombers);
	}

	/**
	 * 冻结会员
	 */
//	public void freezeMember() {
//		memberService.freezeMember(getParaToInt("memberID"));
//		redirect("/member");
//	}

	/**
	 * 绑定会员
	 */
	public void boundMember() {
		int flag = memberService.boundMember(getParaToInt("memberID"), CommonUtils.getAgentBySession(this).getID());
		renderJson(flag);
	}

	/**
	 * 查看代理旗下所有会员
	 */
	public void seeMemberInfoUI() {
		int subordinateID = getParaToInt("subordinateID");
		// 如果是搜索会员获取搜索内容
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		setSessionAttr("subordinateID", subordinateID);
		// 查询会员的总房卡数
		List<Record> roomCard = memberService.getMemberRoomCard(subordinateID);
		setAttr("roomCard", roomCard);
		renderJsp("subordinateMember_list.jsp");
	}

	/**
	 * 获取代理旗下会员的列表
	 */
	public void getSubordinateMemberList() {
		int subordinateID = getSessionAttr("subordinateID");
		String searchContent = getSessionAttr("searchContent");
		removeSessionAttr("searchContent");
		removeSessionAttr("subordinateID");
		Page<Record> mombers = memberService.getMemberRecord(subordinateID, getParaToInt("pageIndex"), searchContent);
		renderJson(mombers);
	}
}