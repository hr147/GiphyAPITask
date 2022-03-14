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

extension Endpoint {
    static func trending(with page: Page) -> Self {
        .init(
            path: "trending",
            queryItems: [
                .apiKeyItem,
                .init(name: "limit", value: String(page.limit)),
                .init(name: "offset", value: String(page.offset)),
                .init(name: "rating", value: "g")
            ]
        )
    }
}
