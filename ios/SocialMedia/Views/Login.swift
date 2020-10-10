//
//  Login.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient

struct Login: View {
    
    let aws = AWSMobileClient.default()
    
    @State var username = "lyndon.bibera@headhuntr.io"
    @State var password = "test123456"
    
    @State var errorMessage: String?
    
    var body: some View {
        Form {
            
            if let error = errorMessage {
                Text(error)
            }
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $password)
            
            Button("Login") {
                aws.signIn(username: username, password: password) { (result, error) in
                    errorMessage = error?.localizedDescription
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
