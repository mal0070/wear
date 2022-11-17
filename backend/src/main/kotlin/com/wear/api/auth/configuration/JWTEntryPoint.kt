package com.wear.api.auth.configuration

import com.wear.api.auth.dto.Response
import com.wear.api.support.Constants
import com.google.gson.Gson
import org.springframework.http.HttpStatus
import org.springframework.security.core.AuthenticationException
import org.springframework.security.web.AuthenticationEntryPoint
import org.springframework.stereotype.Component
import java.io.PrintWriter
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JWTEntryPoint : AuthenticationEntryPoint {
    override fun commence(
        request: HttpServletRequest,
        response: HttpServletResponse,
        authException: AuthenticationException
    ) {
        response.status = HttpStatus.UNAUTHORIZED.value()
        val writer: PrintWriter = response.writer
        writer.print(Gson().toJson(Response.error(Constants.UNAUTHORIZED)))
    }
}
