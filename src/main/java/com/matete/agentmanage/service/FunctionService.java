package com.matete.agentmanage.service;

import java.util.List;

import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.Function;

public class FunctionService {
	private static final Function functionDao = new Function().dao();

	/**
	 * 查询用户所有权限
	 * 
	 * @param agentLevel
	 *            代理等级
	 */
	public List<Function> getRole(int agentLevel) {
		List<Function> functions = null;
		if (agentLevel == GlobalSettings.AGENT_LEVEL_ADMIN) {
			functions = functionDao.find("select ID, MenuName, AccessoryPath, ClassForm, Priority, PID from function");
		} else {
			functions = functionDao.find(
					"SELECT f.* FROM function_role r , function f where r.FunctionID = f.ID AND  r.RoleID = ?",
					agentLevel);
		}
		return functions.size() == 0 ? null : functions;
	}

}
