//
//  GiphyResponse.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation

struct GiphyResponse: Decodable {
    let gifs: [Giphy]
    let pagination: Pagination
    
    enum CodingKeys: String , CodingKey {
        case gifs = "data", pagination
    }
}
