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
        guard let stockViewController = factory.makeStockViewController() else {
            return assertionFailure()
        }
        
        rootViewController.pushViewController(stockViewController, animated: true)
    }
}
