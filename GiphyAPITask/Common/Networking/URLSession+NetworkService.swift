//
//  URLSession+NetworkService.swift
//  GiphyAPITask
//
//  Created by hrasheed on 28.02.22.
//

import Foundation
import Combine


//https://api.giphy.com/v1/gifs/trending?api_key=4qkmgUUmt4cB4Wf04lXmejzhmSYS1VSy&limit=25&rating=g

extension Endpoint {
    func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = "/v1/gifs/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}

struct InvalidEndpointError: LocalizedError {
    let endpoint: Endpoint
}

extension URLSession: NetworkService {
    func publisher<T: Decodable>(
        for endpoint: Endpoint,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        guard let request = endpoint.makeRequest() else {
            let error = InvalidEndpointError(endpoint: endpoint)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
