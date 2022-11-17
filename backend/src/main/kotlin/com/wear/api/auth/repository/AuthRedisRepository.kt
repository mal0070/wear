package com.wear.api.auth.repository

import com.wear.api.auth.entity.LogoutAccessToken
import org.springframework.data.repository.CrudRepository

interface AuthRedisRepository : CrudRepository<LogoutAccessToken, String>
