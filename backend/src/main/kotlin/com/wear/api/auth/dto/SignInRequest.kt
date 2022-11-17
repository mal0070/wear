package com.wear.api.auth.dto

data class SignInRequest(
    val email: String,
    var password: String = ""
)
