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

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.subject.Subject;

/**
 * 访问控制抽象基类
 * @author dafei
 */
abstract class AbstractAuthzHandler implements AuthzHandler {

	/**
	 * 获得Shiro的Subject对象。
	 * @return
	 */
	 protected Subject getSubject() {
	     return SecurityUtils.getSubject();
	 }
	 protected void assertAuthorized( String[] perms,Logical logical){
			Subject subject = getSubject();
			if (perms.length == 1) {
				subject.checkPermission(perms[0]);
				return;
			}
			if (Logical.AND.equals(logical)) {
				getSubject().checkPermissions(perms);
				return;
			}
			if (Logical.OR.equals(logical)) {
				// Avoid processing exceptions unnecessarily - "delay" throwing the
				// exception by calling hasRole first
				boolean hasAtLeastOnePermission = false;
				for (String permission : perms)
					if (getSubject().isPermitted(permission))
						hasAtLeastOnePermission = true;
				// Cause the exception if none of the role match, note that the
				// exception message will be a bit misleading
				if (!hasAtLeastOnePermission)
					getSubject().checkPermission(perms[0]);

			}
	 }
}
