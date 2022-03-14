//
//  GiphyCollectionViewCell.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit

final class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var animatedImageView: UIImageView!
    
    func configure(with row: GiphyRowViewModel) {
        animatedImageView.loadAnimatedImage(with: row.url, placeHolderImageName: "placeholder")
    }
}
