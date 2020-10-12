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
    let api = BackendAPI.instance
    
    @State var user = ""
    @State var accessToken = ""
    
    var body: some View {
        VStack {
            Text("Hello \(aws.username!)")
            
            TextField("Access Token", text: $accessToken)
            
            Button("Logout") {
                aws.signOut()
            }
            
            Button("Access Token!") {
                aws.getTokens { (tokens, error) in
                    accessToken = tokens?.accessToken?.tokenString ?? "ERROR"
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            setupUser()
        }
    }
    
    func setupUser() {
        aws.getUserAttributes { (maybeUserAttributes, error) in
            guard let userAttributes = maybeUserAttributes else { fatalError("No User attributes") }
            
            // TODO - i am sure theres a non-string way to access the attribute map
            let id = userAttributes["sub"]!
            let firstName = userAttributes["given_name"]!
            let middleName = userAttributes["middle_name"]!
            let lastName = userAttributes["family_name"]!
            let email = userAttributes["email"]!
            let gender = userAttributes["gender"]!
            
            let member: MemberProfile = MemberProfile(id: id, firstName: firstName, middleName: middleName, lastName: lastName, gender: gender, email: email)
            api.save(resource: member) { (result: MemberProfile) in
                print("Created: \(result)")
            }
        }
    }
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard()
    }
}
