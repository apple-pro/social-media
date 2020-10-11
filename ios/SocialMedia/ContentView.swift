//
//  ContentView.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient

enum ApplicationState {
    case unknown, signedIn, signedOut
}

struct ContentView: View {
    
    let aws = AWSMobileClient.default()
    
    @State var userState: ApplicationState = .unknown
    
    var body: some View {
        ZStack {
            switch (userState) {
            case .unknown:
                Splash()
            case .signedIn:
                UserDashboard()
            case .signedOut:
                Login()
            }
        }.onAppear {
            userStateUpdates(newUserState: aws.currentUserState, userInfo: [:])
        }
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
    
    func userStateUpdates(newUserState: UserState, userInfo: [String: String]) {
        
        switch( newUserState) {
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
