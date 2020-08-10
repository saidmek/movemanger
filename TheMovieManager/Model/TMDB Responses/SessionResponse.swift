//
//  SessionResponse.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.

import Foundation


struct SessionResponse: Codable {
    
  let success: Bool
     let sessionId: String
     
     enum CodingKeys: String, CodingKey {
         case success
         case sessionId = "session_id"
     }
    
}
