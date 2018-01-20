package com.matete.agentmanage.runnable;


/**
 * 任务调度类
 * 
 * @author wjp
 *
 */
public class DelRunnable implements Runnable {
	@Override
	public void run() {
		// HttpServletRequest
		System.out.println("我被执行了");
	}

}
