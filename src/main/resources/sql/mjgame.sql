/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : mjgame

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2017-08-07 18:06:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for agent
-- ----------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE `agent` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '代理ID(推广码)',
  `Name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `Phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `QQ` varchar(11) DEFAULT NULL COMMENT 'QQ号',
  `Password` varchar(50) DEFAULT NULL COMMENT '密码',
  `AgentLevel` int(1) DEFAULT NULL COMMENT '代理级别0:公司，1:地区代理，2:二级代理，3:三级代理',
  `TotalHouseCardCount` int(50) DEFAULT '0' COMMENT '总房卡数量',
  `CurHouseCardCount` int(50) DEFAULT '0' COMMENT '当前房卡数量',
  `ParentId` int(11) DEFAULT NULL COMMENT '上级代理Id',
  `State` int(1) DEFAULT '0' COMMENT '帐号状态0:待审核，1:审核通过',
  `MaxAgentCount` int(11) DEFAULT '0' COMMENT '最大代理数量',
  `AgentCount` int(11) DEFAULT '0' COMMENT '已代理数量',
  `CreateTime` datetime DEFAULT NULL COMMENT '本代理创建时间',
  `LoginStatus` int(1) DEFAULT '0' COMMENT '登录状态转换（0,1,）登录时如果是0就改为1，1改0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=100029 DEFAULT CHARSET=utf8 COMMENT='代理人表';

-- ----------------------------
-- Records of agent
-- ----------------------------
INSERT INTO `agent` VALUES ('1001', 'admin', '12345678910', '', 'e10adc3949ba59abbe56e057f20f883e', '0', '300000', '99000', null, '1', '1000', '3', '2017-07-03 15:52:32', '1');
INSERT INTO `agent` VALUES ('100026', '王玩玩', '18156614551', '1130829012', 'e10adc3949ba59abbe56e057f20f883e', '1', '0', '0', '1001', '1', '100', '0', '2017-07-04 10:17:37', '1');
INSERT INTO `agent` VALUES ('100027', '王玩玩', '18010495874', '1130829013', 'e10adc3949ba59abbe56e057f20f883e', '3', '0', '11', '1001', '1', '0', '0', '2017-07-21 14:08:26', '0');
INSERT INTO `agent` VALUES ('100028', '大煞笔', '18301219732', '11546423', 'e10adc3949ba59abbe56e057f20f883e', '3', '0', '0', '1001', '1', '111', '0', '2017-07-21 18:09:26', '0');

