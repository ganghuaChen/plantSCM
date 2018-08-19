package org.npc.plantSCM.vo;

import org.npc.plantSCM.vo.Result;

public class CommonDTO {
	
	
	@Override
	public String toString() {
		return "CommonDTO [code=" + code + ", msg=" + msg + ", result=" + result + "]";
	}

	private int code;
	private String msg;
	private Object result;
	
	public CommonDTO(){
		
	}
	
	public CommonDTO(Result result){
		this.code=result.getCode();
		this.msg=result.getMsg();
	}
	
	public int getCode() {
		return code;
	}
	
	public void setCode(int code) {
		this.code = code;
	}
	
	public String getMsg() {
		return msg;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public Object getResult() {
		return result;
	}
	
	public void setResult(Object result) {
		this.result = result;
	}
	

}
