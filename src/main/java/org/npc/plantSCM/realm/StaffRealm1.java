package org.npc.plantSCM.realm;

import java.util.HashSet;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.subject.PrincipalCollection;
import org.npc.plantSCM.po.Staff;
import org.npc.plantSCM.service.StaffService;

public class StaffRealm1 extends AuthorizingRealm {
	
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
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// TODO Auto-generated method stub
		//返回值: AuthorizationInfo, 封装获取的用户所对应的所有角色, SimpleAuthenticationInfo(Set<String>)
		//参数列表: PrincipalCollection 登录的身份,登录的用户名
		
		SimpleAuthorizationInfo info = null;
		
		//1. 将token转换成UserNamePasswordToken
		
		//2. 获取账号
		String staffsAccount =principals.toString();
		
		
		//3. 查询数据库，是否存在指定的用户名和密码的用户
		//实际上是获取的是 登录用户所对应得角色名, 权限不设置也没关系
		Staff staff = staffService.getStaffBySAccount(staffsAccount);
		if(staff != null) {
			Set<String> roles =new HashSet<String>();
			roles.add(  staff.getRole().getRoleName() );
			info =new SimpleAuthorizationInfo( roles);
			
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
