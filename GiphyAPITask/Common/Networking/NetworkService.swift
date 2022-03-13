//
//  NetworkServiceProtocol.swift
//  GiphyAPITask
//
//  Created by hrasheed on 28.02.22.
//

import Foundation
import Combine

protocol NetworkService {
    func publisher<T: Decodable>(for endpoint: Endpoint, decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

extension NetworkService {
    func publisher<T: Decodable>(for endpoint: Endpoint) -> AnyPublisher<T, Error> {
        publisher(for: endpoint, decoder: .init())
    }
}
