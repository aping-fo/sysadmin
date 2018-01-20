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

import java.lang.annotation.Annotation;

import org.apache.shiro.authz.AuthorizationException;

/**
 * 认证通过或已记住的用户访问控制处理器 单例模式运行。
 * 
 * @author dafei
 *
 */
class UserAuthzHandler extends AbstractAuthzHandler {
	private final Annotation annotation;

	public UserAuthzHandler(Annotation annotation) {
		this.annotation = annotation;
	}

	public void assertAuthorized() throws AuthorizationException {
		if (!(annotation instanceof RequiresUser))
			return;
		RequiresUser rrAnnotation = (RequiresUser) annotation;
		assertAuthorized(rrAnnotation.value(), rrAnnotation.logical());
	}

	@Override
	public String shiroUrl() {
		// TODO Auto-generated method stub
		return ShiroKit.getUserAuthzUrl();
	}
}
