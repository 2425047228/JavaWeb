package com.love.util;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import java.security.Key;
import io.jsonwebtoken.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public final class JWT {
	private static final String KEY = "d5c6b5f0c0a9d26352a50a671913a6a6";
	//Sample method to construct a JWT
	/**
	 * 创建jwt加密字符串
	 * @param subject 加密内容
	 * @param timeStamp 过期时间(精确到秒)
	 */
	public static String create(String subject, long timeStamp) {
		//The JWT signature algorithm we will be using to sign the token
	    SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
	 
	    long nowMillis = System.currentTimeMillis();
	    Date now = new Date(nowMillis);
	 
	    //We will sign our JWT with our ApiKey secret
	    byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(KEY);
	    Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());
	 
	    //Let's set the JWT Claims
	    JwtBuilder builder = Jwts.builder().setId(String.valueOf(nowMillis) + "_" + Utils.getRandomString(32))
	    		                           .setIssuer("Abu Young")
	    		                           .setIssuedAt(now)
	    		                           .setSubject(subject)
	    		                           .signWith(signatureAlgorithm, signingKey);
	 
	    //if it has been specified, let's add the expiration
	    Date exp;
	    if (timeStamp > 0) {
	        exp = new Date(nowMillis + timeStamp * 1000);
	    } else {
	    	//默认30分钟过期
	    	exp = new Date(nowMillis + DateUtil.minutes(30) * 1000);
	    }
	    builder.setExpiration(exp);
	 
	    //Builds the JWT and serializes it to a compact, URL-safe string
	    return builder.compact();
	}
	
	//Sample method to validate and read the JWT
	public static Map parse(String jwt) {
	    //This line will throw an exception if it is not a signed JWS (as expected)
		Map map = new HashMap();
		Claims claims;
	    try {
	    	claims = Jwts.parser()         
	    		       .setSigningKey(DatatypeConverter.parseBase64Binary(KEY))
	    		       .parseClaimsJws(jwt).getBody();
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	return map;
	    }
	    try {
	    	map.put("id", claims.getId());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    try {
	    	map.put("issuer", claims.getIssuer());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    try {
	    	map.put("issuerAt", claims.getIssuedAt());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    try {
	    	map.put("expiration", claims.getExpiration());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    try {
	    	map.put("subject", claims.getSubject());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    return map;
	    
	}
}
