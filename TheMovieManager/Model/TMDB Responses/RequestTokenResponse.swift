//
//  RequestTokenResponse.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation


struct RequestTokenResponse : Codable {
    var success : Bool
   var expiresAt : String
    var requestToken : String
    
    
    
    enum CodingKeys : String , CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
