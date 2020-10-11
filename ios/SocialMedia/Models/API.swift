//
//  API.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/11/20.
//

import Foundation
import AWSMobileClient

typealias Resource = Identifiable & Codable
typealias CompletionHandler<T> = (T) -> Void

protocol API {
    
    // create or update a resource
    func save<T:Resource>(resource: T, completionHandler: CompletionHandler<T>)
    
    // execute a search query
    func search<T>(page: PageRequest, completionHandler: CompletionHandler<PageResults<T>>)
}

struct MemberProfile: Resource {
    
    let id: String?
    let firstName: String
    let lastName: String
    let email: String
}

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

struct PageResults<T> {
    
    struct Page {
        let size: Int
        let totalElements: Int
        let totalPages: Int
        let number: Int
    }
    
    let results: [T]
    let page: Page
}
