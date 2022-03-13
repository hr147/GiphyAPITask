//
//  ViewController.swift
//  GiphyAPITask
//
//  Created by hrasheed on 07.03.22.
//

import UIKit
import GiphyUISDK
import Combine

/*
 "images":{
    "original":{
            "url":{
 */
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
    let usecase = GiphyUseCase()
    var cancellable: AnyCancellable?
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var imageURLs: [String] = []
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiphyCollectionViewCell", for: indexPath) as! GiphyCollectionViewCell
        cell.configure(with: imageURLs[indexPath.row])
        return cell
    }
    
    @objc func gifButtonTapped() {
//        let giphy = GiphyViewController()
//        giphy.theme = GPHTheme(type: .dark)
//        giphy.mediaTypeConfig = .
//        GiphyViewController.trayHeightMultiplier = 0.7
//        giphy.showConfirmationScreen = settingsViewController.confirmationScreen == .on
//        giphy.shouldLocalizeSearch = true
//        giphy.delegate = self
//        giphy.dimBackground = true
//        giphy.enableDynamicText = settingsViewController.dynamicResultsInTextSearch == .on
//         
//        giphy.modalPresentationStyle = .overCurrentContext
//        
//        if let contentType = self.selectedContentType {
//            giphy.selectedContentType = contentType
//        }
//        if let user = self.showMoreByUser {
//            giphy.showMoreByUser = user
//            self.showMoreByUser = nil
//        }
//        
//        present(giphy, animated: true, completion: nil)
    }
    
}

//extension GiphyViewController: GiphyDelegate {
//    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia, contentType: GPHContentType) {
//        print(contentType.rawValue)
//    }
//    
//    func didSearch(for term: String) {
//        print("your user made a search! ", term)
//    }
//    
//    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
////        showMoreByUser = nil
////        self.selectedContentType = giphyViewController.selectedContentType
////        giphyViewController.dismiss(animated: true, completion: { [weak self] in
////            self?.addMessageToConversation(text: nil, media: media)
////            guard self?.conversation.count ?? 0 > 7 else { return }
////            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
////                guard let self = self else { return }
////                let response = self.conversationResponses[self.currentConversationResponse % self.conversationResponses.count]
////                self.currentConversationResponse += 1
////                self.addMessageToConversation(text: response, user: .abraHam)
////            }
////        })
//        GPHCache.shared.clear()
//    }
//    
//    func didDismiss(controller: GiphyViewController?) {
//        GPHCache.shared.clear()
//    }
//}
//
//extension GiphyViewController: GPHMediaViewDelegate {
//    func didPressMoreByUser(_ user: String) {
//        //showMoreByUser = user
//        gifButtonTapped()
//    }
//}

