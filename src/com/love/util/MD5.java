package com.love.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class MD5 {
	public static String encode(String str) {
		byte[] secretBytes = null;
		try {
			secretBytes = MessageDigest.getInstance("md5").digest(str.getBytes());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String code = new BigInteger(1, secretBytes).toString(16);
        int len = code.length();
        for (int i = 0;i < 32 - len;++i) {
            code = "0" + code;
        }
        return code;
	}
}
