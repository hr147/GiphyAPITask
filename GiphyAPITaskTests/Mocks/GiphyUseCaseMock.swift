//
//  GiphyUseCaseMock.swift
//  GiphyAPITaskTests
//
//  Created by hrasheed on 14.03.22.
//

import UIKit
import Combine
@testable import GiphyAPITask

final class GiphyUseCaseMock: GiphyUseCase {
    private(set) var fetchImagesDidCall = false
    let fetchImagesSubject = PassthroughSubject<GiphyResponse, Error>()
    
    func fetchImages(with page: Page) -> AnyPublisher<GiphyResponse, Error> {
        fetchImagesDidCall = true
        return fetchImagesSubject.eraseToAnyPublisher()
    }
}
