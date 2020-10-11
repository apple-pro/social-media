package info.startupbuilder.socialmedia.backend.event

import info.startupbuilder.socialmedia.backend.entity.MemberProfile
import org.springframework.data.rest.core.annotation.HandleBeforeCreate
import org.springframework.data.rest.core.annotation.RepositoryEventHandler
import org.springframework.stereotype.Service


@Service
@RepositoryEventHandler(MemberProfile::class)
class MemberProfileEventHandler {

    @HandleBeforeCreate
    fun beforeCreate(memberProfile: MemberProfile) {
        memberProfile.id
    }
}