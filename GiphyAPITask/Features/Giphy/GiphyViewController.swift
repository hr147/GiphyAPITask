//
//  ViewController.swift
//  GiphyAPITask
//
//  Created by hrasheed on 07.03.22.
//

import UIKit
import Combine

struct Giphy: Decodable {
    let id: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, images
    }
    
    struct Images: Decodable {
        let original: Original
        
        struct Original: Decodable {
            let url: String
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let images = try container.decode(Images.self, forKey: .images)
        url = images.original.url
    }
}
/*
 "pagination":{
 "total_count":2446
 "count":25
 "offset":0
 
 */
struct Pagination: Decodable {
    let count: Int
    let offset: Int
}

struct GiphyResponse: Decodable {
    let gifs: [Giphy]
    let pagination: Pagination
    
    enum CodingKeys: String , CodingKey {
        case gifs = "data", pagination
    }
}

class GiphyUseCase {
    let service: NetworkService = URLSession.shared
    
    func fetchImages() -> AnyPublisher<GiphyResponse, Error> {
        service.publisher(for: .trending(with: .init(limit: 25, offset: 0)))
    }
}

class GiphyViewController: UICollectionViewController {
    let usecase: GiphyUseCase
    var cancellable: AnyCancellable?
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var imageURLs: [String] = []
    
    // MARK: Life Cycle
    
    init?(coder: NSCoder, usecase: GiphyUseCase) {
        //self.viewModel = viewModel
        self.usecase = usecase
        super.init(coder: coder)
        //bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancellable = usecase.fetchImages().sink { completion in
            print(completion)
        } receiveValue: {[weak self] response in
            print(response)
            DispatchQueue.main.async {
                self?.imageURLs = response.gifs.map(\.url)
                self?.collectionView.reloadData()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GiphyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: imageURLs[indexPath.row])
        return cell
    }
}
