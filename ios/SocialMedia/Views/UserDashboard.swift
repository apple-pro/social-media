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
                Image(systemName: "play.rectangle.fill")
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
    
//    func createMemberIfNotExist() {
//        errorMessage = ""
//
//        aws.getUserAttributes { (maybeUserAttributes, error) in
//            guard let userAttributes = maybeUserAttributes else { fatalError("No User attributes") }
//
//            // TODO - i am sure theres a non-string way to access the attribute map
//            let id = userAttributes["sub"]!
//
//            api.getById(id: id) { (result: Result<MemberProfile, Error>) in
//                switch result {
//                case .success(let member):
//                    user = "\(member.firstName) \(member.lastName)"
//                case .failure(let error):
//                    errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
    
//    func setupUser() {
//
//
//        aws.getUserAttributes { (maybeUserAttributes, error) in
//            guard let userAttributes = maybeUserAttributes else { fatalError("No User attributes") }
//
//            // TODO - i am sure theres a non-string way to access the attribute map
//            let id = userAttributes["sub"]!
//            let firstName = userAttributes["given_name"]!
//            let middleName = userAttributes["middle_name"]!
//            let lastName = userAttributes["family_name"]!
//            let email = userAttributes["email"]!
//            let gender = userAttributes["gender"]!
//
//            let member: MemberProfile = MemberProfile(id: id, firstName: firstName, middleName: middleName, lastName: lastName, gender: gender, email: email)
//            api.save(resource: member) { (result: Result<MemberProfile, Error>) in
//                switch result {
//                case .success(let member):
//                    print("Created Member: \(member.email)")
//                case .failure(let error):
//                    errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard()
    }
}
