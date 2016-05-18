package com.wangfj.search.utils;

import com.alibaba.fastjson.JSON;
import com.wfj.search.utils.signature.json.rsa.JsonSigner;
import com.wfj.search.utils.signature.json.rsa.StandardizingUtil;
import org.jetbrains.annotations.NotNull;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.SignatureException;

/**
 * <p>create at 16-5-18</p>
 *
 * @author liufl
 * @since 1.0.0
 */
public abstract class SignatureHandler {
    public static String sign(@NotNull JSON json, @NotNull PrivateKey privateKey, @NotNull String caller,
            @NotNull String username) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {
        return StandardizingUtil.standardize(JsonSigner.wrapSignature(json, privateKey, caller, username));
    }
}
