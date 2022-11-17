package com.wear.api.auth.service

import com.wear.api.auth.dto.AppUserDetails
import com.wear.api.auth.entity.AppUser
import com.wear.api.auth.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service

@Service
class AuthUserDetailService(
    @Autowired private val userRepository: UserRepository
) : UserDetailsService {

    override fun loadUserByUsername(username: String): UserDetails {
        val user: AppUser =
            userRepository.findByUsernameWithAuthority(username)
        return AppUserDetails.of(user)
    }
}
