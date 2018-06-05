package com.iwxp.core.login;

import com.iwxp.platform.dto.UserInfo;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by wangxp on 2017/3/8.
 */
public class LoginInteceptor extends HandlerInterceptorAdapter {
    private final String LOGIN_PATH = "/loginCtrl/login";
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String url = requestURI.substring(contextPath.length());
        if (LOGIN_PATH.equals(url)) {
            return Boolean.TRUE;
        } else {
            UserInfo user = (UserInfo)request.getSession().getAttribute("user");
            if (user == null) {
                request.getRequestDispatcher("/login.jsp").forward(request,response);
                return Boolean.FALSE;
            } else {
                return Boolean.TRUE;
            }
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}
