package com.wear.api.auth.service

import com.wear.api.auth.dto.SignInRequest
import com.wear.api.auth.dto.SignUpRequest
import com.wear.api.auth.dto.TokenResponse

interface UserService {
    fun signUp(request: SignUpRequest)
    fun signIn(loginDto: SignInRequest): TokenResponse
    fun reissue(refreshToken: String): TokenResponse
    fun signOut(tokenResponse: TokenResponse, username: String)
}
