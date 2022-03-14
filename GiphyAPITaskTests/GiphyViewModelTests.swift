//
//  GiphyViewModelTests.swift
//  GiphyViewModelTests
//
//  Created by hrasheed on 07.03.22.
//

import XCTest
import Combine

@testable import GiphyAPITask

final class GiphyViewModelTests: XCTestCase {
    private var sut: GiphyViewModel!
    private var useCaseMock: GiphyUseCaseMock!
    private var navigatorMock: GiphyNavigatorMock!
    private var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        useCaseMock = .init()
        navigatorMock = .init()
        sut = .init(useCase: useCaseMock, navigator: navigatorMock)
    }
    
    override func tearDown() {
        sut = nil
        useCaseMock = nil
        navigatorMock = nil
        cancellable = []
        super.tearDown()
    }
    
    func testViewDidLoad_whenServerReturnSuccess_shouldSendShowRowsState() {
        // Given
        var currentState: GiphyViewState!
        
        sut.output.sink { _ in
        } receiveValue: { state in
            currentState = state
        }
        .store(in: &cancellable)

        
        // When
        sut.viewDidLoad()
        useCaseMock.fetchImagesSubject.send(.mock())
        
        // Then
        XCTAssertEqual(currentState, .showRows([]))
        XCTAssertTrue(useCaseMock.fetchImagesDidCall)
    }

    func testViewDidLoad_whenServerReturnFailure_shouldSendMessageState() {
        // Given
        struct MockError: LocalizedError {
            var errorDescription: String? { "error message" }
        }
        
        var currentState: GiphyViewState!
        
        sut.output.sink { completion in
        } receiveValue: { state in
            currentState = state
        }
        .store(in: &cancellable)

        
        // When
        sut.viewDidLoad()
        useCaseMock.fetchImagesSubject.send(completion: .failure(MockError()))
        
        // Then
        XCTAssertEqual(currentState, .message(MockError().localizedDescription))
    }
}
