//
//  File.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit

final class GiphyCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        let factory = GiphyViewControllerFactory()
        guard let giphyViewController = factory.makeGiphyViewController(with: self) else {
            return assertionFailure()
        }
        
        rootViewController.pushViewController(giphyViewController, animated: true)
    }
}

extension GiphyCoordinator: GiphyNavigator {
    func showDetail(with giphy: Giphy) {
        let factory = GiphyViewControllerFactory()
        guard let giphyDetailViewController = factory.makeGiphyDetailViewController(with: giphy) else {
            return assertionFailure()
        }
        
        rootViewController.pushViewController(giphyDetailViewController, animated: true)
    }
}
