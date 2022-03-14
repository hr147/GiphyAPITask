//
//  Giphy.swift
//  GiphyAPITask
//
//  Created by hrasheed on 14.03.22.
//

import Foundation

struct Giphy: Decodable, Hashable {
    let id: String
    let url: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id, images, title
    }
    
    struct Image: Decodable {
        let container: Container
        
        enum CodingKeys: String, CodingKey {
            case container = "original"
        }
        
        struct Container: Decodable {
            let url: String
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let images = try container.decode(Image.self, forKey: .images)
        url = images.container.url
    }
}
