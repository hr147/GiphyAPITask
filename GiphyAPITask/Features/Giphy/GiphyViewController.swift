//
//  ViewController.swift
//  GiphyAPITask
//
//  Created by hrasheed on 07.03.22.
//

import UIKit
import Combine

final class GiphyViewController: UICollectionViewController {
    private var bindingCancellable: AnyCancellable?
    private let viewModel: GiphyViewModel
    
    private lazy var dataSource = makeDataSource()
    
    // MARK: Life Cycle
    
    init?(coder: NSCoder, viewModel: GiphyViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayRow(atIndex: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(atIndex: indexPath.row)
    }
    
    // MARK: Private Methods
    
    private func configureUI() {
        title = viewModel.screenTitle
        collectionView.dataSource = dataSource
    }
    
    private func bindViewModel() {
        bindingCancellable = viewModel.output.sink { [weak self] viewState in
            self?.render(viewState)
        }
    }
    
    private func render(_ state: GiphyViewState) {
        switch state {
        case let .message(message):
            presentAlert(message)
        case let .showRows(rows):
            update(with: rows)
        }
    }
}

fileprivate extension GiphyViewController {
    enum Section: CaseIterable {
        case giphy
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, GiphyRowViewModel> {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {  collectionView, indexPath, row in
                let cell: GiphyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(with: row)
                return cell
            }
        )
    }

    func update(with rows: [GiphyRowViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, GiphyRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(rows, toSection: .giphy)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
