package com.wear.api.auth.entity

import org.springframework.security.core.GrantedAuthority
import javax.persistence.*

@Entity
class Authority(
    @Id
    @GeneratedValue
    @Column(name = "AUTHORITY_ID")
    private var id: Long = 0,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    private var user: AppUser? = null,

    var role: String = ""

) : GrantedAuthority {
    override fun getAuthority(): String = role

    companion object {
        fun ofUser(member: AppUser): Authority = Authority(user = member, role = "ROLE_USER")
    }
}
