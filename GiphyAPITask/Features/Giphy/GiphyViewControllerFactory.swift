//
//  GiphyViewControllerFactory.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit

final class GiphyViewControllerFactory {
    func makeStockViewController() -> GiphyViewController? {
        let storyboard = UIStoryboard(name: .giphy)
        //let useCase: StockUseCase = DIContainer.resolve()
        let controller = storyboard.instantiateInitialViewController { coder in
            GiphyViewController(coder: coder, viewModel: .init(useCase: NetworkGiphyUseCase()))
        }
        
        return controller
    }
}
