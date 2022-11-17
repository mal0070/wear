package com.wear.api.auth.repository

import com.wear.api.auth.entity.RefreshToken

import org.springframework.data.repository.CrudRepository

interface RefreshTokenRepository : CrudRepository<RefreshToken, String>
