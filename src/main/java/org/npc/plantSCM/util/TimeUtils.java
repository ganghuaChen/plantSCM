package org.npc.plantSCM.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtils {
	public static String format(long time){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
		return sdf.format(new Date(time));
	}
	
	public static Long parse(String staffNumPrefix) throws ParseException {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
		return sdf.parse(staffNumPrefix).getTime();
	}
	
	public static void main(String[] args) throws ParseException {
		//format(1497974400000L)
		System.out.println(parseD("20170611"));
		System.out.println(formatD(1497110400000L));
		System.out.println(formatD(20171030L));
		System.out.println(formatD(201710301L));
		System.out.println(formatD(20171120341L));
	}

	//新增日
	public static String formatD(long time){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		return sdf.format(new Date(time));
	}

	
	public static Long parseD(String staffNumPrefix) throws ParseException {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		return sdf.parse(staffNumPrefix).getTime();
	}
}
