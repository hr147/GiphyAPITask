//
//  GiphyDetailViewController.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import UIKit

final class GiphyDetailViewController: UIViewController {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var animatedImageView: UIImageView!
    private let viewModel: GiphyDetailViewModel
    
    // MARK: Life Cycle
    
    init?(coder: NSCoder, viewModel: GiphyDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Private Methods
    
    private func configureUI() {
        titleLabel.text = viewModel.imageTitle
        animatedImageView.loadAnimatedImage(with: viewModel.imageURL, placeHolderImageName: "placeholder")
    }
}
