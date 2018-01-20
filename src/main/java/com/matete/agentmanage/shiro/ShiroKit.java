/**
 * Copyright (c) 2011-2013, dafei 李飞 (myaniu AT gmail DOT com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.matete.agentmanage.shiro;

import java.util.concurrent.ConcurrentMap;


/**
 * ShiroKit. (Singleton, ThreadSafe)
 *
 * @author dafei
 */
public class ShiroKit {

	/**
	 * 登录成功时所用的页面。
	 */
	private static String successUrl = "/";

	/**
	 * 登录成功时所用的页面。
	 */
	private static String loginUrl = "/login.html";


	/**
	 * 登录成功时所用的页面。
	 */
	private static String unauthorizedUrl ="/401.jsp";


	/**
	 * Session中保存的请求的Key值
	 */
	private static String SAVED_REQUEST_KEY = "jfinalShiroSavedRequest";

	
	/**
	 * 设置六种权限的处理方式:游客验证
	 */
	private static String guestAuthzUrl = "/a";
	
	/**
	 * 设置六种权限的处理方式:认证验证
	 */
	private static String authenticatedAuthzUrl = "/a/login";
	
	/**
	 * 设置六种权限的处理方式:静态权限验证
	 */
	private static String permissionAuthzUrl = "/a";
	
	/**
	 * 设置六种权限的处理方式:角色验证
	 */
	private static String roleAuthzUrl = "/a";
	
	/**
	 * 设置六种权限的处理方式:组权限验证
	 */
	private static String groupAuthzUrl = "/a";
	
	/**
	 * 设置五种权限的处理方式:用户验证
	 */
	private static String userAuthzUrl = "/a";

	/**
	 * 用来记录那个action或者actionpath中是否有shiro认证注解。
	 */
	private static ConcurrentMap<String, AuthzHandler> authzMaps = null;

	/**
	 * 禁止初始化
	 */
	private ShiroKit() {}

	static void init(ConcurrentMap<String, AuthzHandler> maps) {
		authzMaps = maps;
	}

	static AuthzHandler getAuthzHandler(String actionKey){
		/*
		if(authzMaps.containsKey(controllerClassName)){
			return true;
		}*/
		return authzMaps.get(actionKey);
	}

	public static final String getSuccessUrl() {
		return successUrl;
	}

	public static final void setSuccessUrl(String successUrl) {
		ShiroKit.successUrl = successUrl;
	}

	public static final String getLoginUrl() {
		return loginUrl;
	}

	public static final void setLoginUrl(String loginUrl) {
		ShiroKit.loginUrl = loginUrl;
	}

	public static final String getUnauthorizedUrl() {
		return unauthorizedUrl;
	}

	public static final void setUnauthorizedUrl(String unauthorizedUrl) {
		ShiroKit.unauthorizedUrl = unauthorizedUrl;
	}
	/**
	 * Session中保存的请求的Key值
	 * @return
	 */
	public static final String getSavedRequestKey(){
		return SAVED_REQUEST_KEY;
	}

	public static String getGuestAuthzUrl() {
		return guestAuthzUrl;
	}

	public static void setGuestAuthzUrl(String guestAuthzUrl) {
		ShiroKit.guestAuthzUrl = guestAuthzUrl;
	}

	public static String getAuthenticatedAuthzUrl() {
		return authenticatedAuthzUrl;
	}

	public static void setAuthenticatedAuthzUrl(String authenticatedAuthzUrl) {
		ShiroKit.authenticatedAuthzUrl = authenticatedAuthzUrl;
	}

	public static String getPermissionAuthzUrl() {
		return permissionAuthzUrl;
	}

	public static void setPermissionAuthzUrl(String permissionAuthzUrl) {
		ShiroKit.permissionAuthzUrl = permissionAuthzUrl;
	}

	public static String getRoleAuthzUrl() {
		return roleAuthzUrl;
	}

	public static void setRoleAuthzUrl(String roleAuthzUrl) {
		ShiroKit.roleAuthzUrl = roleAuthzUrl;
	}

	public static String getUserAuthzUrl() {
		return userAuthzUrl;
	}

	public static void setUserAuthzUrl(String userAuthzUrl) {
		ShiroKit.userAuthzUrl = userAuthzUrl;
	}

	public static String getGroupAuthzUrl() {
		return groupAuthzUrl;
	}

	public static void setGroupAuthzUrl(String groupAuthzUrl) {
		ShiroKit.groupAuthzUrl = groupAuthzUrl;
	}
	
	
}
