//
//  MarkWatchlist.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/012/2019.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation


struct MarkWatchlist: Codable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist = "watchlist"
    }
    
}
