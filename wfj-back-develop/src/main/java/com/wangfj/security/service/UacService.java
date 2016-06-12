package com.wangfj.security.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.wangfj.security.pojo.AuthUserPojo;

import java.util.Set;

/**
 * <br/>created at 16-6-7
 *
 * @author liuxh
 * @since 1.2.0
 */
public interface UacService {
    AuthUserPojo getUserInfo(String username) throws UsernameNotFoundException;

    Set<GrantedAuthority> listAuthority(String username);

    boolean isValidate(String username, String password) throws Exception;
}
