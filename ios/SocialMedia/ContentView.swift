//
//  ContentView.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient

enum UserState {
    case unknown, signedIn, signedOut
}


struct ContentView: View {
    
    let aws = AWSMobileClient.default()
    
    @State var userState: UserState = .unknown
    
    var body: some View {
        ZStack {
            switch (userState) {
            case .unknown:
                Text("Social Media")
            case .signedIn:
                UserDashboard(user: "Yser")
            case .signedOut:
                Login()
            }
        }.onAppear {
            start()
        }
    }
    
    func start() {
        switch( aws.currentUserState) {
        case .signedIn:
            DispatchQueue.main.async {
                userState = .signedIn
            }
        case .signedOut:
            DispatchQueue.main.async {
                userState = .signedOut
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
