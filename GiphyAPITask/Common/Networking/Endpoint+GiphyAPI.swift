//
//  Endpoint+WeatherAPI.swift
//  GiphyAPITask
//
//  Created by hrasheed on 28.02.22.
//

import Foundation

extension URLQueryItem {
    static let apiKeyItem = Self(name: "api_key", value: "4qkmgUUmt4cB4Wf04lXmejzhmSYS1VSy")
}

struct GiphyAPIQuery {
    let limit: Int
    let offset: Int
}
//trending?api_key=4qkmgUUmt4cB4Wf04lXmejzhmSYS1VSy&limit=25&rating=g
extension Endpoint {
    static func trending(with query: GiphyAPIQuery) -> Self {
        .init(
            path: "trending",
            queryItems: [
                .apiKeyItem,
                .init(name: "limit", value: String(query.limit)),
                .init(name: "offset", value: String(query.offset)),
                .init(name: "rating", value: "g")
            ]
        )
    }
}
