//
//  ContentView.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient

struct ContentView: View {
    
    let aws = AWSMobileClient.default()
    
    @State var username = "lyndon.bibera@headhuntr.io"
    @State var password = "test123456"
    
    var body: some View {
        Form {
            
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $password)
            
            Button("Login") {
                aws.getTokens { (r, e) in
                    if let result = r {
                        print(result.accessToken)
                    }
                }
                
                
                
//                aws.signIn(username: username, password: password) { (result, error) in
//                    if let r = result {
//                        print(result)
//                    }
//                    if let e = error {
//                        print(e.localizedDescription)
//                    }
//                }
                
//                aws.signOut()
            }
        }
    }
    
    func start() {
        switch( aws.currentUserState) {
        case .signedIn:
            DispatchQueue.main.async {
                print("Logged In")
            }
        case .signedOut:
            DispatchQueue.main.async {
                print("Signed Out")
            }
        default:
            AWSMobileClient.default().signOut()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
