//
//  AuthenticationStateObserver.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/11/20.
//

import Foundation
import AWSMobileClient

enum ApplicationState {
    case unknown
    case signedIn
    case signedOut
}

class ApplicationStateObserver: ObservableObject {
    
    public static let instance = ApplicationStateObserver()
    
    @Published var userState: ApplicationState = .unknown
    
    private let aws = AWSMobileClient.default()
    
    private init() {
        aws.addUserStateListener(self, userStateUpdates(newUserState:userInfo:))
        userStateUpdates(newUserState: aws.currentUserState, userInfo: [:])
    }
    
    deinit {
        aws.removeUserStateListener(self)
    }
    
    private func userStateUpdates(newUserState: UserState, userInfo: [String: String]) {
        
        switch( newUserState) {
        case .signedIn:
            DispatchQueue.main.async {
                self.userState = .signedIn
            }
        case .signedOut:
            DispatchQueue.main.async {
                self.userState = .signedOut
            }
        default:
            aws.signOut()
        }
    }
}
