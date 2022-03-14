//
//  GiphyViewControllerFactory.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit

final class GiphyViewControllerFactory {
    func makeGiphyViewController() -> GiphyViewController? {
        let storyboard = UIStoryboard(name: .giphy)
        let useCase: GiphyUseCase = DIContainer.resolve()
        let controller = storyboard.instantiateInitialViewController { coder in
            GiphyViewController(coder: coder, viewModel: .init(useCase: useCase))
        }
        
        return controller
    }
}
