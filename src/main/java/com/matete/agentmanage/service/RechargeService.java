package com.matete.agentmanage.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.RecordRecharge;

public class RechargeService {

	public static final Agent agentDao = new Agent().dao();

	/**
	 * 通用查询property表
	 * 
	 * @param Recharge
	 *            property表中的 PropertyKey字段值为Recharge
	 * @param agentLevel
	 *            代理级别
	 * @return
	 */
	public List<Record> getPropertyList(String Recharge, int agentLevel) {
		if (agentLevel == GlobalSettings.AGENT_LEVEL_ADMIN) {
			return Db.find("select * from property where PropertyKey = ?", Recharge);
		}
		if (agentLevel == GlobalSettings.AGENT_LEVEL_ONE) {
			return Db.find("select * from property where PropertyKey = ? and ID > ?", Recharge,
					GlobalSettings.PROPERTY_KEY_RECHARGE_ONE);
		}
		if (agentLevel == GlobalSettings.AGENT_LEVEL_TWO) {
			return Db.find("select * from property where PropertyKey = ? and ID > ?", Recharge,
					GlobalSettings.PROPERTY_KEY_RECHARGE_TWO);
		}
		if (agentLevel == GlobalSettings.AGENT_LEVEL_THREE) {
			return Db.find("select * from property where PropertyKey = ? and ID > ?", Recharge,
					GlobalSettings.PROPERTY_KEY_RECHARGE_THREE);
		}
		return null;
	}

	/**
	 * 
	 * 获取充值人信息
	 * 
	 * @param rechargeID
	 *            被充值人ID
	 */
	public Record getRechargeObject(String rechargeID) {
		Record rechargeablePerson = null;
		// 查询是否是会员
//		rechargeablePerson = Db.findFirst("select * from accountuserinfo where GameID = ?", rechargeID); // 更换会员表
		rechargeablePerson = Db.findFirst("select * from tbl_player where id = ?", rechargeID);
		if (rechargeablePerson == null) {
			// 如果不是会员，是否是代理
			rechargeablePerson = Db.findFirst("select * from agent where ID = ?", rechargeID);
		}
		return rechargeablePerson;
	}

	/**
	 * 判断是会员还是代理
	 * 
	 * @param rechargeID
	 *            查询人的ID
	 * @return
	 */
	public int getRechargeObject(int rechargeID) {
		Record rechargeablePerson = null;
		// 查询是否是会员
//		rechargeablePerson = Db.findFirst("select * from accountuserinfo where GameID = ?", rechargeID); // 更换会员表
		rechargeablePerson = Db.findFirst("select * from tbl_player where id = ?", rechargeID);
		if (rechargeablePerson != null) {
			// 是会员
			return GlobalSettings.RECHARGE_OBJECT_MEMBER;
		}
		rechargeablePerson = Db.findFirst("select * from agent where ID = ?", rechargeID);
		if (rechargeablePerson != null) {
			// 是代理
			return GlobalSettings.RECHARGE_OBJECT_AGENT;
		}
		return GlobalSettings.RECHARGE_OBJECT_UNKNOWN;
	}

	/**
	 * 充值房卡
	 * 
	 * @param ParentId
	 *            操作人ID
	 * @param ID
	 *            被充值人ID
	 * @param rechargeCount
	 *            充值数量
	 * @param classification
	 *            被充值人的的类型标识
	 * @param RechargeIP
	 *            操作人操作时的IP
	 * @return
	 */
	@Before(Tx.class)
	public boolean rechargeEoomCard(int ParentId, int ID, int rechargeCount, int classification, String RechargeIP) {
		// 扣除充值人房卡
		Db.update("update  agent set CurHouseCardCount = CurHouseCardCount -  ? where ID = ? ", rechargeCount,
				ParentId);
		if (classification == GlobalSettings.RECHARGE_OBJECT_AGENT) {
			// 0 是为给代理充值
			// 充值房卡
			Db.update(
					"update  agent set CurHouseCardCount = CurHouseCardCount + ? ,TotalHouseCardCount = TotalHouseCardCount + ? where ID = ? ",
					rechargeCount, rechargeCount, ID);
		} else {
			// 1 是给会员充值
			Db.update("UPDATE tbl_player SET card = card + ? WHERE id = ? ", rechargeCount, ID);
		}
		// 添加充值记录到充值记录表
		return new RecordRecharge().setRechargeCount(rechargeCount).setAgentId(ParentId).setToId(ID)
				.setRechargeObject(classification).setCreateTime(new Date()).setRechargeIP(RechargeIP)
				.setType(GlobalSettings.RECORD_RECHARGE).save();
	}

	/**
	 * 更新登录者信息
	 * 
	 * @param ID
	 * @return
	 */
	public Agent getLoginInformation(int ID) {
		return agentDao.findFirst("select * from agent where ID = ?", ID);
	}

	/**
	 * 查询充值记录数据
	 * 
	 * @param pageIndex
	 *            分页时当前页码数
	 * @param AgentID
	 * @param searchContent
	 *            搜索，被充值人的ID
	 * @return
	 */
	public Page<Record> getRechargeRecordList(int pageIndex, int AgentID, String searchContent) {

		if (StringUtils.isNotBlank(searchContent)) {
			return Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, "select *",
					"from record_recharge where AgentId = ? and Type = ? and  ToId = ? order by CreateTime desc",
					AgentID, GlobalSettings.RECORD_RECHARGE, searchContent);
		}
		return Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, "select *",
				"from record_recharge where AgentId = ? and Type = ? order by CreateTime desc", AgentID,
				GlobalSettings.RECORD_RECHARGE);
	}

	/**
	 * 查询充值人是否是代理或会员
	 * 
	 * @param agentID
	 *            充值人对象ID
	 * @param ID
	 *            被充值对象ID
	 * @param sign
	 *            被充值对象标识
	 * @return
	 */
	public boolean wouldRcharge(int agentID, int ID, int sign) {
		if (sign == GlobalSettings.RECHARGE_OBJECT_AGENT) {
			Agent agent = agentDao.findFirst("select *from agent where ID = ? and ParentId = ? ", ID, agentID);
			if (agent != null) {
				return true;
			}
		}
		Record record = Db.findFirst("select * from member_agent where GameID = ? and agentID = ?", ID, agentID);
		if (record != null) {
			return true;
		}
		return false;
	}

	/**
	 * 给自己充值
	 * 
	 * @param ID
	 *            登陆者代理对象ID
	 * @param rechargeCount
	 *            充值数量
	 */
	@Before(Tx.class)
	public void rechargeEoomCardMe(int ID, int rechargeCount) {
		Db.update(
				"update  agent set CurHouseCardCount = CurHouseCardCount + ? ,TotalHouseCardCount = TotalHouseCardCount + ? where ID = ? ",
				rechargeCount, rechargeCount, ID);
	}

}
