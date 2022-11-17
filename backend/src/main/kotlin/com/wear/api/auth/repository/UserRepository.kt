package com.wear.api.auth.repository

import com.wear.api.auth.entity.AppUser
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface UserRepository : CrudRepository<AppUser, Long> {
    fun findByEmail(email: String): AppUser

    fun findByUsername(username: String): AppUser

    @Query("select m from AppUser m join fetch m.authorities a where m.username = :username")
    fun findByUsernameWithAuthority(username: String): AppUser
}
