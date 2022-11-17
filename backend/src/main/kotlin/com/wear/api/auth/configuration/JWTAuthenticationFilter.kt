package com.wear.api.auth.configuration

import com.wear.api.auth.repository.AuthRedisRepository
import com.wear.api.auth.service.AuthUserDetailService
import com.wear.api.support.JWTTokenUtil
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.util.StringUtils
import org.springframework.web.filter.OncePerRequestFilter
import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class JWTAuthenticationFilter(
    @Autowired private val jwtTokenUtil: JWTTokenUtil,
    @Autowired private val customUserDetailService: AuthUserDetailService,
    @Autowired private val authRedisRepository: AuthRedisRepository
) : OncePerRequestFilter() {

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        val accessToken = getToken(request)
        if (accessToken != null) {
            checkLogout(accessToken)
            val username: String = jwtTokenUtil.getUsername(accessToken)
            if (username != null) {
                val userDetails: UserDetails = customUserDetailService.loadUserByUsername(username)
                equalsUsernameFromTokenAndUserDetails(userDetails.username, username)
                validateAccessToken(accessToken, userDetails)
                processSecurity(request, userDetails)
            }
        }
        filterChain.doFilter(request, response)
    }

    private fun getToken(request: HttpServletRequest): String? {
        val headerAuth = request.getHeader("Authorization")
        return if (StringUtils.hasText(headerAuth) && headerAuth.startsWith("Bearer ")) {
            headerAuth.substring(7)
        } else null
    }

    private fun checkLogout(accessToken: String) {
        require(!authRedisRepository.existsById(accessToken)) { "이미 로그아웃된 회원입니다." }
    }

    private fun equalsUsernameFromTokenAndUserDetails(userDetailsUsername: String, tokenUsername: String) {
        require(userDetailsUsername == tokenUsername) { "username이 토큰과 맞지 않습니다." }
    }

    private fun validateAccessToken(accessToken: String, userDetails: UserDetails) {
        require(jwtTokenUtil.validateToken(accessToken, userDetails)) { "토큰 검증 실패" }
    }

    private fun processSecurity(request: HttpServletRequest, userDetails: UserDetails) {
        val usernamePasswordAuthenticationToken =
            UsernamePasswordAuthenticationToken(userDetails, null, userDetails.authorities)
        usernamePasswordAuthenticationToken.details = WebAuthenticationDetailsSource().buildDetails(request)
        SecurityContextHolder.getContext().authentication = usernamePasswordAuthenticationToken
    }
}
