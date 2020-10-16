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
    
    @State var errorMessage = ""
    @State var user = ""
    @State var accessToken = ""
    
    var body: some View {
        TabView {
            Timeline().tabItem {
                Image(systemName: "house.fill")
            }
            
            Settings().tabItem {
                Image(systemName: "play.rectangle.fill").accentColor(.red)
            }
            
            Settings().tabItem {
                Image(systemName: "cart.fill")
            }
            
            Settings().tabItem {
                Image(systemName: "bell.fill")
            }
            
            Settings().tabItem {
                Image(systemName: "gearshape.fill")
            }
        }
    }
    
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard()
    }
}
