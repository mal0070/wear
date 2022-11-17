package com.wear.api.auth.entity

import org.springframework.data.redis.core.RedisHash
import org.springframework.data.redis.core.TimeToLive
import javax.persistence.Id

@RedisHash("logoutAccessToken")
class LogoutAccessToken(
    @Id
    private var id: String = "",
    private var username: String = "",
    @TimeToLive
    private var expiration: Long = 0
) {

    companion object {
        fun of(accessToken: String, username: String, remainingMilliSeconds: Long) = LogoutAccessToken(
            id = accessToken,
            username = username,
            expiration = remainingMilliSeconds / 1000
        )
    }
}
