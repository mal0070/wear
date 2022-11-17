package com.wear.api.support

import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.stereotype.Component
import java.nio.charset.StandardCharsets
import java.security.Key
import java.util.*

@Component
class JWTTokenUtil {
    @Value("\${jwt.secret}")
    lateinit var secretKey: String

    fun extractAllClaims(token: String): Claims {
        return Jwts.parserBuilder()
            .setSigningKey(getSigningKey(secretKey))
            .build()
            .parseClaimsJws(token)
            .body
    }

    fun getUsername(token: String): String {
        return extractAllClaims(token).get("username", String::class.java)
    }

    private fun getSigningKey(secretKey: String): Key {
        val keyBytes: ByteArray = secretKey.toByteArray(StandardCharsets.UTF_8)
        return Keys.hmacShaKeyFor(keyBytes)
    }

    fun isTokenExpired(token: String): Boolean {
        val expiration: Date = extractAllClaims(token).expiration
        return expiration.before(Date())
    }

    fun generateAccessToken(username: String): String {
        return doGenerateToken(username, ACCESS_TOKEN_EXPIRATION_TIME)
    }

    fun generateRefreshToken(username: String): String {
        return doGenerateToken(username, REFRESH_TOKEN_EXPIRATION_TIME)
    }

    private fun doGenerateToken(username: String, expireTime: Long): String {
        val claims = Jwts.claims()
        claims["username"] = username
        return Jwts.builder()
            .setClaims(claims)
            .setIssuedAt(Date(System.currentTimeMillis()))
            .setExpiration(Date(System.currentTimeMillis() + expireTime))
            .signWith(getSigningKey(secretKey), SignatureAlgorithm.HS256)
            .compact()
    }

    fun validateToken(token: String, userDetails: UserDetails): Boolean {
        val username = getUsername(token)
        return username == userDetails.username && !isTokenExpired(token)
    }

    fun getRemainMilliSeconds(token: String): Long {
        val expiration: Date = extractAllClaims(token).expiration
        val now = Date()
        return expiration.time - now.time
    }

    companion object {
        const val ACCESS_TOKEN_EXPIRATION_TIME = 1000L * 60 * 30 // 30 min
        const val REFRESH_TOKEN_EXPIRATION_TIME = 1000L * 60 * 60 * 24 * 7 // 7 days
        const val REISSUE_EXPIRATION_TIME = 1000L * 60 * 60 * 24 * 3 // 3 days
        fun resolveToken(accessToken: String): String {
            return accessToken.substring(7)
        }
    }
}
