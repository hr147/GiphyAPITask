//
//  GiphyRowViewModel.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation

struct GiphyRowViewModel: Hashable {
    var id: String {
        giphy.id
    }
    
    var url: URL? {
        .init(string: giphy.url)
    }
    
    let giphy: Giphy
    
    init(_ giphy: Giphy) {
        self.giphy = giphy
    }
}
