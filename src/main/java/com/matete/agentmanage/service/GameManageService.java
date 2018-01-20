package com.matete.agentmanage.service;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.FunctionRole;
import com.matete.agentmanage.model.Notice;
import com.matete.agentmanage.model.Property;
import com.matete.agentmanage.model.Role;

/**
 * @author wjp
 *
 */
public class GameManageService {

	private static final Role roleDao = new Role().dao();
	private static final Property propertyDao = new Property().dao();

	/**
	 * 保存广告公告到公告表
	 * 
	 * @param agentID
	 *            代理ID
	 * @param startTime
	 *            发布时间
	 * @param content
	 *            公告内容
	 * @param state
	 *            发布类型
	 * @param title
	 *            公告类型
	 * @return
	 */
	public boolean advertiseAffiche(int agentID, long startTime, String content, int state, String title) {
		return new Notice().setAgentID(agentID).setState(state).setTitle(title).setContent(content)
				.setStartTime(startTime).save();
		// return new
		// Announcement().setTime(String.valueOf(startTime)).setContent(content).setAgentID(agentID).setState(state).save();
	}

	/**
	 * 查询下拉列表
	 * 
	 * @param announcement
	 *            获取公告列表
	 * @return
	 */
	public List<Record> getPropertyAnnouncement(String announcement) {
		List<Record> announcementList = Db.find("select*from property where PropertyKey = ? ", announcement);
		return announcementList;
	}

	/**
	 * 查询所有角色
	 * 
	 * @param pageNumber
	 *            分页当前页码
	 * @param agentLevel
	 *            当前登录的代理级别
	 * @return
	 */
	public Page<Record> getRoleList(int pageNumber, int agentLevel) {
		String sql = "select p.ID PID,r.ID RID, r.RoleName , r.RoleID AgentLevel ,p.PropertyName PropertyName ";
		return Db.paginate(pageNumber, GlobalSettings.PAGE_SIZE, sql,
				"from property p , role r where p.PropertyKey= ? AND p.PropertyValue > ? AND p.PropertyValue = r.RoleID",
				GlobalSettings.PROPERTY_KEY_AGENTLEVEL, agentLevel);
	}

	/**
	 * 更新角色名称和通用名称的代理名称
	 * 
	 * @param roleName
	 *            角色名称
	 * @param propertyName
	 *            代理名称
	 * @param pid
	 *            通用property表ID
	 * @param rid
	 *            role表id
	 */
	@Before(Tx.class)
	public void editRoleOfAgentLevelName(String roleName, String propertyName, int pid, int rid) {
		roleDao.findById(rid).setRoleName(roleName).update();
		propertyDao.findById(pid).setPropertyName(propertyName).update();
	}

	/**
	 * 查询指定角色的所有权限
	 * 
	 * @param RID
	 * @return
	 */
	public List<Record> getRoleFunctionList(int RID) {
		String sql = "select ID,RoleID,FunctionID from function_role where RoleID = ? ";
		List<Record> roleFunctionList = Db.find(sql, RID);
		return roleFunctionList;
	}

	/**
	 * 查询所有父级菜单
	 * 
	 * @return
	 */
	public List<Record> getFunctionParentMenu() {
		return Db.find("select ID,MenuName,AccessoryPath,Priority,PID from function where PID IS NULL");
	}

	/**
	 * 查询所有子集菜单
	 * 
	 * @return
	 */
	public List<Record> getFunctionSubsetMenu() {
		return Db.find(
				"select ID,MenuName,AccessoryPath,Priority,PID from function where PID IS NOT null ORDER BY Priority ASC");
	}

	/**
	 * 保存权限
	 * 
	 * @param IDs
	 *            修改后的所有FunctionID
	 * @param roleID
	 *            function_role 的 RoleID
	 */
	@Before(Tx.class)
	public boolean saveAuthority(String[] IDs, int roleID) {
		List<Record> roleFunctionList = getRoleFunctionList(roleID);
		if (roleFunctionList != null) {
			List<String> oldFuntionIDs = new ArrayList<String>();
			for (Record record : roleFunctionList) {
				oldFuntionIDs.add(record.getInt("FunctionID").toString());
			}
			// 如果没有勾选任何权限 IDS = null
			if (IDs == null) {
				// 删除所有权限
				for (String ID : oldFuntionIDs) {
					Db.update("delete from function_role where RoleID = ? and FunctionID = ? ", roleID, ID);
				}
				return true;
			}
			// 判断是否修改了角色权限
			List<String> newFunctionIDs = new ArrayList<String>(); // 将数组转换为集合
			for (String ID : IDs) {
				newFunctionIDs.add(ID);
			}
			if (IDs.length == oldFuntionIDs.size()) {
				if (oldFuntionIDs.containsAll(newFunctionIDs)) {
					// 没有修改
					return false;
				}
			}
			// 修改了
			for (String ID : newFunctionIDs) {
				if (oldFuntionIDs.contains(ID)) {
					// 剔除存在的权限ID
					oldFuntionIDs.remove(ID);
				} else {
					// 新权限直接保存
					new FunctionRole().setRoleID(roleID).setFunctionID(Integer.parseInt(ID)).save();
				}
			}
			// 删除取消授权权限
			for (String ID : oldFuntionIDs) {
				Db.update("delete from function_role where RoleID = ? and FunctionID = ? ", roleID, ID);
			}
			return true;
		}
		// 指定角色未拥有任何权限直接添加权限
		for (String ID : IDs) {
			// 新权限直接保存
			new FunctionRole().setRoleID(roleID).setFunctionID(Integer.parseInt(ID)).save();
		}
		return true;
	}

	/**
	 * 查詢最大角色的roleID
	 * 
	 * @return
	 */
	public int getMaxRoleID() {
		return Db.queryColumn("select max(RoleID) from role");
	}

	/**
	 * 查询指定角色
	 * 
	 * @param RID
	 * @return
	 */
	public Role getRole(int RID) {
		return roleDao.findFirst("select *from role where RoleID = ?", RID);
	}
}
