package com.wear.api.auth.exception

class AuthException(message: String = defaultMessage) : RuntimeException(message) {
    companion object {
        const val defaultMessage = ""
    }
}
