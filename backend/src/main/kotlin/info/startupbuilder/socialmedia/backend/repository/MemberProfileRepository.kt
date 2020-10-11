package info.startupbuilder.socialmedia.backend.repository

import info.startupbuilder.socialmedia.backend.entity.MemberProfile
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.security.access.prepost.PreAuthorize
import java.util.*

@PreAuthorize("isFullyAuthenticated()")
interface MemberProfileRepository : JpaRepository<MemberProfile, String>