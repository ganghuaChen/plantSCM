package org.npc.plantSCM.vo;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

//检验规格输入的合法性并规范化

public class SpecChange {

	private CommonDTO Result=new CommonDTO();
	
	
	
	//构造函数，传入String，修改后返回CommonDTO
	public SpecChange(String inputSpec) {
		change(inputSpec);
	}
	
			
		
    public void change (String str) {
		  str= str.replace("X", "*");
		  str= str.replace("x", "*");
		  str= str.replace("。", ".");
		
		  // IsDecimal函数 验证是否匹配
		 if(IsDecimal(str)) {
		
			 String[] strArr = str.split("\\*");

			 for(int i =0; i<strArr.length;i++)	
				 strArr[i]=  subZeroAndDot(strArr[i]);		

			 str=strArr[0]+"*"+strArr[1]+"*"+strArr[2];
		
       Result.setCode(0);
       Result.setMsg("SCUUESS");
       Result.setResult(str);       
		
		 }
		 
		 else 
			Result.setCode(110);
		    Result.setMsg("规格输入有误，格式为1*2*3或1x2x3");
	}
    
    
	public String subZeroAndDot(String s){  
        if(s.indexOf(".") > 0){  
            s = s.replaceAll("0+?$", "");//去掉多余的0  
            s = s.replaceAll("[.]$", "");//如最后一位是.则去掉  
            if(Float.parseFloat( s ) > 1.0) {
             s =s.replaceAll("^0","");  //去掉前面的0
            }
        }  
        //如果是形如060这样的输入 变成60
        if(s.indexOf(".") < 0){  
            s = s.replaceAll("[.]$", "");//如最后一位是.则去掉  
            if(Float.parseFloat( s ) > 1.0) {
             s =s.replaceAll("^0","");  //去掉前面的0
            }
        }  
        return s;  
    }  
	
	public boolean IsDecimal(String str) {
		String regex = "^\\d+(\\.\\d+)?\\*\\d+(\\.\\d+)?\\*\\d+(\\.\\d+)?";
		return match(regex, str);
		}
	
	public boolean match(String regex, String str) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
		}
	public CommonDTO getResult(){
		return Result;
	}
    

}
