package com.wear.api.auth.exception

class InvalidTokenException(message: String = defaultMessage) : RuntimeException(message) {
    companion object {
        const val defaultMessage = "invalid token"
    }
}
