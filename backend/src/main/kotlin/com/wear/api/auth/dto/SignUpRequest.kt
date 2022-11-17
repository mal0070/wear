package com.wear.api.auth.dto

data class SignUpRequest(
    val email: String,
    var password: String = "",
    val nickname: String
)
