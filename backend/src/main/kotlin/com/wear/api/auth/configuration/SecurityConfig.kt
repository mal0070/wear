package com.wear.api.auth.configuration

import com.wear.api.auth.service.AuthUserDetailService
import com.wear.api.support.path.Path
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.builders.WebSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter

@Configuration
@EnableWebSecurity
class SecurityConfig(
    @Autowired private val jwtEntryPoint: JWTEntryPoint,
    @Autowired private val jwtAuthenticationFilter: JWTAuthenticationFilter,
    @Autowired private val authUserDetailService: AuthUserDetailService
) : WebSecurityConfigurerAdapter() {
    override fun authenticationManager(): AuthenticationManager {
        return super.authenticationManagerBean()
    }

    @Bean
    fun passwordEncoder(): PasswordEncoder {
        return BCryptPasswordEncoder()
    }

    override fun configure(web: WebSecurity) {
        web.ignoring().antMatchers("/h2-console/**", "/favicon.ico")
    }

    override fun configure(http: HttpSecurity) {
        http
            .cors()
            .and()
            .csrf().disable()
            .authorizeRequests()
            // TODO("Path.V1.AUTH.REISSUE 이거는 빼도 되는지 확인")
            .antMatchers(*Path.SWAGGER_UI).permitAll()
            .antMatchers(
                Path.V1.AUTH.SIGN_IN, Path.V1.AUTH.SIGN_UP, Path.HEALTH_CHECK, Path.V1.AUTH.REISSUE
            ).permitAll()
            .anyRequest().hasRole("USER")
            .and()
            .exceptionHandling()
            .authenticationEntryPoint(jwtEntryPoint)
            .and()
            .logout().disable()
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter::class.java)
    }

    override fun configure(auth: AuthenticationManagerBuilder) {
        auth.userDetailsService(authUserDetailService).passwordEncoder(passwordEncoder())
    }
}
