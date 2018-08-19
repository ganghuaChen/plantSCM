package org.npc.plantSCM.util;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

public class SMSUtils {
	private static String nick = "Nick13925978732";
	private static String nickKey = "8fcef9be72458a9e689e";
	private static String th = "THSB";
	private static String thKey = "3dac06df17e4e4887959";
	/**
	 * @param phoneNumber对方的手机号码
	 * @param content	要发送的内容
	 * @return	状态码，请查看:http://sms.webchinese.cn/api.shtml#top3
	 * @throws Exception
	 * 
	 */
	public static String sendSMS(String phoneNumber,String content) throws Exception{
		HttpClient client = new HttpClient();
		PostMethod post = new PostMethod("http://gbk.sms.webchinese.cn");
		post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=gbk");// 在头文件中设置转码
		NameValuePair[] data = { new NameValuePair("Uid", "plantscm"), new NameValuePair("Key", "d41d8cd98f00b204e980"),
				new NameValuePair("smsMob", phoneNumber), new NameValuePair("smsText", content) };
		post.setRequestBody(data);

		client.executeMethod(post);
		Header[] headers = post.getResponseHeaders();
		int statusCode = post.getStatusCode();
		System.out.println("返回状态码:"+statusCode);
		for (Header h : headers) {
			System.out.println(h.toString());
		}
		String result = new String(post.getResponseBodyAsString().getBytes("gbk"));
		System.out.println(result); // 打印返回消息状态
		post.releaseConnection();
		return result;
	}
	
	public static void main(String[] args) throws Exception {
		String code=sendSMS("13631435762", "朱正廷订单 焊片 不足");
	}
}
