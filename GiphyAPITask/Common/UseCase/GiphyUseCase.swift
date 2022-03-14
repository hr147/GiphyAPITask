//
//  GiphyUseCase.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation
import Combine

protocol GiphyUseCase {
    func fetchImages(with page: Page) -> AnyPublisher<GiphyResponse, Error>
}

final class NetworkGiphyUseCase: GiphyUseCase {
    private let service: NetworkService
    
    init(service: NetworkService = URLSession.shared) {
        self.service = service
    }
    
    func fetchImages(with page: Page) -> AnyPublisher<GiphyResponse, Error> {
        service.publisher(for: .trending(with: page))
    }
}


