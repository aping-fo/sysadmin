package com.matete.agentmanage.common.utils;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jfinal.core.Controller;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.Function;

public class CommonUtils {

	// \b 是单词边界(连着的两个(字母字符 与 非字母字符) 之间的逻辑上的间隔),
	// 字符串在编译时会被转码一次,所以是 "\\b"
	// \B 是单词内部逻辑间隔(连着的两个字母字符之间的逻辑上的间隔)
	static String phoneReg = "\\b(ip(hone|od)|android|opera m(ob|in)i" + "|windows (phone|ce)|blackberry"
			+ "|s(ymbian|eries60|amsung)|p(laybook|alm|rofile/midp" + "|laystation portable)|nokia|fennec|htc[-_]"
			+ "|mobile|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";
	static String tableReg = "\\b(ipad|tablet|(Nexus 7)|up.browser" + "|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";

	// 移动设备正则匹配：手机端、平板
	static Pattern phonePat = Pattern.compile(phoneReg, Pattern.CASE_INSENSITIVE);
	static Pattern tablePat = Pattern.compile(tableReg, Pattern.CASE_INSENSITIVE);

	/**
	 * 从session获取agent
	 * 
	 * @param controller
	 * @return
	 */
	public static Agent getAgentBySession(Controller controller) {
		return controller.getSessionAttr("agent");
	}

	/**
	 * 将session中删除对象
	 * 
	 * @param controller
	 */
	public static void delAgentBySession(Controller controller) {
		controller.getSession().removeAttribute("agent");
	}

	/**
	 * 从session获取functions
	 * 
	 * @param controller
	 * @return
	 */
	public static List<Function> getFunctionsBySession(Controller controller) {
		return controller.getSessionAttr("functions");
	}

	/**
	 * 获取登陆者ip
	 * 
	 * @param request
	 * @return
	 */
	public static String getRealIp(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 获取
	 * 
	 * @param request
	 * @return
	 */
	public static String getRealIpV2(HttpServletRequest request) {
		String accessIP = request.getHeader("x-forwarded-for");
		if (null == accessIP)
			return request.getRemoteAddr();
		return accessIP;
	}

	/**
	 * 检测是否是移动设备访问
	 * 
	 * @param userAgent
	 *            浏览器标识
	 * @return true:移动设备接入，false:pc端接入
	 */
	public static boolean check(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherPhone = phonePat.matcher(userAgent);
		Matcher matcherTable = tablePat.matcher(userAgent);
		if (matcherPhone.find() || matcherTable.find()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 检查访问方式是否为移动端
	 * 
	 * @param request
	 * @throws IOException
	 */
	public static int check(HttpServletRequest request, HttpServletResponse response) {
		boolean isFromMobile = false;
		HttpSession session = request.getSession();
		// 检查是否已经记录访问方式（移动端或pc端）
		// if (null == session.getAttribute("ua")) {
		try {
			// 获取ua，用来判断是否为移动端访问
			String userAgent = request.getHeader("USER-AGENT").toLowerCase();
			if (null == userAgent) {
				userAgent = "";
			}
			isFromMobile = check(userAgent);
			// 判断是否为移动端访问
			if (isFromMobile) {
				// 移动端
				return 0;
			}
		} catch (Exception e) {
			System.out.println("获取失败");
		}
		// } else {
		// isFromMobile = session.getAttribute("ua").equals("mobile");
		// }
		// PC
		return 1;
	}
}