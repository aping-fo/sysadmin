package com.matete.agentmanage.common;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.cron4j.Cron4jPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import com.matete.agentmanage.interceptor.LoginInterceptor;
import com.matete.agentmanage.interceptor.RoleInterceptor;
import com.matete.agentmanage.model._MappingKit;
import com.matete.agentmanage.runnable.DelRunnable;
import com.matete.agentmanage.shiro.ShiroInterceptor;
import com.matete.agentmanage.shiro.ShiroPlugin;

/**
 * API引导式配置
 */
public class MainConfig extends JFinalConfig {

	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("config.txt");
		me.setDevMode(PropKit.getBoolean("devMode", false));

		// 视图类型
		me.setViewType(ViewType.JSP);

		// 参数分隔符
		me.setUrlParaSeparator("&");

		// 404错误页
		me.setError404View("/error/error404.jsp");

		// 505错误页
		me.setError500View("/error/error500.jsp");

		// RequiresGuest，RequiresAuthentication，RequiresUser验证异常，返回HTTP401状态码
		me.setErrorView(401, "login.html");
		// RequiresRoles，RequiresPermissions授权异常,返回HTTP403状态码
		me.setErrorView(403, "login.html");
	}

	// 在config配置中添加属性*
	// private Routes route = null;

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		// 并且在配置路由的最后将routes进行me的赋值*
		// this.route = me;

		me.add(new AdminRoute());

	}

	public void configEngine(Engine me) {
		// me.addSharedFunction("/common/_layout.html");
		// me.addSharedFunction("/common/_paginate.html");
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"),
				PropKit.get("password").trim());
		me.add(druidPlugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		// 所有映射在 MappingKit 中自动化搞定
		_MappingKit.mapping(arp);
		me.add(arp);
		// 配置任务调度插件
		Cron4jPlugin cp = new Cron4jPlugin();
		cp.addTask("25 * * * *", new DelRunnable());
		me.add(cp);
		// 在configPlugin方法内使用*
		// me.add(new ShiroPlugin(route));
	}

	public static DruidPlugin createDruidPlugin() {
		return new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new LoginInterceptor());
		// me.add(new RoleInterceptor());
		// 启动Shiro拦截器*
		// me.add(new ShiroInterceptor());
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		me.add(new ContextPathHandler("BASE_PATH"));
	}
}
