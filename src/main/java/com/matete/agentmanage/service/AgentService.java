package com.matete.agentmanage.service;

import java.util.Date;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.common.utils.TimeUtils;
import com.matete.agentmanage.model.Agent;

public class AgentService {
	public static final Agent agentDao = new Agent().dao();

	/**
	 * 获取代理列表
	 * 
	 * @param pageNumber
	 *            分页当前页码
	 * @param parentId
	 *            上级代理ID
	 * @param searchContent
	 *            搜索内容
	 * @return
	 */
	public Page<Agent> getAgentRecord(int pageNumber, int parentId, String searchContent) {
		String selectSQL = "select a.ID,a.Name,a.Phone,a.QQ,a.Password,a.AgentCount,a.TotalHouseCardCount,a.CurHouseCardCount,a.ParentId,a.State,a.MaxAgentCount,a.AgentCount,a.CreateTime,a.LoginStatus, p.PropertyName AgentLevel ";
		if (StringUtils.isNotBlank(searchContent)) {
			Page<Agent> agent = null;
			agent = agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
					"from agent a, property p where p.PropertyKey = ? and a.AgentLevel = p.PropertyValue AND parentId = ? and State = ? and a.ID = ?",
					GlobalSettings.PROPERTY_KEY_AGENTLEVEL, parentId, GlobalSettings.AGENT_STATE_VIA, searchContent);
			if (agent.getList().size() == 0) {
				agent = agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
						"from agent a, property p where p.PropertyKey = ?  and a.AgentLevel = p.PropertyValue AND parentId = ? and State = ? and a.Name like ?",
						GlobalSettings.PROPERTY_KEY_AGENTLEVEL, parentId, GlobalSettings.AGENT_STATE_VIA,
						"%" + searchContent + "%");
			}
			return agent;
		}

		return agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
				"from agent a, property p where p.PropertyKey = ?  and a.AgentLevel = p.PropertyValue AND parentId = ? and State = ?",
				GlobalSettings.PROPERTY_KEY_AGENTLEVEL, parentId, GlobalSettings.AGENT_STATE_VIA);
	}

	/**
	 * 获取指定代理信息
	 * 
	 * @param ID
	 * @return
	 */
	public Agent getAgent(String ID) {
		return agentDao.findById(ID);
	}

	/**
	 * 更新代理信息
	 * 
	 * @param ID
	 * @param Name
	 * @param phone
	 * @param password
	 * @param QQ
	 * @param maxAgentCount
	 *            最大代理数量
	 * @param agentLevel
	 *            代理级别
	 * @return
	 */
	public boolean agentEdit(String ID, String Name, String phone, String password, String QQ, int maxAgentCount,
			int agentLevel) {
		if (StringUtils.isNotBlank(password)) {
			// 修改密码更新
			return agentDao.findById(ID).setName(Name).setPhone(phone).setPassword(DigestUtils.md5Hex(password))
					.setQQ(QQ).setMaxAgentCount(maxAgentCount).setAgentLevel(agentLevel).update();
		}
		return agentDao.findById(ID).setName(Name).setPhone(phone).setQQ(QQ).setMaxAgentCount(maxAgentCount)
				.setAgentLevel(agentLevel).update();
	}

	/**
	 * 添加代理
	 * 
	 * @param agent
	 *            代理对象
	 */
	public boolean agentAdd(Agent agent) {
		if (agent.getMaxAgentCount() == null) {
			agent.setMaxAgentCount(GlobalSettings.AGENT_MAXAGENTCOUNT);
		}
		return agent.setPassword(DigestUtils.md5Hex(agent.getPassword())).setState(0).setCreateTime(new Date()).save();
	}

	/**
	 * 判断该用户是否可以创建代理
	 * 
	 * @param agent
	 * @return
	 */
	public boolean seeAgentCount(Agent agent) {
		if (agent.getMaxAgentCount() > agent.getAgentCount()) {
			return true;
		}
		return false;
	}

	/**
	 * 更新指定代理的代理数
	 * 
	 * @param parentId
	 *            父级代理ID
	 */
	public void AgentCountAddOne(int parentId) {
		// 获取添加代理后一共有多少下级代理个数
		Long num = Db.queryLong("select count(*)from agent where parentId = ?", parentId);
		// 写入代理的下级代理数中
		agentDao.findById(parentId).setAgentCount(Integer.parseInt(num.toString())).update();
	}

	/**
	 * 查询未审核代理列表
	 * 
	 * @param pageNumber
	 *            分页当前页码
	 * @param searchContent
	 *            搜索内容
	 * @return
	 */
	public Page<Agent> getAgentAuditingList(int pageNumber, String searchContent) {
		String selectSQL = "select a.ID,a.Name,a.Phone,a.QQ,a.Password,a.AgentCount,a.TotalHouseCardCount,a.CurHouseCardCount,a.ParentId,a.State,a.MaxAgentCount,a.AgentCount,a.CreateTime,a.LoginStatus, p.PropertyName AgentLevel ";
		if (StringUtils.isNotBlank(searchContent)) {
			Page<Agent> agent = null;
			agent = agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
					"from agent a , property p where p.PropertyKey =? and a.AgentLevel = p.PropertyValue AND State = ? and a.ID = ?",
					GlobalSettings.PROPERTY_KEY_AGENTLEVEL, GlobalSettings.AGENT_STATE_AUDITING, searchContent);
			if (agent.getList().size() == 0) {
				agent = agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
						"from agent a , property p where p.PropertyKey =? and a.AgentLevel = p.PropertyValue AND State = ?  and a.Name like ?",
						GlobalSettings.PROPERTY_KEY_AGENTLEVEL, GlobalSettings.AGENT_STATE_AUDITING,
						"%" + searchContent + "%");
			}
			return agent;
		}
		return agentDao.paginate(pageNumber, GlobalSettings.PAGE_SIZE, selectSQL,
				"from agent a , property p where p.PropertyKey =? and a.AgentLevel = p.PropertyValue AND State = ? order by CreateTime desc",
				GlobalSettings.PROPERTY_KEY_AGENTLEVEL, GlobalSettings.AGENT_STATE_AUDITING);
	}

	/**
	 * 审核通过
	 * 
	 * @param ID
	 */
	public void agentAuditingVia(String ID) {
		agentDao.findById(ID).setState(GlobalSettings.AGENT_STATE_VIA).update();
	}

	/**
	 * 更新审核中的代理信息
	 * 
	 * @param auditing
	 *            修改是否并通过审核标识
	 * @param agent
	 * @return
	 */
	public boolean agentAuditingEdit(String auditing, Agent agent) {
		Agent consult = agentDao.findById(agent.getID());
		// 是否修改通过审核
		if (StringUtils.isNotBlank(auditing)) {
			// 执行只更新，并不通过审核操作
			if (StringUtils.isNotBlank(agent.getPassword())) {
				// 密码被修改
				return agent.setPassword(DigestUtils.md5Hex(agent.getPassword())).update();
			}
			return agent.setPassword(consult.getPassword()).update();
		}
		// 更新并通过审核
		if (StringUtils.isNotBlank(agent.getPassword())) {
			// 密码被修改
			return agent.setPassword(DigestUtils.md5Hex(agent.getPassword())).setState(GlobalSettings.AGENT_STATE_VIA)
					.update();
		}
		return agent.setPassword(consult.getPassword()).setState(GlobalSettings.AGENT_STATE_VIA).update();
	}

	/**
	 * 判断是否存在该代理
	 * 
	 * @param agent
	 */
	public Agent existAgent(Agent agent) {
		Agent parentAgent = agentDao.findFirst("select * from agent where ID = ?", agent.getParentId());
		return parentAgent;
	}

	/**
	 * 查询代理的总排名
	 * 
	 * @param agentID
	 *            需要排名的代理ID
	 * @return
	 */
	public int getAgentRanking(int agentID) {
		Record record = Db.findFirst(
				"SELECT M.ID, M.TotalHouseCardCount, M.pm FROM ( SELECT A.*,@rank :=@rank + 1 AS pm FROM ( SELECT ID, TotalHouseCardCount FROM agent ORDER BY TotalHouseCardCount DESC ) A, (SELECT @rank := 0) B ) M WHERE M.ID = ?",
				agentID);
		if (record == null) {
			return 0;
		}

		try {
			// 第一次是double
			double num = record.getDouble("pm");
			return (int) num;
		} catch (Exception e) {
			// 再查就是long类型（不知道啥情况）
			String num = record.getLong("pm").toString();
			return Integer.parseInt(num);
		}
		// double num = record.get("pm");
	}

	/**
	 * 当月排名
	 * 
	 * @param agentID
	 *            需要排名的代理ID
	 * @return
	 */
	public int getTheSameMonthAgentRanking(int agentID) {
		String sql = "SELECT M.ToId, M.RechargeCount, M.pm FROM( SELECT A.*,@rank :=@rank + 1 AS pm FROM(SELECT ToId, sum(RechargeCount) AS RechargeCount FROM record_recharge WHERE Type = 1 AND RechargeObject = 0 AND CreateTime BETWEEN ? AND ? GROUP BY ToId ORDER BY RechargeCount DESC) A,(SELECT @rank := 0) B) M WHERE M.ToId = ?";
		Record record = Db.findFirst(sql, TimeUtils.getSameMonthFirstDay(), TimeUtils.getSameMonthFastDay(), agentID);
		if (record == null) {
			return 0;
		}
		// 返回的排名可能是long类型这里try下,拦截
		try {
			double num = record.get("pm");
			return (int) num;
		} catch (Exception e) {
			long num = record.get("pm");
			return (int) num;
		}
	}

	/**
	 * 查询指定代理的代理等级名称
	 * 
	 * @param agentLevel
	 *            代理等级
	 * @return
	 */
	public Record getAgentLevelName(int agentLevel) {
		return Db.findFirst("SELECT p.* FROM property p where p.PropertyKey ='AgentLevel' AND  p.PropertyValue = ?",
				agentLevel);
	}
}
