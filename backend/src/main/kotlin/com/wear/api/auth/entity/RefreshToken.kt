package com.wear.api.auth.entity

import org.springframework.data.redis.core.RedisHash
import org.springframework.data.redis.core.TimeToLive
import javax.persistence.Id

@RedisHash("refreshToken")
data class RefreshToken(
    @Id var id: String = "",
    var refreshToken: String = "",
    @TimeToLive
    private var expiration: Long = 0
) {
    companion object {
        fun createRefreshToken(username: String, refreshToken: String, remainingMilliSeconds: Long): RefreshToken =
            RefreshToken(
                id = username,
                refreshToken = refreshToken,
                expiration = remainingMilliSeconds / 1000
            )
    }
}
