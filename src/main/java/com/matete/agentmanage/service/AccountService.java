package com.matete.agentmanage.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.RecordLogin;

public class AccountService {

	private static final Agent agentDao = new Agent().dao();
	private static final RecordLogin recordLogin = new RecordLogin().dao();

	/**
	 * 登录
	 * 
	 * @param phone
	 *            手机号(账号)
	 * @param password
	 *            密码
	 * @return
	 */
	public Agent login(String phone, String password) {
		return agentDao.findFirst("select * from agent where Phone = ? and Password = ?", phone,
				DigestUtils.md5Hex(password));
	}

	/**
	 * 通用查询property表
	 * 
	 * @param propertyKey
	 * @return
	 */
	public List<Record> getPropertyList(String propertyKey) {
		return Db.find("select * from property where PropertyKey = ?", propertyKey);
	}

	/**
	 * 注册
	 * 
	 * @param phone
	 *            手机
	 * @param password
	 *            密码
	 * @param name
	 *            姓名
	 * @param qq
	 * @param agentLevel
	 *            代理级别
	 * @return
	 */
	public boolean register(String phone, String password, String name, String qq, int agentLevel) {

		return new Agent().setPhone(phone).setPassword(DigestUtils.md5Hex(password)).setName(name).setQQ(qq)
				.setAgentLevel(agentLevel).setCreateTime(new Date()).save();
	}

	/**
	 * 添加记录到登录记录表
	 * 
	 * @param realIp
	 *            登录IP
	 * @param agentID
	 *            代理ID
	 * @param deviceId
	 *            标识,PC：1/移动：0
	 * @param address
	 */
	public void loginRecord(String realIp, int agentID, int deviceId, String address) {
		if (!StringUtils.isNotBlank(address)) {
			address = "未知";
		}
		new RecordLogin().setAgentId(agentID).setLoginIp(realIp).setPlace(address).setDeviceId(deviceId)
				.setCreateTime(new Date()).save();
	}

	/**
	 * 查询登录记录信息
	 * 
	 * @param ID
	 *            代理ID
	 * @param pageIndex
	 *            当前页码数
	 * @return
	 */
	public Page<RecordLogin> getLoginNote(int ID, int pageIndex) {
		String selectSql = " select ID, AgentId, LoginIp, DeviceId, Place, CreateTime";
		Page<RecordLogin> loginInfo = recordLogin.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
				"from record_login where AgentId = ? order by CreateTime desc", ID);
		return loginInfo;
	}

	/**
	 * 验证手机号是否存在
	 * 
	 * @param phone
	 */
	public boolean verificationPhone(String phone) {
		Agent agent = agentDao.findFirst("select * from agent where Phone = ? ", phone);
		if (agent == null) {
			return true;
		}
		return false;
	}

	/**
	 * 登录时修改状态 0——>1,1——>0
	 * 
	 * @param ID
	 *            代理ID
	 * @return
	 */
	public Agent editLoginStatus(int ID) {
		Agent agent = agentDao.findById(ID);
		if (agent.getLoginStatus() == GlobalSettings.AGENT_LOGIN_STATUS_0) {
			agent.setLoginStatus(GlobalSettings.AGENT_LOGIN_STATUS_1);
		} else {
			agent.setLoginStatus(GlobalSettings.AGENT_LOGIN_STATUS_0);
		}
		// 持久化导数据库
		agent.update();
		return agent;
	}

}
