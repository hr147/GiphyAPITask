//
//  GiphyCollectionViewCell.swift
//  GiphyAPITask
//
//  Created by hrasheed on 13.03.22.
//

import UIKit
import Combine

final class GiphyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var animatedImageView: UIImageView!
    var cancel: AnyCancellable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancel = nil
    }
    
    func configure(with row: GiphyRowViewModel, isScrolling: AnyPublisher<Bool, Never>) {
        animatedImageView.loadAnimatedImage(with: row.url, placeHolderImageName: "placeholder")
        cancel = isScrolling.sink { [weak self] isScrolling in
            if isScrolling {
                self?.animatedImageView.animationEnd()
            } else {
                self?.animatedImageView.animationBegin()
            }
        }
    }
}
