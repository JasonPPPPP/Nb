package com.iwxp.platform.service;

import com.iwxp.platform.dao.UserInfoMapper;
import com.iwxp.platform.dto.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserInfoService {
    @Autowired
    public UserInfoMapper userInfoMapper;


    public List<UserInfo> find() {
        return userInfoMapper.find();
    }
    public UserInfo findUser(String username){return userInfoMapper.findUser(username);}


}
