package com.wear.api.auth.entity

import com.wear.api.auth.dto.SignUpRequest
import java.util.UUID
import javax.persistence.*

@Entity
class AppUser(
    @Id @GeneratedValue @Column(name = "USER_ID")
    var id: Long = 0,

    @Column(unique = true)
    val username: String,

    @Column(unique = true)
    val email: String,

    val password: String,

    @Column(unique = true)
    val nickname: String,

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    var authorities: MutableSet<Authority> = mutableSetOf()

) {

    val roles: List<String> get() = authorities.map { it.role }.toList()

    companion object {
        fun ofUser(signUpRequest: SignUpRequest): AppUser = AppUser(
            username = UUID.randomUUID().toString(),
            email = signUpRequest.email,
            password = signUpRequest.password,
            nickname = signUpRequest.nickname,
        ).apply {
            this.authorities.add(Authority.ofUser(this))
        }
    }
}
