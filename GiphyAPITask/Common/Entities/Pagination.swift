//
//  Pagination.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation

struct Pagination: Decodable {
    let count: Int
    let offset: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case count, offset, total = "total_count"
    }
}
