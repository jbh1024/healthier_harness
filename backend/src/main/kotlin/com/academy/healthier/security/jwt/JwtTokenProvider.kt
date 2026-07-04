package com.academy.healthier.security.jwt

import io.jsonwebtoken.ExpiredJwtException
import io.jsonwebtoken.JwtException
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Component
import java.util.Base64
import java.util.Date

@Component
class JwtTokenProvider(
    private val jwtProperties: JwtProperties,
) {
    private val key by lazy {
        Keys.hmacShaKeyFor(Base64.getDecoder().decode(jwtProperties.secret))
    }

    fun generateAccessToken(
        userId: Long,
        email: String,
    ): String {
        val now = Date()
        val expiry = Date(now.time + jwtProperties.accessExpiry)

        return Jwts
            .builder()
            .subject(userId.toString())
            .claim("email", email)
            .issuedAt(now)
            .expiration(expiry)
            .signWith(key)
            .compact()
    }

    fun generateRefreshToken(userId: Long): String {
        val now = Date()
        val expiry = Date(now.time + jwtProperties.refreshExpiry)

        return Jwts
            .builder()
            .subject(userId.toString())
            .issuedAt(now)
            .expiration(expiry)
            .signWith(key)
            .compact()
    }

    fun getUserIdFromToken(token: String): Long = parseSubject(token).toLong()

    fun validateToken(token: String): Boolean =
        try {
            Jwts
                .parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
            true
        } catch (ignored: ExpiredJwtException) {
            false
        } catch (ignored: JwtException) {
            false
        }

    fun isTokenExpired(token: String): Boolean =
        try {
            Jwts
                .parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
            false
        } catch (ignored: ExpiredJwtException) {
            true
        } catch (ignored: JwtException) {
            false
        }

    fun getRefreshTokenExpiryMs(): Long = jwtProperties.refreshExpiry

    private fun parseSubject(token: String): String =
        Jwts
            .parser()
            .verifyWith(key)
            .build()
            .parseSignedClaims(token)
            .payload
            .subject
}
