//
//  CoronopeNewsResponseWrapper.swift
//  Coronope
//
//  Created by IT Division on 16/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct NewsResponseWrapper : Decodable {
    let articles: [NewsResponse]?
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.articles = try values.decodeIfPresent([NewsResponse].self, forKey: .articles)
    }
}

struct NewsResponse: Decodable {
    let title: String?
    let url: String?
    let urlToImage: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case url
        case urlToImage
        case description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.url = try values.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}

