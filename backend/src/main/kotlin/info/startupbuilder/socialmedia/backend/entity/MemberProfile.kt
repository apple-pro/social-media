package info.startupbuilder.socialmedia.backend.entity

import javax.persistence.Entity
import javax.persistence.Id

@Entity
class MemberProfile (

        @Id
        var id: String?,

        var firstName: String,
        var lastName: String,

        var email: String
)