//
//  Utilities.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/16/20.
//

import Foundation

extension String {
    
    var first: String {
        self.isEmpty ? "" : self.prefix(1).uppercased()
    }
}
