//
//  ContentView.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/10/20.
//

import SwiftUI
import AWSMobileClient



struct ContentView: View {
    
    @ObservedObject var authState = AuthenticationStateObserver.instance
    
    var body: some View {
        ZStack {
            switch (authState.userState) {
            case .unknown:
                Splash()
            case .signedIn:
                UserDashboard()
            case .signedOut:
                Login()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
