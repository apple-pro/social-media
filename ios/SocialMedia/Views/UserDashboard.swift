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
    
    let user: String = ""
    
    var body: some View {
        VStack {
            Text("Hello \(aws.username!)")
            
            Button("Bye!") {
                aws.signOut()
            }
            
            Button("Access Token!") {
                aws.getTokens { (tokens, error) in
                    print("Tokens: \(tokens!)")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard()
    }
}
