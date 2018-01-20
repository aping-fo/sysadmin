package com.matete.agentmanage.shiro;

import java.lang.annotation.Annotation;

import org.apache.shiro.authz.AuthorizationException;

public class GroupAuthzHandler extends AbstractAuthzHandler {
	private final Annotation annotation;

	public GroupAuthzHandler(Annotation annotation) {
		this.annotation = annotation;
	}

	@Override
	public String shiroUrl() {
		// TODO Auto-generated method stub
		return "/a/notGroup";
	}

	@Override
	public void assertAuthorized() throws AuthorizationException {
		// TODO Auto-generated method stub
		if (!(annotation instanceof RequiresGroup))
			return;
		RequiresGroup rrAnnotation = (RequiresGroup) annotation;
		assertAuthorized(rrAnnotation.value(), rrAnnotation.logical());
	}

}
