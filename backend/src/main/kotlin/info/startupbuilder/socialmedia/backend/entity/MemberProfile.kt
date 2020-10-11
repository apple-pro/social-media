package info.startupbuilder.socialmedia.backend.entity

import javax.persistence.Entity
import javax.persistence.Id

@Entity
class MemberProfile (

        @Id
        val id: String,

        var firstName: String,
        var lastName: String,

        val email: String
)