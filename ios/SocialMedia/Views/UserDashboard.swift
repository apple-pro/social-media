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
    
    @State var user = ""
    @State var accessToken = ""
    
    var body: some View {
        VStack {
            Text("Hello \(aws.username!)")
            
            TextField("Access Token", text: $accessToken)
            
            Button("Bye!") {
                aws.signOut()
            }
            
            Button("Access Token!") {
                aws.getTokens { (tokens, error) in
                    accessToken = tokens?.accessToken?.tokenString ?? "ERROR"
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
