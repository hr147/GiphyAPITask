//
//  GiphyResponse+Mock.swift
//  GiphyAPITaskTests
//
//  Created by hrasheed on 14.03.22.
//

import Foundation
@testable import GiphyAPITask

extension Pagination {
    static func mock(count: Int = 0, offset: Int = 0, total: Int = 0) -> Self {
        .init(count: count, offset: offset, total: total)
    }
}

extension GiphyResponse {
    static func mock(
        gifs: [Giphy] = [],
        pagination: Pagination = .mock()
    ) -> Self {
        .init(
            gifs: gifs,
            pagination: pagination
        )
    }
}
