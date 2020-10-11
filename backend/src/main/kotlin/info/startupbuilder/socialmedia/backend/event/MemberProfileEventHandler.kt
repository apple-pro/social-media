package info.startupbuilder.socialmedia.backend.event

import info.startupbuilder.socialmedia.backend.entity.MemberProfile
import org.springframework.data.rest.core.annotation.HandleBeforeCreate
import org.springframework.data.rest.core.annotation.RepositoryEventHandler
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.oauth2.jwt.Jwt
import org.springframework.stereotype.Service


@Service
@RepositoryEventHandler(MemberProfile::class)
class MemberProfileEventHandler {

    @HandleBeforeCreate
    fun beforeCreate(memberProfile: MemberProfile) {
        val principal = SecurityContextHolder.getContext().authentication.principal as Jwt
        memberProfile.id = principal.claims["username"] as String
    }
}