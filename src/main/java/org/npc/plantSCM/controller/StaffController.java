package org.npc.plantSCM.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;
import org.npc.plantSCM.vo.CommonDTO;
import org.npc.plantSCM.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;





@Controller
public class StaffController {
	
	@Autowired
	private StaffService staffService;
	
	@RequestMapping("/login")
	@ResponseBody
	public CommonDTO login(@RequestBody Staff staff){	
		
		CommonDTO data=new CommonDTO();
		Subject currentUser =SecurityUtils.getSubject();
		
		Staff s = staffService.getStaffBySAccount(staff.getsAccount());
		
		
		//如果已登录过,先踢出
		if(currentUser.isAuthenticated() == true) {
			currentUser.logout();
		}
		
		//判断是否登录认证过
		if(currentUser.isAuthenticated() == false) {
			
			//获取前端用户输入的值，与realm类中获取数据库的值稍后进行对比
			UsernamePasswordToken token =new UsernamePasswordToken(staff.getsAccount(),staff.getsPassword());
			
			try {
				currentUser.login(token);  //将StaffRealm 中的info 与token进行比对
			}catch(AuthenticationException e) {
				data=new CommonDTO(Result.UNKNOWN_ACCOUNT_ERROR);
				
			//	System.out.println("data是   "+data);
				
				
				//System.out.println("登录失败。。。。"+	token.getUsername()+"  "+token.getPassword());
				//跳转到 登录页面重新登录
				return data;
			}
		}	
		data.setResult(s.getStaffName());
		
		System.out.println("data:   "+ s.getStaffName());
		data.setCode(0);
		//data.setMsg("");
		return data;
	}
	

	
	//获取Subject类型的实例

	
	/*@RequestMapping("/login")
	public String login(@RequestParam("sAccount") String sAccount, @RequestParam("sPassword") String sPassword) {
		
		Subject currentUser =SecurityUtils.getSubject();
		
		if(currentUser.isAuthenticated() == false) {
			UsernamePasswordToken token =new UsernamePasswordToken(sAccount, sPassword);
			
			try {
				currentUser.login(token);
			}catch(AuthenticationException e) {
				System.out.println("登录失败。。。。"+	token.getUsername()+"  "+token.getPassword());
				return "error";
			}
		}
		return "success";
	}*/
}
