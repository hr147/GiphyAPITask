//
//  GiphyViewModel.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import Combine
import Foundation

struct GiphyRowViewModel {
    let id: String
    let url: URL?
}

extension GiphyRowViewModel: Hashable {
//    static func == (lhs: GiphyRowViewModel, rhs: GiphyRowViewModel) -> Bool {
//            return lhs.id == rhs.id
//        }
//
//    func hash(into hasher: inout Hasher) {
//            hasher.combine(id)
//        }
}

extension GiphyRowViewModel {
    init(_ giphy: Giphy) {
        self.id = giphy.id
        self.url = .init(string: giphy.url)
    }
}

enum GiphyViewState {
    case message(String)
    case showRows([GiphyRowViewModel])
}

class GiphyViewModel {
    let screenTitle = NSLocalizedString("weather_screen_title", comment: "")
    private(set) lazy var output = outputSubject.eraseToAnyPublisher()
    
    //MARK: - Private Properties
    
    private let outputSubject = PassthroughSubject<GiphyViewState, Never>()
    private var cancellable = Set<AnyCancellable>()
    private var totalRows: [GiphyRowViewModel] = []
    private let useCase: GiphyUseCase
    private let offset = 25
    private var currentPageNo = 0
    private let maxPageLimit = 20
    private var isLoading = false
    
    
    init(useCase: GiphyUseCase) {
        self.useCase = useCase
    }
    
    func viewDidLoad() {
        fetchImages()
    }
    
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
    
    func willDisplayRow(atIndex index: Int) {
        if isLoading == false, index + 1 == totalRows.count, currentPageNo <= maxPageLimit {
            fetchImages()
        }
    }
}
