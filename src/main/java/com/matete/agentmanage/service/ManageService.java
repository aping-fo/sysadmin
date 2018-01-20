package com.matete.agentmanage.service;

import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.Agent;
import com.matete.agentmanage.model.RecordRecharge;

public class ManageService {
	private static final Agent agentDao = new Agent().dao();

	/**
	 * 扣除房卡
	 * 
	 * @param AgentID
	 *            扣除返回房卡的代理ID
	 * @param ID
	 *            扣除目标的ID(代理/会员)
	 * @param cradNum
	 *            扣除的数量
	 * @param classification
	 *            充值对象标识
	 * @param RechargeIP
	 *            操作人IP
	 */
	@Before(Tx.class)
	public boolean deductRoomCard(int AgentID, int ID, int cradNum, int classification, String RechargeIP) {
		// 先扣除房卡
		if (classification == GlobalSettings.RECHARGE_OBJECT_AGENT) {
			// 0 是扣除代理
			Db.update(
					"update  agent set CurHouseCardCount = CurHouseCardCount - ? ,TotalHouseCardCount = TotalHouseCardCount - ?  where ID = ? ",
					cradNum, cradNum, ID);
		} else {
			// 1 是扣除会员
			Db.update("UPDATE tbl_player SET card = card - ? WHERE id = ? ", cradNum, ID);
		}
		// 加入操作人账户房卡
		Db.update("update  agent set CurHouseCardCount = CurHouseCardCount +  ? where ID = ? ", cradNum, AgentID);
		// 添加充值记录到充值记录表
		return new RecordRecharge().setRechargeCount(cradNum).setAgentId(AgentID).setToId(ID)
				.setRechargeObject(classification).setCreateTime(new Date()).setRechargeIP(RechargeIP)
				.setType(GlobalSettings.RECORD_DEDUCT).save();
	}

	/**
	 * 查看被扣除对象余额是否足够本次扣除
	 * 
	 * @param ID
	 *            扣除对象ID
	 * @param cradNum
	 *            扣除数量
	 * @param classification
	 *            判断代理和会员的标识
	 * @return
	 */
	public boolean seeRemainingSum(int ID, int cradNum, int classification) {
		int remainingSum = 0;
		if (classification == GlobalSettings.RECHARGE_OBJECT_AGENT) {
			// 是代理
			remainingSum = Db.queryInt("select CurHouseCardCount from agent where ID = ? ", ID);
		} else {
			// 是会员
			remainingSum = Db.queryInt("SELECT card FROM tbl_player where id = ? ", ID);
		}
		// 比较余额和扣除数量
		if (remainingSum >= cradNum) {
			return true;
		}
		return false;
	}

	/**
	 * 如果被扣卡人是代理则扣卡人和被扣人比较
	 * 
	 * @param agentBySession
	 *            操作人代理对象
	 * @param ID
	 *            被扣除人代理ID
	 */
	public boolean compareAgentLevel(Agent agentBySession, int ID) {
		Agent agent = agentDao.findById(ID);
		if (agentBySession.getAgentLevel() > agent.getAgentLevel()) {
			return false;
		}
		return true;
	}

	/**
	 * 查询通用property表，查询所有冻结时间选项
	 * @return 
	 */
	public List<Record> getFreezeTime() {
		return Db.find("select * from property where PropertyKey = ?",GlobalSettings.PROPERTY_KEY_FREEZETIME);
	}

}
