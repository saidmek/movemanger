//
//  PostSession.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation

struct PostSession : Codable {
    let requestToken: String
       
       enum CodingKeys: String, CodingKey {
           case requestToken = "request_token"
       }
}
