package com.wangfj.security.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import com.wangfj.security.service.UacService;

/**
 * <br/>created at 16-6-7
 *
 * @author liuxh
 * @since 1.2.0
 */
public class UacAuthenticationProvider extends DaoAuthenticationProvider {
    private static final Logger logger = LoggerFactory.getLogger(UacAuthenticationProvider.class);
    @Autowired
    private UacService uacService;

    protected void additionalAuthenticationChecks(UserDetails userDetails,
            UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        BadCredentialsException badCredentialsException = new BadCredentialsException(messages.getMessage(
                "AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"),userDetails);

        if (authentication.getCredentials() == null) {
            logger.debug("Authentication failed: no credentials provided");
            throw badCredentialsException;
        }

        try {
            if (!uacService.isValidate(userDetails.getUsername(), authentication.getCredentials().toString())) {
                logger.debug("Authentication failed: password does not match stored value");
                throw badCredentialsException;
            }
        } catch (Exception e) {
            throw badCredentialsException;
        }
    }
}
