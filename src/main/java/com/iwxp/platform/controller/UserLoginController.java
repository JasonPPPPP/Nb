package com.iwxp.platform.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iwxp.platform.dto.UserInfo;
import com.iwxp.platform.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by wangxp on 2017/3/1.
 */
@Controller
@Scope("prototype")
@RequestMapping("/loginCtrl")
public class UserLoginController {

    @Autowired
    private UserInfoService userInfoService;

    /**
     * 用户登录
     * @param request
     * @param username
     * @param password
     * @return
     */
    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request, String username, String password) {
        UserInfo user = userInfoService.findUser(username);
        if (user == null) {
        } else {
            if (username.equals(user.getUser_name()) && password.equals(user.getPassword())) {
                request.getSession().setAttribute("user", user);
                return "redirect:/index.jsp";
            }
        }
        return "";
    }

    /**
     * 用户登出
     * @param request
     * @param username
     * @param password
     */
    @RequestMapping("/logout")
    @ResponseBody
    public void logout(HttpServletRequest request, String username, String password) {
        request.getSession().removeAttribute("user");
        request.getSession().invalidate();
    }

    @RequestMapping(value = "/hello")
    public ModelAndView hello() {
        ModelAndView model = new ModelAndView();
        model.setViewName("toola");
        return model;
    }

    @RequestMapping(value = "/getAllUsers")
    @ResponseBody
    public String getAllUsers() {
        List<UserInfo> list = userInfoService.find();
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        try {
            json = mapper.writeValueAsString(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }
}
