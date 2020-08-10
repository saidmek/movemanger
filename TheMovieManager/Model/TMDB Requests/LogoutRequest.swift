//
//  Logout.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation


struct LogoutRequest : Codable {
    var sessionId : String
    
    
    enum CodingKeys : String , CodingKey {
        case sessionId = "session_id"
    }
    
}
