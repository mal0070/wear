package com.wear.api.auth.dto

import com.wear.api.auth.entity.AppUser
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

data class AppUserDetails(
    private val username: String,
    private val password: String,
    private val roles: List<String> = listOf()
) : UserDetails {
    override fun getAuthorities(): MutableCollection<out GrantedAuthority> =
        roles.map { SimpleGrantedAuthority(it) }.toMutableList()

    override fun getPassword(): String = password

    override fun getUsername(): String = username

    override fun isAccountNonExpired(): Boolean = false

    override fun isAccountNonLocked(): Boolean = false

    override fun isCredentialsNonExpired(): Boolean = false

    override fun isEnabled(): Boolean = false

    companion object {
        fun of(user: AppUser): UserDetails = AppUserDetails(
            username = user.username,
            password = user.password,
            roles = user.roles
        )
    }
}
