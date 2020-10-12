//
//  API.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/11/20.
//

import Foundation
import AWSMobileClient
import Alamofire

//typealias Resource = Identifiable & Codable
typealias CompletionHandler<T:Resource> = (T) -> Void
typealias PageCompletionHandler<T:Resource> = (PageResults<T>) -> Void

protocol API {
    
    // create or update a resource
    func save<T:Resource>(resource: T, completionHandler: CompletionHandler<T>)
    
    // execute a search query
    func search<T>(page: PageRequest, completionHandler: PageCompletionHandler<T>)
}

// MARK: - Resource

protocol Resource: Identifiable, Codable {
    static var resourcePath: String { get }
}

//extension Resource {
//
//    var dict : [String: Any]? {
//        guard let data = try? JSONEncoder().encode(self) else { return nil }
//        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
//        return json
//    }
//}

struct MemberProfile: Resource {
    
    static let resourcePath = "memberProfiles"
    
    let id: String?
    let firstName: String
    let lastName: String
    let email: String
}

// MARK: - Pagination

struct PageRequest {
    
    enum SortDirection {
        case asc, desc
    }
    
    struct Sort {
        let field: String
        let direction: SortDirection
    }
    
    let page: Int
    let size: Int
    let sort: [SortDirection]
}

struct PageResults<T:Resource> {
    
    struct Page {
        let size: Int
        let totalElements: Int
        let totalPages: Int
        let number: Int
    }
    
    let results: [T]
    let page: Page
}

// MARK: - API Implementation

class AccessTokenProvider {
    
    public static let instance = AccessTokenProvider()
    
    let aws = AWSMobileClient.default()
    
    func provide(accessTokenReceiver: @escaping (String) -> Void) {
        aws.getTokens { (tokens, error) in
            guard let accessToken = tokens?.accessToken?.tokenString
            else { fatalError("No access token") }
            
            accessTokenReceiver(accessToken)
        }
    }
}

class BackendAPI: API {
    
    static let instance: API = BackendAPI()
    
    let accessTokenProvider = AccessTokenProvider.instance
    
    private let af: Session = {
        let manager = ServerTrustManager(evaluators: ["localhost": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default

        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    private init() {}
    
    func save<T: Resource>(resource: T, completionHandler: (T) -> Void){
        
        accessTokenProvider.provide { accessToken in
            
            let url = "https://localhost:8443/\(T.resourcePath)"
            
            let headers: HTTPHeaders = [
                .authorization(bearerToken: accessToken),
                .accept("application/json")
            ]
        
            
            self.af.request(url, method: .post, parameters: resource, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { result in
                if let json = result.data {
                    print(json)
                }
                
                if let error = result.error {
                    let description = error.localizedDescription
                    print("Error: \(description)")
                }
            }
        }
    }
        
    
    func search<T>(page: PageRequest, completionHandler: (PageResults<T>) -> Void) where T : Resource {
    }
    
}
