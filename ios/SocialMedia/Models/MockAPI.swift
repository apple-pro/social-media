//
//  Mock.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/11/20.
//

import Foundation

class MockAPI: API {
    
    static let instance: API = MockAPI()
    
    private init() {}
    
    func save<T:Resource>(resource: T, completionHandler: (T) -> Void) {
        if let result: T = mockCreateResponse.toJSON() {
            completionHandler(result)
        }
    }
    
    func search<T>(page: PageRequest, completionHandler: PageCompletionHandler<T>) {
        
    }
    
}

//try this guide
//https://www.avanderlee.com/swift/json-parsing-decoding/
extension String {
    func toJSON<T:Decodable>() -> T? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false)
        else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

let mockSearchResponse = """
{
  "_embedded": {
    "memberProfiles": [
      {
        "firstName": "Lyndon",
        "lastName": "Bibera",
        "email": "secret.transaction@gmail.com",
        "_links": {
          "self": {
            "href": "http://localhost:8080/memberProfiles/401b288e-9ff6-4747-9cc9-42e731b81e0c"
          },
          "memberProfile": {
            "href": "http://localhost:8080/memberProfiles/401b288e-9ff6-4747-9cc9-42e731b81e0c"
          }
        }
      }
    ]
  },
  "_links": {
    "self": {
      "href": "http://localhost:8080/memberProfiles"
    },
    "profile": {
      "href": "http://localhost:8080/profile/memberProfiles"
    }
  },
  "page": {
    "size": 20,
    "totalElements": 1,
    "totalPages": 1,
    "number": 0
  }
}
"""

let mockCreateResponse = """
{
  "firstName": "Lyndon",
  "lastName": "Bibera",
  "email": "secret.transaction@gmail.com",
  "_links": {
    "self": {
        "href": "http://localhost:8080/memberProfiles/401b288e-9ff6-4747-9cc9-42e731b81e0c"
      },
      "memberProfile": {
        "href": "http://localhost:8080/memberProfiles/401b288e-9ff6-4747-9cc9-42e731b81e0c"
      }
  }
}
"""
