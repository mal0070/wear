package com.wear.api.auth.controller

import com.wear.api.auth.exception.InvalidTokenException
import com.wear.api.auth.service.UserService
import com.wear.api.auth.dto.*
import com.wear.api.support.JWTTokenUtil
import com.wear.api.support.path.Path
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.dao.EmptyResultDataAccessException
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*

@RestController
class AuthController(
    @Autowired private val userService: UserService,
    @Autowired private val jwtTokenUtil: JWTTokenUtil
) {

    @GetMapping(Path.HEALTH_CHECK)
    fun healthCheck(): Response = Response.ok()

    @GetMapping(Path.AUTH_HEALTH_CHECK)
    fun authHealthCheck(): Response = Response.ok()

    @PostMapping(Path.V1.AUTH.SIGN_UP)
    fun signUp(@RequestBody request: SignUpRequest): Response {
        userService.signUp(request)
        return Response.ok()
    }

    @PostMapping(Path.V1.AUTH.SIGN_IN)
    fun login(@RequestBody signInRequest: SignInRequest): Response =
        Response.success(userService.signIn(signInRequest))

    @PostMapping(Path.V1.AUTH.REISSUE)
    fun reissue(@RequestBody refreshTokenRequest: RefreshTokenRequest): Response =
        Response.success(userService.reissue(refreshTokenRequest.refreshToken))

    @PostMapping(Path.V1.AUTH.SIGN_OUT)
    fun logout(
        @RequestHeader("Authorization") accessToken: String,
        @RequestBody refreshTokenRequest: RefreshTokenRequest
    ): Response {
        val username: String = jwtTokenUtil.getUsername(JWTTokenUtil.resolveToken(accessToken))
        userService.signOut(TokenResponse.of(accessToken, refreshTokenRequest.refreshToken), username)
        return Response.ok()
    }
    @ExceptionHandler(EmptyResultDataAccessException::class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    fun dataIsNotPersistence(e: EmptyResultDataAccessException): Response =
        Response.error(e.message ?: "Exception occurred")

    @ExceptionHandler(InvalidTokenException::class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    fun invalidToken(e: InvalidTokenException): Response = Response.error(e.message ?: "invalid token")
}
