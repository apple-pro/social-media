//
//  UserDashboard.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient

struct UserDashboard: View {
    
    let aws = AWSMobileClient.default()
    
    let user: String
    
    var body: some View {
        VStack {
            Text("Hello \(user)")
            
            Button("Bye!") {
                aws.signOut()
            }
        }
    }
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard(user: "Test User")
    }
}
