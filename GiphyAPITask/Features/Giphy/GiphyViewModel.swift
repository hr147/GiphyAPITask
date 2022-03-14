//
//  GiphyViewModel.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import Combine
import Foundation

enum GiphyViewState: Equatable {
    case message(String)
    case showRows([GiphyRowViewModel])
}

protocol GiphyNavigator {
    func showDetail(with giphy: Giphy)
}

class GiphyViewModel {
    let screenTitle = NSLocalizedString("giphy_screen_title", comment: "")
    private(set) lazy var output = outputSubject.eraseToAnyPublisher()
    
    //MARK: - Private Properties
    
    private let outputSubject = PassthroughSubject<GiphyViewState, Never>()
    private var cancellable = Set<AnyCancellable>()
    private var totalRows: [GiphyRowViewModel] = []
    private let useCase: GiphyUseCase
    private let navigator: GiphyNavigator
    private let offset = 25
    private var currentPageNo = 0
    private let maxPageLimit = 20
    private var isLoading = false
    
    
    init(useCase: GiphyUseCase, navigator: GiphyNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: - Public Methods
    
    func viewDidLoad() {
        fetchImages()
    }
    
    func willDisplayRow(atIndex index: Int) {
        if isLoading == false, index + 1 == totalRows.count, currentPageNo <= maxPageLimit {
            fetchImages()
        }
    }
    
    func didSelectRow(atIndex index: Int) {
        navigator.showDetail(with: totalRows[index].giphy)
    }
    
    // MARK: - Private Methods
    
    private func makePage() -> Page {
        .init(limit: offset, offset: offset * currentPageNo)
    }
    
    private func fetchImages() {
        isLoading = true
        
        useCase.fetchImages(with: makePage()).sink { [weak self] completion in
            self?.isLoading = false
            guard case let .failure(error) = completion else {
                return
            }
            
            self?.outputSubject.send(.message(error.localizedDescription))
        } receiveValue: { [weak self] response in
            self?.isLoading = false
            self?.process(response)
        }
        .store(in: &cancellable)
    }
    
    private func process(_ response: GiphyResponse) {
        //convert into Set to avoid duplicated images
        currentPageNo += 1
        let gifs = Set(response.gifs)
        let rows = gifs.map(GiphyRowViewModel.init)
        totalRows += rows
        outputSubject.send(.showRows(totalRows))
    }
}
