package com.tang.interceptor;

import com.tang.utils.SystemConstant;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //session是否为空
        if(request.getSession().getAttribute(SystemConstant.LOGINUSER) == null) {
            //未登录，重定向到登录界面
            response.sendRedirect(request.getContextPath()+"/admin/login.html");
            //验证失败，拦截
            return false;
        }
        //验证通过
        return true;
    }
}
