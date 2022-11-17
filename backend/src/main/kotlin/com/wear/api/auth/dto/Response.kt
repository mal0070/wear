package com.wear.api.auth.dto

data class Response(
    val success: Boolean,
    val message: String,
    val payload: Any? = ""
) {

    companion object {
        fun ok() = Response(success = true, message = "")
        fun success(payload: Any) = Response(success = true, message = "", payload = payload)
        fun error(message: String) = Response(success = false, message = message)
    }
}
