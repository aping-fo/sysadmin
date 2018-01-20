package com.matete.agentmanage.common;

/**
 * 常量设置
 */
public class GlobalSettings {

	/**
	 * 登录设备：PC
	 */
	public static final int DEVICEID_PC = 1;
	/**
	 * 登录设备：手机
	 */
	public static final int DEVICEID_MOBILE = 0;

	/**
	 * 分页每页默认条数
	 */
	public static final int PAGE_SIZE = 10;

	/**
	 * 代理正常登录状态
	 */
	public static final int AGENT_STATE_VIA = 1;
	/**
	 * 代理审核状态
	 */
	public static final int AGENT_STATE_AUDITING = 0;
	/**
	 * 代理登录状态
	 */
	public static final int AGENT_LOGIN_STATUS_0 = 0;
	/**
	 * 代理登录状态
	 */
	public static final int AGENT_LOGIN_STATUS_1 = 1;

	/**
	 * 代理级别(公司帐号admin)
	 */
	public static final int AGENT_LEVEL_ADMIN = 0;
	/**
	 * 代理级别(合作伙伴-->旧:地区代理)
	 */
	public static final int AGENT_LEVEL_ONE = 1;
	/**
	 * 代理级别(二级代理)
	 */
	public static final int AGENT_LEVEL_TWO = 2;
	/**
	 * 代理级别(三级代理)
	 */
	public static final int AGENT_LEVEL_THREE = 3;

	/**
	 * 添加新代理的时候,没有填写最大代理数时,默认数值
	 */
	public static final int AGENT_MAXAGENTCOUNT = 0;

	/**
	 * 被充值对象是代理
	 */
	public static final int RECHARGE_OBJECT_AGENT = 0;
	/**
	 * 被充值对象是会员
	 */
	public static final int RECHARGE_OBJECT_MEMBER = 1;
	/**
	 * 被充值对象未知
	 */
	public static final int RECHARGE_OBJECT_UNKNOWN = 2;

	/**
	 * 公司账号给自己充值只能充值的数量(与数据库property表中的Recharge值对应着一个数量)
	 */
	public static final int RECHARGE_MAX_NUMBER = 100000;

	/**
	 * 会员状态(正常)
	 */
	public static final int MEMBER_STATUS = 1;
	/**
	 * 会员状态(冻结)
	 */
	public static final int MEMBER_STATUS_FREEZE = 0;

	/**
	 * 会员能绑定代理上限(一个会员能绑定三个上级代理)
	 */
	public static final int MEMBER_AGENT_TOPLIMIT = 3;

	/**
	 * 会员绑定时,成功绑定
	 */
	public static final int BOUND_MEMBER_SUCCEE = 0;
	/**
	 * 会员绑定时,该代理已绑定(1)
	 */
	public static final int BOUND_MEMBER_BE = 1;
	/**
	 * 会员绑定时,该会员已绑定代理数达到上限(2)
	 */
	public static final int BOUND_MEMBER_RESTRICT = 2;
	/**
	 * 会员绑定时,由于某些原因绑定失败(3)
	 */
	public static final int BOUND_MEMBER_ERROR = 3;
	/**
	 * 会员不存在(-1)
	 */
	public static final int BOUND_MEMBER_INEXISTENCE = -1;
	
	/**
	 * 充值记录表 充值房卡(1)
	 */
	public static final int RECORD_RECHARGE = 1;
	/**
	 * 充值记录表 扣除房卡(0)
	 */
	public static final int RECORD_DEDUCT = 0;

	/**
	 * 公告(广告公告0)
	 */
	public static final int AFFICHE_ADVERTISEMENT = 0;
	/**
	 * 公告(系统公告1)
	 */
	public static final int AFFICHE_NEWS = 1;
	/**
	 * 公告(滚动公告2)
	 */
	public static final int AFFICHE_ROLL = 2;
	/**
	 * 公告(大厅公告3)
	 */
	public static final int AFFICHE_HALL = 3;
	/**
	 * 公告(充值公告4)
	 */
	public static final int AFFICHE_RECHARGE = 4;

	/**
	 * 提取属性:property表propertyKey值为"AgentLevel"
	 */
	public static final String PROPERTY_KEY_AGENTLEVEL = "AgentLevel";
	/**
	 * 提取属性:property表propertyKey值为"FreezeTime"
	 */
	public static final String PROPERTY_KEY_FREEZETIME = "FreezeTime";

	/**
	 * 合作伙伴的充值列表开始ID
	 */
	public static final int PROPERTY_KEY_RECHARGE_ONE = 31;
	/**
	 * 二级代理的充值列表开始ID
	 */
	public static final int PROPERTY_KEY_RECHARGE_TWO = 32;
	/**
	 * 三级代理的充值列表开始ID
	 */
	public static final int PROPERTY_KEY_RECHARGE_THREE = 35;
}
