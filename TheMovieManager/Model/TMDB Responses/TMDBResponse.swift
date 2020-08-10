//
//  TMDBResponse.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation



struct TMDBResponse : Codable {
    let statusCode : Int
    let statusMessage : String
    enum codindKeys : String , CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
