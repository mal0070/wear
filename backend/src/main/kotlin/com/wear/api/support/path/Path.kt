package com.wear.api.support.path

object Path {
    const val HEALTH_CHECK = "/health"
    const val AUTH_HEALTH_CHECK = "/auth-health"
    val SWAGGER_UI = arrayOf(
        /* swagger v2 */
        "/v2/api-docs",
        "/swagger-resources",
        "/swagger-resources/**",
        "/configuration/ui",
        "/configuration/security",
        "/swagger-ui.html",
        "/webjars/**",
        /* swagger v3 */
        "/v3/api-docs/**",
        "/swagger-ui/**"
    )

    object V1 {
        private const val V1 = "/v1"

        object AUTH {
            private const val DEFAULT = "$V1/auth"
            const val SIGN_IN = "$DEFAULT/signin"
            const val SIGN_UP = "$DEFAULT/signup"
            const val SIGN_OUT = "$DEFAULT/signout"
            const val REISSUE = "$DEFAULT/reissue"
        }
    }
}
