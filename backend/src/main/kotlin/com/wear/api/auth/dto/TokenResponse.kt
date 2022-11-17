package com.wear.api.auth.dto

data class TokenResponse(
    val accessToken: String,
    val refreshToken: String
) {
    companion object {
        fun of(accessToken: String, refreshToken: String) = TokenResponse(
            accessToken = accessToken,
            refreshToken = refreshToken
        )
    }
}
