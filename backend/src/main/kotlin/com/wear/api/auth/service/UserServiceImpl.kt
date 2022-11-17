package com.wear.api.auth.service

import com.wear.api.auth.dto.SignInRequest
import com.wear.api.auth.dto.SignUpRequest
import com.wear.api.auth.dto.TokenResponse
import com.wear.api.auth.entity.AppUser
import com.wear.api.auth.entity.LogoutAccessToken
import com.wear.api.auth.entity.RefreshToken
import com.wear.api.auth.exception.InvalidTokenException
import com.wear.api.auth.repository.BlackListTokenRepository
import com.wear.api.auth.repository.RefreshTokenRepository
import com.wear.api.auth.repository.UserRepository
import com.wear.api.support.JWTTokenUtil
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class UserServiceImpl(
    @Autowired private val passwordEncoder: PasswordEncoder,
    @Autowired private val userRepository: UserRepository,
    @Autowired private val jwtTokenUtil: JWTTokenUtil,
    @Autowired private val refreshTokenRepository: RefreshTokenRepository,
    @Autowired private val blackListTokenRepository: BlackListTokenRepository
) : UserService {
    private val logger = LoggerFactory.getLogger(UserServiceImpl::class.java)

    override fun signUp(request: SignUpRequest) {
        request.password = passwordEncoder.encode(request.password)
        userRepository.save(AppUser.ofUser(request))
    }

    override fun signIn(signInRequest: SignInRequest): TokenResponse {
        val user: AppUser =
            userRepository.findByEmail(signInRequest.email)
        // TODO: 없을때는 어떤 exception return 하는지 확인하기
        checkPassword(signInRequest.password, user.password)
        val username: String = user.username
        val accessToken: String = jwtTokenUtil.generateAccessToken(username)
        val refreshToken: RefreshToken = saveRefreshToken(username)
        return TokenResponse.of(accessToken, refreshToken.refreshToken)
    }

    override fun reissue(refreshToken: String): TokenResponse {
        val tokenRequest = JWTTokenUtil.resolveToken(refreshToken)
        val username = jwtTokenUtil.getUsername(tokenRequest)
        val refreshToken = refreshTokenRepository.findById(username).orElseThrow {
            throw InvalidTokenException()
        }
        if (tokenRequest == refreshToken.refreshToken) {
            return reissueRefreshToken(tokenRequest, refreshToken.id)
        }
        throw InvalidTokenException()
    }

    override fun signOut(tokenResponse: TokenResponse, username: String) {
        val accessToken: String = JWTTokenUtil.resolveToken(tokenResponse.accessToken)
        val remainMilliSeconds = jwtTokenUtil.getRemainMilliSeconds(accessToken)
        refreshTokenRepository.deleteById(username)
        blackListTokenRepository.save(LogoutAccessToken.of(accessToken, username, remainMilliSeconds))
    }

    private fun checkPassword(rawPassword: String, findMemberPassword: String) {
        require(passwordEncoder.matches(rawPassword, findMemberPassword)) { "비밀번호가 맞지 않습니다." }
    }

    private fun saveRefreshToken(username: String): RefreshToken = refreshTokenRepository.save(
        RefreshToken.createRefreshToken(
            username,
            jwtTokenUtil.generateRefreshToken(username), JWTTokenUtil.REFRESH_TOKEN_EXPIRATION_TIME
        )
    )

    private fun getCurrentUsername(): String {
        val authentication: Authentication = SecurityContextHolder.getContext().authentication
        return authentication.principal.toString()
    }

    private fun reissueRefreshToken(refreshToken: String, username: String): TokenResponse {
        if (lessThanReissueExpirationTimesLeft(refreshToken)) {
            val accessToken = jwtTokenUtil.generateAccessToken(username)
            return TokenResponse.of(accessToken, saveRefreshToken(username).refreshToken)
        }
        return TokenResponse.of(jwtTokenUtil.generateAccessToken(username), refreshToken)
    }

    private fun lessThanReissueExpirationTimesLeft(refreshToken: String): Boolean =
        jwtTokenUtil.getRemainMilliSeconds(refreshToken) < JWTTokenUtil.REISSUE_EXPIRATION_TIME
}
