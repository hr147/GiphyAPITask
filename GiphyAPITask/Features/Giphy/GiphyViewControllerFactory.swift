//
//  GiphyViewControllerFactory.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit

final class GiphyViewControllerFactory {
    func makeGiphyViewController(with navigator: GiphyNavigator) -> GiphyViewController? {
        let storyboard = UIStoryboard(name: .giphy)
        let useCase: GiphyUseCase = DIContainer.resolve()
        let controller = storyboard.instantiateInitialViewController { coder in
            GiphyViewController(coder: coder, viewModel: .init(useCase: useCase, navigator: navigator))
        }
        
        return controller
    }
    
    func makeGiphyDetailViewController(with giphy: Giphy) -> GiphyDetailViewController? {
        let storyboard = UIStoryboard(name: .giphyDetail)
        let controller = storyboard.instantiateInitialViewController { coder in
            GiphyDetailViewController(coder: coder, viewModel: .init(giphy: giphy))
        }
        
        return controller
    }
}
