package com.wangfj.security.httpuilt;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <br/>create at 16-4-8
 *
 * @author liuxh
 * @since 1.1.19
 */
public class SimpleHttpRequester extends HttpRequester {
    private static final Logger logger = LoggerFactory.getLogger(SimpleHttpRequester.class);

    private SimpleHttpRequester() {
    }

    public static SimpleHttpRequester getHttpRequester() {
        return new SimpleHttpRequester();
    }

    @Override
    CloseableHttpClient getHttpClient() {
        return HttpClients.createDefault();
    }
}
