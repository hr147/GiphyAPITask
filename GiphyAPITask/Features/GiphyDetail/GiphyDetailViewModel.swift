//
//  GiphyDetailViewModel.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation

final class GiphyDetailViewModel {
    private let giphy: Giphy
    
    var imageURL: URL? {
        URL(string: giphy.url)
    }
    
    var imageTitle: String {
        giphy.title
    }
    
    init(giphy: Giphy) {
        self.giphy = giphy
    }
}
