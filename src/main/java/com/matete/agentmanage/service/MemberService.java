package com.matete.agentmanage.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.matete.agentmanage.common.GlobalSettings;
import com.matete.agentmanage.model.MemberAgent;
import com.matete.agentmanage.model.Player;

public class MemberService {

	// public static final Accountuserinfo accountuserinfoDao = new Accountuserinfo().dao(); // 旧的表

	public static final Player playerDao = new Player().dao();

	/**
	 * 查询会员数据
	 * 
	 * @param agentID
	 *            代理ID
	 * @param pageIndex
	 *            分页时当前页码
	 * @param searchContent
	 *            搜索内容(ID/微信昵称)
	 * @return
	 */
	public Page<Record> getMemberRecord(int agentID, int pageIndex, String searchContent) {
		// String selectSql = "select
		// a.GameID,a.SecurityID,a.SecretAnswer,a.GeneralizedID,a.NickName,a.Account,a.IdentityID,a.Name,a.LastLoginTime,a.OfflineTime,a.isAndroid,a.LastLoginIp,a.RegistrationTime,a.RegisterDevice,a.StateID,a.sex,a.loginDevice,a.serviceip,a.serviceport,a.backyards,a.avatar,r.Score,r.Wins,r.Fields,r.Escape,r.GameTime,r.GameCount,r.OnlinGameTime,r.gold";
		// if (StringUtils.isNotBlank(searchContent)) {
		// Page<Record> members = null;
		// members = Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
		// "from accountuserinfo a,roomcard r,member_agent m where a.GameID =
		// r.GameID and a.GameID = m.GameID and a.GameID = ? and m.agentID = ?",
		// searchContent, agentID);
		// // 如果没查到数据，那么members中lisi集合长度为0
		// if (members.getList().size() == 0) {
		// members = Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
		// "from accountuserinfo a,roomcard r,member_agent m where a.GameID =
		// r.GameID and a.GameID = m.GameID and a.NickName like ? and m.agentID
		// = ?",
		// "%" + searchContent + "%", agentID);
		// }
		// return members;
		// }
		// return Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
		// "from accountuserinfo a,roomcard r,member_agent m where a.GameID =
		// r.GameID and a.GameID = m.GameID and m.agentID = ? order by
		// a.GameID",
		// agentID);
		// 会员表更换
		String selectSql = "select p.*";
		if (StringUtils.isNotBlank(searchContent)) {
			Page<Record> members = null;
			members = Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
					"FROM tbl_player p , member_agent m where p.id = m.GameID AND m.agentID = ? AND p.id = ?", agentID,
					searchContent);
			// 如果没查到数据，那么members中lisi集合长度为0
			if (members.getList().size() == 0) {
				members = Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
						"FROM tbl_player p , member_agent m where p.id = m.GameID AND m.agentID = ? AND p.name LIKE ?",
						agentID, "%" + searchContent + "%");
			}
			return members;
		}
		return Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
				"FROM tbl_player p , member_agent m where p.id = m.GameID AND m.agentID = ?", agentID);
	}

	/**
	 * 查询会员总卡数
	 * 
	 * @param agentID
	 * @return
	 */
	public List<Record> getMemberRoomCard(int agentID) {
		String sql = "SELECT r.ToId GameID, SUM(r.RechargeCount) sumRechargeCount FROM record_recharge r WHERE r.type = ? GROUP BY r.ToId";
		// 查询代理下级会员的总充值房卡数量
		List<Record> rechargeRecord = Db.find(sql, GlobalSettings.RECORD_RECHARGE);
		// 查询代理下级会员被扣除的总房卡数量
		List<Record> deductRecord = Db.find(sql, GlobalSettings.RECORD_DEDUCT);
		// 总房卡 - 扣除的房卡
		for (Record recharge : rechargeRecord) {
			for (Record deduct : deductRecord) {
				int id1 = recharge.getInt("GameID");
				int id2 = deduct.getInt("GameID");
				if (id1 == id2) {
					recharge.set("sumRechargeCount", recharge.getBigDecimal("sumRechargeCount").intValue()
							- deduct.getBigDecimal("sumRechargeCount").intValue());
				}
			}
		}
		return rechargeRecord;
	}

	/**
	 * 根据id查询会员
	 * 
	 * @param memberID
	 *            会员id
	 * @return
	 */
	public boolean getMember(int memberID) {
		// Accountuserinfo member = accountuserinfoDao.findById(memberID); //更换了会员表
		Player member = playerDao.findById(memberID);
		if (member == null) {
			return false;
		}
		return true;
	}

	/**
	 * 查看是否被冻结
	 * 
	 * @param memberID
	 */
	public boolean seeIfFreeze(int memberID) {
		int stateID = playerDao.findById(memberID).getStatus();
		if (stateID == GlobalSettings.MEMBER_STATUS_FREEZE) {
			return true;
		}
		return false;
	}

	/**
	 * 冻结指定会员
	 * 
	 * @param memberID
	 * @param thawTime
	 *            解封日期
	 * @return
	 */
	public boolean freezeMember(int memberID, long thawTime) {
		return playerDao.findById(memberID).setStatus(GlobalSettings.MEMBER_STATUS_FREEZE).setForbidTime(String.valueOf(thawTime)).update();
	}

	/**
	 * 绑定会员
	 * 
	 * @param memberID
	 * @param agentID
	 */
	public int boundMember(int memberID, int agentID) {
		// 查看是否存在该会员
		// Record record = Db.findFirst("select *from accountuserinfo where
		// GameID = ?", memberID);
		if (!getMember(memberID)) {
			// 不存在
			return GlobalSettings.BOUND_MEMBER_INEXISTENCE;
		}
		// 查看会员是否已经绑定该代理
		Record record = Db.findFirst("select *from member_agent where GameID = ? and agentID = ?", memberID, agentID);
		if (record != null) {
			// 已绑定
			return GlobalSettings.BOUND_MEMBER_BE;
		}
		// 查看会员能否在绑定新代理
		long num = Db.queryLong("select count(GameID)from member_agent where GameID = ?", memberID);
		if (num == GlobalSettings.MEMBER_AGENT_TOPLIMIT) {
			// 达到上限
			return GlobalSettings.BOUND_MEMBER_RESTRICT;
		}
		// 给会员绑定代理
		boolean b = new MemberAgent().setGameID(memberID).setAgentID(agentID).save();
		if (b) {
			// 绑定成功
			return GlobalSettings.BOUND_MEMBER_SUCCEE;
		}
		// 绑定失败
		return GlobalSettings.BOUND_MEMBER_ERROR;
	}

	/**
	 * 查询所有被冻结的会员
	 * 
	 * @param pageIndex
	 * @param searchContent
	 * @return
	 */
	public Page<Record> getFreezeMemberList(int pageIndex, String searchContent) {
		// String selectSql = "select
		// a.GameID,a.SecurityID,a.SecretAnswer,a.GeneralizedID,a.NickName,a.Account,a.IdentityID,a.Name,a.LastLoginTime,a.OfflineTime,a.isAndroid,a.LastLoginIp,a.RegistrationTime,a.RegisterDevice,a.StateID,a.sex,a.loginDevice,a.serviceip,a.serviceport,a.backyards,a.avatar,r.Score,r.Wins,r.Fields,r.Escape,r.GameTime,r.GameCount,r.OnlinGameTime,r.gold";
		// if (StringUtils.isNotBlank(searchContent)) {
		// Page<Record> members = null;
		// // 这里每页的条数是五条，硬编码
		// members = Db.paginate(pageIndex, 5, selectSql,
		// "from accountuserinfo a,roomcard r where a.GameID = r.GameID and
		// a.StateID = ? and a.GameID = ?",
		// GlobalSettings.MEMBER_STATUS_FREEZE, searchContent);
		// // 如果没查到数据，那么members中lisi集合长度为0
		// if (members.getList().size() == 0) {
		// members = Db.paginate(pageIndex, 5, selectSql,
		// "from accountuserinfo a,roomcard r where a.GameID = r.GameID and
		// a.StateID = ? and a.NickName like ?",
		// GlobalSettings.MEMBER_STATUS_FREEZE, "%" + searchContent + "%");
		// }
		// return members;
		// }
		// return Db.paginate(pageIndex, 5, selectSql,
		// "FROM accountuserinfo a,roomcard r WHERE a.GameID = r.GameID and
		// a.StateID = ? ORDER BY a.GameID",
		// GlobalSettings.MEMBER_STATUS_FREEZE);
		// 会员表更换
		String selectSql = "select p.*";
		if (StringUtils.isNotBlank(searchContent)) {
			Page<Record> members = null;
			members = Db.paginate(pageIndex, 4, selectSql, "FROM tbl_player p where p.status = ? AND p.id = ?",
					GlobalSettings.MEMBER_STATUS_FREEZE, searchContent);
			// 如果没查到数据，那么members中lisi集合长度为0
			if (members.getList().size() == 0) {
				members = Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql,
						"FROM tbl_player p where p.status = ? AND p.name LIKE ?", GlobalSettings.MEMBER_STATUS_FREEZE,
						"%" + searchContent + "%");
			}
			return members;
		}
		return Db.paginate(pageIndex, GlobalSettings.PAGE_SIZE, selectSql, "FROM tbl_player p WHERE p.status = ?",
				GlobalSettings.MEMBER_STATUS_FREEZE);
	}

	/**
	 * 解冻会员
	 * 
	 * @param manageID
	 */
	public void thawMember(int manageID) {
		playerDao.findById(manageID).setStatus(GlobalSettings.MEMBER_STATUS).setForbidTime(null).update();
	}

}
