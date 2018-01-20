package com.matete.agentmanage.common;

import com.jfinal.config.Routes;
import com.matete.agentmanage.controller.*;

/**
 * 后台路由
 */
public class AdminRoute extends Routes {

    @Override
    public void config() {
        setBaseViewPath("/WEB-INF/view");
        add("/frame", FrameController.class, "/frame");
        add("/", AccountController.class, "/account");
        add("/member", MemberController.class, "/member");
        add("/agent", AgentController.class, "/agent");
        add("/recharge", RechargeController.class, "/recharge ");
        add("/manage", ManageController.class, "/manage ");
        add("/operationNote", OperationNoteController.class, "/operationNote ");
        add("/gameManage", GameManageController.class, "/gameManage ");
    }

}
