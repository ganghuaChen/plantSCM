package org.npc.plantSCM.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

//拥有权限之一就可以访问 下面注释的是拥有全部权限才可以访问
/*配置时这样配置
 * <property name="filters">
            <map>
                <entry key="anyPerms" value-ref="anyPermissionsAuthorizationFilter"/>
            </map>
        </property>   
        
        /admin/add = anyPerms["admin:delete","admin:add"]  */
public class AnyPermissionsAuthorizationFilter extends AuthorizationFilter {

	@Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

        Subject subject = getSubject(request, response);

        String[] perms = (String[]) mappedValue;

        for (String perm : perms) {

            if (subject.isPermitted(perm)) {

                return true;
            }
        }

        return false;
    }

	

 

}

/*package org.npc.plantSCM.filter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

public class PermissionsAuthorizationFilter extends AuthorizationFilter {


    //TODO - complete JavaDoc
	@Override
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {

        Subject subject = getSubject(request, response);
        String[] perms = (String[]) mappedValue;
        boolean isPermitted = true;
        if (perms != null && perms.length > 0) {
            if (perms.length == 1) {
                if (!subject.isPermitted(perms[0])) {
                    isPermitted = false;
                }
            } else {
                if (!subject.isPermittedAll(perms)) {
                    isPermitted = false;
                }
            }
        }
        return isPermitted;

    }



}*/