//
//  GiphyCollectionViewCell.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit
import FLAnimatedImage
import Nuke

final class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var giphyImageView: FLAnimatedImageView!
    
    func configure(with url: String) {
        guard let url = URL(string: url) else {
            giphyImageView.image = UIImage(named: "placeholder")
            return
        }
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.33)
        )
        
        Nuke.loadImage(with: url, options: options, into: giphyImageView)
    }
}
