package com.matete.agentmanage.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.Validate;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.model.ResponseResult;
import com.matete.agentmanage.model.Role;
import com.matete.agentmanage.service.GameManageService;

/**
 * 管理模块
 * 
 * @author wjp
 *
 */
public class GameManageController extends Controller {
	public static final GameManageService gameManageService = new GameManageService();

	/**
	 * 跳转到游戏广告公告页面
	 */
	@Before(RoleInterceptor.class)
	public void index() {
		renderJsp("advertisement_affiche.jsp");
	}

	/**
	 * 跳转到游戏公告管理页面
	 */
	@Before(RoleInterceptor.class)
	public void gameAfficheUI() {
		// 查询下拉列表
		List<Record> announcementList = gameManageService.getPropertyAnnouncement("Announcement");
		setAttr("announcementList", announcementList);
		renderJsp("game_affiche.jsp");
	}

	/**
	 * 发布公告(广告)
	 */
	public void advertiseAffiche() {
		String releaseTime = getPara("startTime");
		String content = getPara("content");
		String title = getPara("title");
		int state = getParaToInt("state");
		// 空参拦截
		Validate.notBlank(content);
		// 将字符串时间转换为时间戳
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		long millisecondTime;
		try {
			// 将字符串日期格式转换为date类型
			Date date = sdf.parse(releaseTime);
			// 将日期转换为毫秒
			millisecondTime = date.getTime();
			boolean flag = gameManageService.advertiseAffiche(CommonUtils.getAgentBySession(this).getID(),
					millisecondTime, content, state, title);
			if (flag) {
				renderJson(new ResponseResult(true));
				return;
			}
			renderJson(new ResponseResult(false, "发布失败"));
		} catch (ParseException e) {
			System.out.println("时间转化错误");
			renderJson(new ResponseResult(false, "发生异常,请重新操作"));
			e.printStackTrace();
		}
	}

	/**
	 * 跳转到角色列表页面
	 */
	@Before(RoleInterceptor.class)
	public void roleManageUI() {
		renderJsp("role_manage.jsp");
	}

	/**
	 * 查询所有角色列表
	 */
	public void getRoleList() {
		Page<Record> roleList = gameManageService.getRoleList(getParaToInt("pageIndex"),
				CommonUtils.getAgentBySession(this).getAgentLevel());
		renderJson(roleList);
	}

	/**
	 * 更新角色信息
	 */
	public void editRole() {
		String roleName = getPara("RoleName");
		String propertyName = getPara("PropertyName");
		int pid = getParaToInt("PID");
		int rid = getParaToInt("RID");

		// 空参拦截
		try {
			Validate.notBlank(roleName);
		} catch (Exception e) {
			renderJson(new ResponseResult(false, "角色名称不能为空"));
			e.printStackTrace();
			return;
		}
		try {
			Validate.notBlank(propertyName);
		} catch (Exception e) {
			renderJson(new ResponseResult(false, "代理名称不能为空"));
			e.printStackTrace();
			return;
		}

		try {
			// 更新
			gameManageService.editRoleOfAgentLevelName(roleName, propertyName, pid, rid);
			renderJson(new ResponseResult(true));
			return;
		} catch (Exception e) {
			renderJson(new ResponseResult(false, "修改失败"));
			e.printStackTrace();
			return;
		}
	}

	/**
	 * 跳转到编辑权限页面
	 */
	public void authorityManageUI() {
		int RID;
		try {
			RID = getParaToInt("RID");
		} catch (Exception e) {
			e.printStackTrace();
			RID = -1;
		}
		// 拦截权限外不可访问 拦截超过角色的最大
		if (RID <= CommonUtils.getAgentBySession(this).getAgentLevel() || gameManageService.getMaxRoleID() < RID) {
			renderJsp("/error/error404.jsp");
			return;
		}
		// 查询指定角色拥有的权限
		List<Record> roleFunctionList = gameManageService.getRoleFunctionList(RID);
		// 查询所有父级菜单(PID==null)
		List<Record> parentMenu = gameManageService.getFunctionParentMenu();
		// 查询所有子集菜单(PID!=null)
		List<Record> subsetMenu = gameManageService.getFunctionSubsetMenu();
		// 查询角色信息
		Role role = gameManageService.getRole(RID);
		// 存入域中
		setAttr("role", role);
		setAttr("roleFunctionList", roleFunctionList);
		setAttr("parentMenu", parentMenu);
		setAttr("subsetMenu", subsetMenu);
		renderJsp("authority_manage.jsp");
	}

	/**
	 * 保存权限
	 */
	public void authorityManageEdit() {
		String[] IDs = getParaValues("ID");
		int RoleID = getParaToInt("RoleID");
		// 保存权限
		try {
			boolean flag = gameManageService.saveAuthority(IDs, RoleID);
			if (flag) {
				renderJson(new ResponseResult(true));
				return;
			}
			renderJson(new ResponseResult(false, "没有修改"));
		} catch (Exception e) {
			renderJson(new ResponseResult(false, "修改失败"));
			e.printStackTrace();
		}
	}
}
