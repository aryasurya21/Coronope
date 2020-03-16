//
//  CoronopeNewsResponseWrapper.swift
//  Coronope
//
//  Created by IT Division on 16/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoronopeNewsResponseWrapper : Decodable {
    let articles: [ArticleDetail]?
}

struct ArticleDetail : Decodable {
    let title: String?
    let url: String?
    let urlToImage: String?
}
