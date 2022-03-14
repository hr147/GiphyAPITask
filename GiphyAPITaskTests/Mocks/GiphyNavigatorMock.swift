//
//  GiphyNavigatorMock.swift
//  GiphyAPITaskTests
//
//  Created by hrasheed on 14.03.22.
//

import UIKit
@testable import GiphyAPITask

final class GiphyNavigatorMock: GiphyNavigator {
    private(set) var showDetailDidCall = false
    
    func showDetail(with giphy: Giphy) {
        showDetailDidCall = true
    }
}
