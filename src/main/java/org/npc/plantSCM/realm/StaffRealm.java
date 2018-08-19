package org.npc.plantSCM.realm;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.subject.PrincipalCollection;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;

public class StaffRealm extends AuthenticatingRealm {
	
	StaffService staffService;
	
	public void setStaffService(StaffService staffService) {
		this.staffService = staffService;
	}
	/*  
	 * 1.doGetAuthenticationInfo 获取认证消息
	 * 2.AuthenticationInfo  可以使用SimpleAuthenticationInfo实现类，转给你正确的账号密码
	 * 
	 * */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		// TODO Auto-generated method stub
		
		SimpleAuthenticationInfo info = null;
		
		//1. 将token转换成UserNamePasswordToken
		UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
		//2. 获取账号
		String staffsAccount =usernamePasswordToken.getUsername();
		
		
		//3. 查询数据库，是否存在指定的用户名和密码的用户
		
		Staff staff = staffService.getStaffBySAccount(staffsAccount);
		if(staff != null) {
			Object principal =staff.getsAccount();
			Object credentials = staff.getsPassword();
			String realmName = this.getName();
			info = new SimpleAuthenticationInfo(principal, credentials, realmName);
			
		}else {
			throw new AuthenticationException();
		}
		
		return info;
	}
	
	//清除缓存
	public void clearCache(){
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        super.clearCache(principals);   

    }
	
	

}