-- ----------------------------
-- Table structure for function
-- ----------------------------
DROP TABLE IF EXISTS `function`;
CREATE TABLE `function` (
  `ID` int(20) NOT NULL COMMENT '权限ID',
  `MenuName` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `AccessoryPath` varchar(100) DEFAULT NULL COMMENT '访问路径',
  `ClassForm` varchar(20) DEFAULT NULL COMMENT '菜单图标样式（父级ID拥有）',
  `Priority` int(10) DEFAULT '0' COMMENT '优先级',
  `PID` int(20) DEFAULT NULL COMMENT '父级ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of function
-- ----------------------------
INSERT INTO `function` VALUES ('1', '我的信息', '/frame', 'fa fa-home', '0', null);
INSERT INTO `function` VALUES ('2', '我的会员', '/member', 'fa fa-tasks', '0', null);
INSERT INTO `function` VALUES ('11', '我的代理', '', 'fa fa-male', '0', null);
INSERT INTO `function` VALUES ('12', '充值', '', 'fa fa-yen', '0', null);
INSERT INTO `function` VALUES ('13', '管理代理&会员', '', 'fa fa-users', '0', null);
INSERT INTO `function` VALUES ('14', '操作记录', '', 'fa fa-cogs', '0', null);
INSERT INTO `function` VALUES ('15', '游戏系统管理', '', 'fa fa-wrench', '0', null);
INSERT INTO `function` VALUES ('112', '增加代理', '/agent/addUI', null, '1', '11');
INSERT INTO `function` VALUES ('113', '代理列表', '/agent', null, '2', '11');
INSERT INTO `function` VALUES ('121', '充值房卡', '/recharge', null, '1', '12');
INSERT INTO `function` VALUES ('122', '充值记录', '/recharge/rechargeRecordUI', null, '2', '12');
INSERT INTO `function` VALUES ('131', '减少房卡', '/manage', null, '1', '13');
INSERT INTO `function` VALUES ('132', '冻结账户', '/manage/blockedAccountUI', null, '2', '13');
INSERT INTO `function` VALUES ('133', '代理审核', '/agent/agentAuditing', null, '3', '13');
INSERT INTO `function` VALUES ('141', '登录记录', '/operationNote', null, '1', '14');
INSERT INTO `function` VALUES ('151', '广告系统', '/gameManage', null, '1', '15');
INSERT INTO `function` VALUES ('152', '公告系统', '/gameManage/gameAfficheUI', null, '2', '15');
INSERT INTO `function` VALUES ('153', '角色管理', '/gameManage/roleManageUI', null, '3', '15');

-- ----------------------------
-- Table structure for function_role
-- ----------------------------
DROP TABLE IF EXISTS `function_role`;
CREATE TABLE `function_role` (
  `ID` int(20) NOT NULL AUTO_INCREMENT COMMENT '权限-角色表ID',
  `RoleID` int(20) DEFAULT NULL COMMENT '角色ID',
  `FunctionID` int(20) DEFAULT NULL COMMENT '权限ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of function_role
-- ----------------------------
INSERT INTO `function_role` VALUES ('88', '2', '1');
INSERT INTO `function_role` VALUES ('89', '2', '2');
INSERT INTO `function_role` VALUES ('90', '2', '11');
INSERT INTO `function_role` VALUES ('91', '2', '112');
INSERT INTO `function_role` VALUES ('92', '2', '113');
INSERT INTO `function_role` VALUES ('93', '2', '12');
INSERT INTO `function_role` VALUES ('94', '2', '121');
INSERT INTO `function_role` VALUES ('95', '2', '122');
INSERT INTO `function_role` VALUES ('96', '2', '13');
INSERT INTO `function_role` VALUES ('97', '2', '131');
INSERT INTO `function_role` VALUES ('98', '2', '132');
INSERT INTO `function_role` VALUES ('99', '2', '14');
INSERT INTO `function_role` VALUES ('100', '2', '141');
INSERT INTO `function_role` VALUES ('101', '1', '1');
INSERT INTO `function_role` VALUES ('102', '1', '2');
INSERT INTO `function_role` VALUES ('103', '1', '11');
INSERT INTO `function_role` VALUES ('104', '1', '112');
INSERT INTO `function_role` VALUES ('105', '1', '113');
INSERT INTO `function_role` VALUES ('106', '1', '12');
INSERT INTO `function_role` VALUES ('107', '1', '121');
INSERT INTO `function_role` VALUES ('108', '1', '122');
INSERT INTO `function_role` VALUES ('109', '1', '13');
INSERT INTO `function_role` VALUES ('110', '1', '131');
INSERT INTO `function_role` VALUES ('111', '1', '132');
INSERT INTO `function_role` VALUES ('112', '1', '133');
INSERT INTO `function_role` VALUES ('113', '1', '14');
INSERT INTO `function_role` VALUES ('114', '1', '141');
INSERT INTO `function_role` VALUES ('115', '1', '15');
INSERT INTO `function_role` VALUES ('116', '1', '151');
INSERT INTO `function_role` VALUES ('117', '1', '152');
INSERT INTO `function_role` VALUES ('118', '3', '1');
INSERT INTO `function_role` VALUES ('119', '3', '2');
INSERT INTO `function_role` VALUES ('120', '3', '12');
INSERT INTO `function_role` VALUES ('121', '3', '121');
INSERT INTO `function_role` VALUES ('122', '3', '122');
INSERT INTO `function_role` VALUES ('123', '3', '14');
INSERT INTO `function_role` VALUES ('124', '3', '141');

-- ----------------------------
-- Table structure for member_agent
-- ----------------------------
DROP TABLE IF EXISTS `member_agent`;
CREATE TABLE `member_agent` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `GameID` int(20) DEFAULT NULL COMMENT '会员ID',
  `agentID` int(20) DEFAULT NULL COMMENT '上级代理ID',
  `bindingtime` datetime DEFAULT NULL COMMENT '绑定时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='这是会员表附属表，会员代理关系表';

-- ----------------------------
-- Records of member_agent
-- ----------------------------
INSERT INTO `member_agent` VALUES ('23', '100001', '1002', null);
INSERT INTO `member_agent` VALUES ('24', '100001', '100026', null);
INSERT INTO `member_agent` VALUES ('25', '10942', '1001', null);
INSERT INTO `member_agent` VALUES ('26', '10943', '1001', null);
INSERT INTO `member_agent` VALUES ('27', '10944', '1001', null);
INSERT INTO `member_agent` VALUES ('28', '10945', '1001', null);
INSERT INTO `member_agent` VALUES ('29', '10946', '1001', null);
INSERT INTO `member_agent` VALUES ('30', '10939', '1001', null);
INSERT INTO `member_agent` VALUES ('31', '100001', '1001', null);

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `PropertyKey` varchar(20) DEFAULT NULL COMMENT '属性key',
  `PropertyValue` int(11) DEFAULT NULL COMMENT '属性值',
  `PropertyName` varchar(50) DEFAULT NULL COMMENT '属性名',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of property
-- ----------------------------
INSERT INTO `property` VALUES ('1', 'AgentStatus', '0', '待审核');
INSERT INTO `property` VALUES ('2', 'AgentStatus', '1', '审核通过');
INSERT INTO `property` VALUES ('10', 'AgentLevel', '0', '公司账号');
INSERT INTO `property` VALUES ('11', 'AgentLevel', '1', '合作伙伴');
INSERT INTO `property` VALUES ('12', 'AgentLevel', '2', '二级代理');
INSERT INTO `property` VALUES ('13', 'AgentLevel', '3', '三级代理');
INSERT INTO `property` VALUES ('20', 'Device', '0', '移动端');
INSERT INTO `property` VALUES ('21', 'Device', '1', 'PC端');
INSERT INTO `property` VALUES ('30', 'Recharge', '100000', '开通100,000张');
INSERT INTO `property` VALUES ('31', 'Recharge', '30000', '开通30,000张');
INSERT INTO `property` VALUES ('32', 'Recharge', '15000', '5,000送10,000');
INSERT INTO `property` VALUES ('33', 'Recharge', '3200', '1,200送2,000');
INSERT INTO `property` VALUES ('34', 'Recharge', '1000', '400送600');
INSERT INTO `property` VALUES ('35', 'Recharge', '350', '150送200');
INSERT INTO `property` VALUES ('36', 'Recharge', '120', '100送20');
INSERT INTO `property` VALUES ('37', 'Recharge', '48', '40送8');
INSERT INTO `property` VALUES ('38', 'Recharge', '20', '开通20张');
INSERT INTO `property` VALUES ('40', 'Announcement', '0', '广告公告');
INSERT INTO `property` VALUES ('41', 'Announcement', '1', '系统公告');
INSERT INTO `property` VALUES ('42', 'Announcement', '2', '滚动公告');
INSERT INTO `property` VALUES ('43', 'Announcement', '3', '大厅公告');
INSERT INTO `property` VALUES ('44', 'Announcement', '4', '充值公告');
INSERT INTO `property` VALUES ('50', 'FreezeTime', '1', '冻结一天');
INSERT INTO `property` VALUES ('51', 'FreezeTime', '3', '冻结三天');
INSERT INTO `property` VALUES ('52', 'FreezeTime', '7', '冻结七天');
INSERT INTO `property` VALUES ('53', 'FreezeTime', '31', '冻结一个月');
INSERT INTO `property` VALUES ('54', 'FreezeTime', '93', '冻结三个月');
INSERT INTO `property` VALUES ('55', 'FreezeTime', '1095', '永久冻结');

-- ----------------------------
-- Table structure for rechargerecord
-- ----------------------------
DROP TABLE IF EXISTS `rechargerecord`;
CREATE TABLE `rechargerecord` (
  `GameID` int(20) DEFAULT NULL COMMENT '充值记录表id不为主键',
  `ScoreCount` int(50) DEFAULT NULL COMMENT '充值房卡数量',
  `RechargeTime` tinytext COMMENT '充值时间',
  `AgentGameID` int(20) DEFAULT NULL COMMENT '代理人id',
  `OddNumbers` varchar(30) DEFAULT NULL COMMENT '单号',
  `money` int(30) DEFAULT NULL COMMENT '充值金额',
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `invitecode` int(20) DEFAULT NULL COMMENT '邀请码',
  `state` int(10) DEFAULT NULL COMMENT '充值状态1成功2失败',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rechargerecord
-- ----------------------------

-- ----------------------------
-- Table structure for record_login
-- ----------------------------
DROP TABLE IF EXISTS `record_login`;
CREATE TABLE `record_login` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `AgentId` int(11) DEFAULT NULL COMMENT '代理ID',
  `LoginIp` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `DeviceId` int(1) DEFAULT NULL COMMENT '登录设备 0:移动端，1：PC端',
  `Place` varchar(50) DEFAULT NULL COMMENT '登录地点',
  `CreateTime` datetime DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=409 DEFAULT CHARSET=utf8 COMMENT='登录记录表';

-- ----------------------------
-- Records of record_login
-- ----------------------------
INSERT INTO `record_login` VALUES ('303', '1001', '0:0:0:0:0:0:0:1', '1', '未知', '2017-07-03 15:54:01');


-- ----------------------------
-- Table structure for record_recharge
-- ----------------------------
DROP TABLE IF EXISTS `record_recharge`;
CREATE TABLE `record_recharge` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `RechargeIP` varchar(50) DEFAULT NULL COMMENT '操作人IP',
  `RechargeCount` int(20) DEFAULT NULL COMMENT '（扣除/充值）数量',
  `AgentId` int(11) DEFAULT NULL COMMENT '操作（充值/扣除）ID',
  `RechargeObject` int(1) DEFAULT NULL COMMENT '充值(扣除)对象(会员：1，代理：0)',
  `ToId` int(11) DEFAULT NULL COMMENT '被(充值/扣除)ID（代理或会员ID）',
  `Type` int(1) DEFAULT NULL COMMENT '充值类型（扣除房卡：0，充值房卡：1）',
  `CreateTime` datetime DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='充值记录表(包含充值和扣除)';

-- ----------------------------
-- Records of record_recharge
-- ----------------------------
INSERT INTO `record_recharge` VALUES ('10', '0:0:0:0:0:0:0:1', '3200', '1001', '0', '100026', '1', '2017-07-05 14:32:59');
INSERT INTO `record_recharge` VALUES ('11', '0:0:0:0:0:0:0:1', '120', '1001', '1', '10939', '1', '2017-07-18 13:17:02');
INSERT INTO `record_recharge` VALUES ('12', '0:0:0:0:0:0:0:1', '100000', '1001', '1', '100001', '1', '2017-07-19 15:23:30');
INSERT INTO `record_recharge` VALUES ('13', '0:0:0:0:0:0:0:1', '100', '1001', '1', '100001', '0', '2017-07-19 17:46:24');
INSERT INTO `record_recharge` VALUES ('14', '0:0:0:0:0:0:0:1', '1000', '1001', '1', '100001', '1', '2017-07-19 17:46:58');
INSERT INTO `record_recharge` VALUES ('15', '0:0:0:0:0:0:0:1', '20', '1001', '1', '100001', '0', '2017-07-19 17:57:55');
INSERT INTO `record_recharge` VALUES ('16', '0:0:0:0:0:0:0:1', '100000', '1001', '1', '100001', '1', '2017-07-21 09:17:18');
INSERT INTO `record_recharge` VALUES ('17', '0:0:0:0:0:0:0:1', '3200', '1001', '0', '100026', '0', '2017-07-21 10:00:36');
INSERT INTO `record_recharge` VALUES ('18', '0:0:0:0:0:0:0:1', '11', '100027', '1', '100001', '0', '2017-07-21 14:11:22');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` int(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `RoleID` int(1) DEFAULT NULL COMMENT '角色ID（代理级别，0：公司，1：地区，2：二级，3：三级）',
  `RoleName` varchar(20) DEFAULT NULL COMMENT '角色名',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10004 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('10000', '0', 'admin');
INSERT INTO `role` VALUES ('10001', '1', '省区域');
INSERT INTO `role` VALUES ('10002', '2', '市区');
INSERT INTO `role` VALUES ('10003', '3', '县镇');

-- ----------------------------
-- Table structure for tbl_notice
-- ----------------------------
DROP TABLE IF EXISTS `tbl_notice`;
CREATE TABLE `tbl_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentID` int(11) DEFAULT NULL COMMENT '发布人ID',
  `state` int(11) DEFAULT NULL COMMENT '公告类型',
  `title` varchar(255) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(255) DEFAULT NULL COMMENT '公告内容',
  `startTime` bigint(20) DEFAULT NULL COMMENT '公告发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公告表';

-- ----------------------------
-- Records of tbl_notice
-- ----------------------------
INSERT INTO `tbl_notice` VALUES ('1', '1001', '2', null, '1111', '1500609600000');
INSERT INTO `tbl_notice` VALUES ('2', '1001', '0', '111', '111', '1500613200000');
INSERT INTO `tbl_notice` VALUES ('3', '1001', '0', 'nihsuo', 'nishuo', '1500613200000');
INSERT INTO `tbl_notice` VALUES ('4', '1001', '4', '充钱送钱啦~', '冲多少送多少啦~大家赶紧冲冲冲', '1501326000000');
INSERT INTO `tbl_notice` VALUES ('5', '1001', '1', '多少人啊', '是打发点', '1501570800000');
INSERT INTO `tbl_notice` VALUES ('6', '1001', '3', '这是大厅公告', '大家注意', '1500624000000');

-- ----------------------------
-- Table structure for tbl_player
-- ----------------------------
DROP TABLE IF EXISTS `tbl_player`;
CREATE TABLE `tbl_player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(50) DEFAULT NULL COMMENT '微信号',
  `name` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `head` varchar(500) DEFAULT NULL COMMENT '头像连接',
  `card` int(11) DEFAULT '0' COMMENT '当前房卡数',
  `cardConsume` int(11) DEFAULT '0' COMMENT '总消耗房卡数',
  `room` int(11) DEFAULT NULL COMMENT '房间',
  `ip` varchar(50) DEFAULT NULL COMMENT '上次登录ip',
  `points` int(11) unsigned zerofill DEFAULT NULL COMMENT '扣分',
  `total` int(11) DEFAULT NULL COMMENT '总计数',
  `forbidTime` varchar(50) DEFAULT NULL COMMENT '封号时间',
  `sex` varchar(50) DEFAULT NULL COMMENT '性别',
  `haveNewEmail` int(11) DEFAULT NULL COMMENT '有无新邮件',
  `unionid` varchar(50) DEFAULT NULL COMMENT '微信登录成功返回的信息',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `loginTime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `channel` int(11) DEFAULT NULL COMMENT '渠道',
  `version` int(11) DEFAULT NULL COMMENT '最后一次使用客户端版本',
  `inviteId` int(11) DEFAULT NULL COMMENT '邀请码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100002 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of tbl_player
-- ----------------------------
INSERT INTO `tbl_player` VALUES ('100001', 'hhhwjp', '童稚', 'http://qlogo3.store.qq.com/qzone/939588518/939588518/100', '201089', '0', null, null, null, null, '1500947369808', '男', null, null, '安徽', '池州', '中国', '2017-07-18 16:12:55', '0', '2017-07-19 10:33:45', null, null, null);

-- ----------------------------
-- Procedure structure for CreatUsers
-- ----------------------------
DROP PROCEDURE IF EXISTS `CreatUsers`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatUsers`(IN Account VARCHAR(20),IN NickName VARCHAR(20),IN RegistrationTime VARCHAR(20),IN Sex VARCHAR(20),IN Score INT, IN gold INT)
BEGIN
	DECLARE stmt VARCHAR(2000);
      SET @sqlstr=CONCAT(" INSERT INTO `mjgame`.`accountuserinfo`
            (  
            `Account`,  
             `NickName`,            
             `sex`,                              
             `RegistrationTime`,           
             
                  )
VALUES (
        '"+Account+"',
	'"+NickName+"',
       '"+sex+"',       
        '"+RegistrationTime+"',       
        );
        insert into mjgame.`roomcard`('Score','gold')values('"+Score+"','"+gold+"');"); 
     PREPARE stmt FROM @sqlstr;
    
     EXECUTE stmt;
     
    END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for demo
-- ----------------------------
DROP PROCEDURE IF EXISTS `demo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `demo`(IN WeChatAccount VARCHAR(20))
BEGIN  
     DECLARE stmt VARCHAR(2000);
     SET @sqlstr=CONCAT("SELECT * from accountuserinfo where WeChatAccount ='",WeChatAccount,"'");
     PREPARE stmt FROM @sqlstr;
     EXECUTE stmt;
    END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for FindOneUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `FindOneUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FindOneUser`(IN Account VARCHAR(20))
BEGIN
 DECLARE stmt VARCHAR(2000);
SET @sqlstr=CONCAT("SELECT accountuserinfo.`GameID`,accountuserinfo.`NickName`, accountuserinfo.`generalizeid`,accountuserinfo.`LastLoginTime`,accountuserinfo.`serviceip`,accountuserinfo.`serviceport`,accountuserinfo.`sex`,accountuserinfo.`Account`,accountuserinfo.`RegisterDevice`,roomcard.`Score` ,roomcard.`Escape`,roomcard.`Fields`,roomcard.`GameCount`,roomcard.`GameTime`,roomcard.`gold`,roomcard.`OnlinGameTime`,roomcard.`Wins` FROM accountuserinfo,roomcard WHERE accountuserinfo.`Account`='",Account,"'");
     PREPARE stmt FROM @sqlstr;
     EXECUTE stmt;
     END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for quaryWeChatAccount
-- ----------------------------
DROP PROCEDURE IF EXISTS `quaryWeChatAccount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `quaryWeChatAccount`(in WeChatAccount varchar(20))
BEGIN
     DECLARE stmt VARCHAR(2000);
     SET @sqlstr=CONCAT("SELECT * from accountuserinfo where WeChatAccount ='",WeChatAccount,"'");
     PREPARE stmt FROM @sqlstr;
     EXECUTE stmt;
    END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for querylogineQuipment
-- ----------------------------
DROP PROCEDURE IF EXISTS `querylogineQuipment`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `querylogineQuipment`(IN WeChatAccount VARCHAR(20))
BEGIN
	 DECLARE stmt VARCHAR(2000);
     SET @sqlstr=CONCAT("SELECT * from accountuserinfo where logineQuipment ='",WeChatAccount,"'");
     PREPARE stmt FROM @sqlstr;
     EXECUTE stmt;
    END
;;
DELIMITER ;
