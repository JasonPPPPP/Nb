package com.iwxp.platform.dao;

import com.iwxp.platform.dto.UserInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserInfoMapper {
    List<UserInfo> find();

    UserInfo findUser(String username);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);
}