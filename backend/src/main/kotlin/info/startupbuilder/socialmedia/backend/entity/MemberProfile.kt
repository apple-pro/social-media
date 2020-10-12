package info.startupbuilder.socialmedia.backend.entity

import javax.persistence.Entity
import javax.persistence.Id

@Entity
class MemberProfile (

        @Id
        var id: String?,

        var firstName: String,
        var middleName: String,
        var lastName: String,
        var gender: String,

        var email: String
)