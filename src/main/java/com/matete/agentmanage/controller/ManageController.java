package com.matete.agentmanage.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.Validate;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.common.utils.TimeUtils;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.model.ResponseResult;
import com.matete.agentmanage.service.ManageService;
import com.matete.agentmanage.service.MemberService;
import com.matete.agentmanage.service.RechargeService;

/**
 * 管理模块（管理会员&代理）
 * 
 * @author wjp
 */
public class ManageController extends Controller {

	public static final ManageService manageService = new ManageService();
	public static final RechargeService rechargeService = new RechargeService();
	public static final MemberService memberService = new MemberService();

	/**
	 * 跳转到减少房卡页面
	 */
	@Before(RoleInterceptor.class)
	public void index() {
		renderJsp("manage_search.jsp");
	}

	/**
	 * 减少房卡
	 */
	public void deductRoomCard() {
		int ID;
		int cradNum;
		try {
			// 优化用户体验度
			ID = getParaToInt("ID");
			cradNum = getParaToInt("cradNum");
		} catch (Exception e) {
			renderJson(new ResponseResult(false, "扣除失败"));
			e.printStackTrace();
			return;
		}
		// 获取是代理还是会员
		int classification = rechargeService.getRechargeObject(ID);
		if (classification == GlobalSettings.RECHARGE_OBJECT_UNKNOWN) {
			renderJson(new ResponseResult(false, "未查到用户"));
			return;
		}
		if (classification == GlobalSettings.RECHARGE_OBJECT_AGENT) {
			boolean flag = manageService.compareAgentLevel(CommonUtils.getAgentBySession(this), ID);
			if (!flag) {
				renderJson(new ResponseResult(false, "无权限扣除"));
				return;
			}
		}
		// 查询余额是否够本次扣除
		if (!manageService.seeRemainingSum(ID, cradNum, classification)) {
			// 不足
			renderJson(new ResponseResult(false, "用户余额不足"));
			return;
		}
		// 扣卡
		boolean flag = manageService.deductRoomCard(CommonUtils.getAgentBySession(this).getID(), ID, cradNum,
				classification, CommonUtils.getRealIp(getRequest()));
		if (flag) {
			renderJson(new ResponseResult(true));
		} else {
			renderJson(new ResponseResult(false, "扣除失败"));
		}
	}

	/**
	 * 冻结账户页面
	 */
	@Before(RoleInterceptor.class)
	public void blockedAccountUI() {
		// 查询冻结时长下拉列表
		List<Record> freezeTimeList = manageService.getFreezeTime();
		setAttr("freezeTimeList", freezeTimeList);
		// 如果是搜索会员获取搜索内容（冻结会员列表）
		String searchContent = getPara("searchContent");
		setSessionAttr("searchContent", searchContent);
		// 查询会员的总房卡数
		List<Record> roomCard = memberService.getMemberRoomCard(CommonUtils.getAgentBySession(this).getID());
		setAttr("roomCard", roomCard);
		renderJsp("manage_freeze.jsp");
	}

	/**
	 * 冻结会员
	 */
	public void blockedAccount() {
		int memberID = getParaToInt("ID");
		int freezeTime = getParaToInt("freezeTime");
		// 获取当期时间的时间戳
		long millisecondTime = System.currentTimeMillis();
		// 解冻日期，毫秒值
		long thawTime = millisecondTime + TimeUtils.getFreezeTime(freezeTime);

		boolean flag = false;
		// 查询是否存在该会员
		flag = memberService.getMember(memberID);
		if (!flag) {
			renderJson(new ResponseResult(false, "不存在该会员"));
			return;
		}
		// 查询是否已经被冻结
		flag = memberService.seeIfFreeze(memberID);
		if (!flag) {
			// 冻结会员
			flag = memberService.freezeMember(memberID, thawTime);
			if (flag) {
				renderJson(new ResponseResult(true));
			} else {
				renderJson(new ResponseResult(false, "操作失败"));
			}
			return;
		}
		renderJson(new ResponseResult(false, "该会员已经被冻结"));
	}

	/**
	 * 获取所有冻结的会员
	 */
	public void getFreezeMemberList() {
		// 获取搜索会员内容
		String searchContent = getSessionAttr("searchContent");
		// 删除域中的内容
		removeSessionAttr("searchContent");
		Page<Record> freezeMemberList = memberService.getFreezeMemberList(getParaToInt("pageIndex"), searchContent);
		renderJson(freezeMemberList);
	}

	/**
	 * 解冻会员
	 */
	public void thawAccount() {
		int manageID = getParaToInt("manageID");
		memberService.thawMember(manageID);
		redirect("/manage/blockedAccountUI");
	}
}
