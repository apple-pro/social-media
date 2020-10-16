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
    case signedIn(MemberProfile)
    case signedOut
}

class ApplicationStateObserver: ObservableObject {
    
    public static let instance = ApplicationStateObserver()
    
    @Published var userState: ApplicationState = .unknown
    
    private let aws = AWSMobileClient.default()
    private let api = BackendAPI.instance
    
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
            createMemberIfNotExist()
        case .signedOut:
            DispatchQueue.main.async {
                self.userState = .signedOut
            }
        default:
            aws.signOut()
        }
    }
    
    private func createMemberIfNotExist() {
        
        aws.getUserAttributes { (maybeUserAttributes, error) in
            guard let userAttributes = maybeUserAttributes else { fatalError("No User attributes") }
            
            // TODO - i am sure theres a non-string way to access the attribute map
            let id = userAttributes["sub"]!
            
            self.api.getById(id: id) { (result: Result<MemberProfile, Error>) in
                switch result {
                case .success(let member):
                    DispatchQueue.main.async {
                        self.userState = .signedIn(member)
                    }
                case .failure:
                    self.createUser()
                }
            }
        }
    }
    
    private func createUser() {
        
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
            self.api.save(resource: member) { (result: Result<MemberProfile, Error>) in
                switch result {
                case .success:
                    self.createMemberIfNotExist()
                case .failure:
                    self.aws.signOut()
                }
            }
        }
    }
}
