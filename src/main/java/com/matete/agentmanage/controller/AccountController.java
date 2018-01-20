package com.matete.agentmanage.controller;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.AddressUtils;
import com.matete.agentmanage.common.utils.CommonUtils;
import com.matete.agentmanage.common.utils.VerifyCodeUtils;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.Function;
import com.matete.agentmanage.model.ResponseResult;
import com.matete.agentmanage.service.AccountService;
import com.matete.agentmanage.service.FunctionService;
import org.apache.commons.lang3.Validate;

import java.io.IOException;
import java.util.List;

/**
 * 入口
 * 
 * @author wjp
 */
@Clear
public class AccountController extends Controller {

	private static final AccountService accountService = new AccountService();
	private static final FunctionService functionService = new FunctionService();

	public void index() {
		redirect("/login");
	}

	/**
	 * 登录页
	 */
	public void login() {
		// 如果用户登录后，访问登录页直接跳转到首页
		if (CommonUtils.getAgentBySession(this) != null) {
			redirect("/frame");
		} else {
			renderJsp("login.jsp");
		}
	}

	/**
	 * 获取验证码
	 */
	public void verifyCode() {

		getResponse().setHeader("Pragma", "No-cache");
		getResponse().setHeader("Cache-Control", "no-cache");
		getResponse().setDateHeader("Expires", 0);
		getResponse().setContentType("image/jpeg");

		// 1.生成随机字串
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);

		// 2.存入会话session
		setSessionAttr("realVerifyCode", verifyCode);
		// 3.生成图片
		int w = 100, h = 35;
		try {
			VerifyCodeUtils.outputImage(w, h, getResponse().getOutputStream(), verifyCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 防止多次response报错
		renderNull();
	}

	/**
	 * 退出登录
	 */
	public void loginOut() {
		CommonUtils.delAgentBySession(this);
		removeSessionAttr("functions");
		removeSessionAttr("agentLevelList");
		removeSessionAttr("ranking");
		removeSessionAttr("moonRanking");
		renderJsp("login.jsp");
	}

	/**
	 * 注册页
	 */
	public void register() {
		// 查询代理级别下拉
		List<Record> agentLevelList = accountService.getPropertyList(GlobalSettings.PROPERTY_KEY_AGENTLEVEL);
		setAttr("agentLevelList", agentLevelList);
		renderJsp("register.jsp");
	}

	/**
	 * 登录
	 */
	public void loginAction() {
		String phone = getPara("phone");
		String password = getPara("password");
		String verifyCode = getPara("verifyCode").toLowerCase();
		String realVerifyCode;
		try {
			realVerifyCode = ((String) getSessionAttr("realVerifyCode")).toLowerCase();
		} catch (Exception e) {
			// 防止验证码失效后时还登录
			renderJson(new ResponseResult(false, "验证码失效"));
			e.printStackTrace();
			return;
		}
		// 空参数拦截
		Validate.notBlank(phone);
		Validate.notBlank(password);
		Validate.notBlank(verifyCode);
		if (!realVerifyCode.equals(verifyCode)) {
			renderJson(new ResponseResult(false, "验证码输入错误"));
			return;
		}
		// 获取登录IP
		String LoginIP = CommonUtils.getRealIp(getRequest());
		// 根据IP获取登录地点
		String address = null;
		try {
			address = AddressUtils.getLoginAddress(LoginIP);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 判断是否是pc还是移动
		int deviceId = CommonUtils.check(getRequest(), getResponse());
		Agent agent = accountService.login(phone, password);
		if (agent != null) {
			if (agent.getState() == GlobalSettings.AGENT_STATE_VIA) {
				// 更改登录状态（只允许同一时间只能一个人登录）
				Agent loginAgent;
				try {
					loginAgent = accountService.editLoginStatus(agent.getID());
				} catch (Exception e) {
					renderJson(new ResponseResult(false, "登录异常"));
					e.printStackTrace();
					return;
				}
				// 查询用户拥有的权限
				List<Function> functions = functionService.getRole(agent.getAgentLevel());
				
				setSessionAttr("functions", functions);
				// 登录记录
				accountService.loginRecord(LoginIP, agent.getID(), deviceId, address);
				setSessionAttr("agent", loginAgent);
				renderJson(new ResponseResult(true));
			} else {
				renderJson(new ResponseResult(false, "该用户未通过审核"));
			}
		} else {
			renderJson(new ResponseResult(false, "用户名或密码错误"));
		}
	}

	/**
	 * 注册
	 */
	public void registerAction() {
		String phone = getPara("phone");
		String password = getPara("password");
		String name = getPara("name");
		String qq = getPara("qq");

		// 空参数拦截
		Validate.notBlank(phone);
		Validate.notBlank(password);
		Validate.notBlank(name);
		Validate.notBlank(qq);

		int agentLevel = getParaToInt("agentLevel");
		// 防护前端修改页面
		agentLevel = GlobalSettings.AGENT_LEVEL_THREE;
		// 注册时校验手机号是否被注册
		boolean flag = accountService.verificationPhone(phone);
		if (!flag) {
			renderJson(new ResponseResult(false, "手机号码已存在"));
			return;
		}
		boolean isSuccess = accountService.register(phone, password, name, qq, agentLevel);
		if (isSuccess) {
			renderJson(new ResponseResult(true));
			return;
		}
		renderJson(new ResponseResult(false, "注册失败，请重试"));
	}
}
