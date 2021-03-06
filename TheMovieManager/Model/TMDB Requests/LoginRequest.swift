//
//  Login.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation

struct LoginRequest : Codable{
     let username: String
      let password: String
      let requestToken: String
      
      enum CodingKeys: String, CodingKey {
          case username
          case password
          case requestToken = "request_token"
      }
}
