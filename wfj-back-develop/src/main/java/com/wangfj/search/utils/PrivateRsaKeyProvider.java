package com.wangfj.search.utils;

import com.wfj.search.utils.signature.ras.KeyUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.security.PrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.atomic.AtomicReference;

/**
 * <p>create at 16-5-18</p>
 *
 * @author liufl
 * @since 1.0.0
 */
public class PrivateRsaKeyProvider implements ResourceLoaderAware {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    private final AtomicReference<String> rsaPriKeyBase64String = new AtomicReference<>("");
    private final Timer timer = new Timer("privateKeyFileReload", true);
    private String privateKeyFileLocation;

    @Required
    public void setPrivateKeyFileLocation(String privateKeyFileLocation) {
        this.privateKeyFileLocation = privateKeyFileLocation;
    }

    @Override
    public void setResourceLoader(final ResourceLoader resourceLoader) {
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                try {
                    rsaPriKeyBase64String.set(IOUtils.toString(resourceLoader.getResource(privateKeyFileLocation).getInputStream()));
                } catch (IOException e) {
                    throw new IllegalStateException("加载签名私钥失败", e);
                }
            }
        }, 0L, 15000);
    }

    public PrivateKey get() {
        String keyString = rsaPriKeyBase64String.get();
        if (StringUtils.isBlank(keyString)) {
            logger.error("私钥Base64为空");
            return null;
        } else {
            try {
                return KeyUtils.base64String2RSAPrivateKey(keyString);
            } catch (InvalidKeySpecException e) {
                logger.error("不是合法私钥格式:{}", keyString, e);
                return null;
            }
        }
    }
}
