package com.matete.agentmanage.common.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.text.ParseException;

public class TimeUtils {
	private static String firstDay;
	private static String lastDay;

	public static void main(String[] args) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		// // 获取前月的第一天
		// Calendar cal_1 = Calendar.getInstance();// 获取当前日期
		// cal_1.add(Calendar.MONTH, -1);
		// cal_1.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		// firstDay = format.format(cal_1.getTime());
		// System.out.println("-----1------firstDay:" + firstDay);
		// // 获取前月的最后一天
		// Calendar cale = Calendar.getInstance();
		// cale.set(Calendar.DAY_OF_MONTH, 0);// 设置为1号,当前日期既为本月第一天
		// lastDay = format.format(cale.getTime());
		// System.out.println("-----2------lastDay:" + lastDay);
		//
		// // 获取当前月第一天：
		// Calendar c = Calendar.getInstance();
		// c.add(Calendar.MONTH, 0);
		// c.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		// String first = format.format(c.getTime());
		// System.out.println("===============first:" + first);
		//
		// // 获取当前月最后一天
		// Calendar ca = Calendar.getInstance();
		// ca.set(Calendar.DAY_OF_MONTH,
		// ca.getActualMaximum(Calendar.DAY_OF_MONTH));
		// String last = format.format(ca.getTime());
		// System.out.println("===============last:" + last);
		System.out.println(getSameMonthFastDay());
		System.out.println(getSameMonthFirstDay());

	}

	/**
	 * 字符串的日期格式的计算
	 */
	public static int daysBetween(String smdate, String bdate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(smdate));
		long time1 = cal.getTimeInMillis();
		cal.setTime(sdf.parse(bdate));
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);
		return Integer.parseInt(String.valueOf(between_days));
	}

	/**
	 * 获取当月第一天字符串日期
	 * 
	 * @return
	 */
	public static String getSameMonthFirstDay() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// 获取当前月第一天：
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, 0);
		c.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		String first = format.format(c.getTime());
		return first;
	}

	/**
	 * 获取当月最后一天字符串日期
	 * 
	 * @return
	 */
	public static String getSameMonthFastDay() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// 获取当前月最后一天
		Calendar ca = Calendar.getInstance();
		ca.set(Calendar.DAY_OF_MONTH, ca.getActualMaximum(Calendar.DAY_OF_MONTH));
		String last = format.format(ca.getTime());
		return last;
	}

	/**
	 * 天数转换为毫秒值
	 * 
	 * @param day
	 * @return
	 */
	public static long getFreezeTime(int day) {
		return day * 86400000L;
	}
}
