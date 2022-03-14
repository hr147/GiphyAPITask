//
//  UIImageView+Nuke.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import UIKit
import Nuke
import FLAnimatedImage

extension UIImageView {
    func loadAnimatedImage(with url: URL?, placeHolderImageName: String) {
        image = UIImage(named: placeHolderImageName)
        
        guard let url = url else {
            return
        }
        
        guard let animatedImageView = self as? FLAnimatedImageView else {
            preconditionFailure("ImageView must be inherited from `FLAnimatedImageView`")
        }
        
        let options = ImageLoadingOptions(placeholder: UIImage(named: placeHolderImageName))
        
        Nuke.loadImage(with: url, options: options, into: animatedImageView)
    }
    
    
    func animationBegin() {
        guard let animatedImageView = self as? FLAnimatedImageView else {
            preconditionFailure("ImageView must be inherited from `FLAnimatedImageView`")
        }
        
        animatedImageView.startAnimating()
    }
    
    func animationEnd() {
        guard let animatedImageView = self as? FLAnimatedImageView else {
            preconditionFailure("ImageView must be inherited from `FLAnimatedImageView`")
        }
        
        animatedImageView.stopAnimating()
    }
}

