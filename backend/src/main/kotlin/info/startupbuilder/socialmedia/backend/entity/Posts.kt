package info.startupbuilder.socialmedia.backend.entity

import java.time.LocalDateTime
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.ManyToOne

@Entity
class Posts (

        @Id
        var id: String?,

        @ManyToOne
        var owner: MemberProfile,

        var content: String,

        var datePosted: LocalDateTime
)