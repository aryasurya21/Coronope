//
//  NewsEntity.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import RealmSwift

class NewsEntity: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var newsDescription: String = ""
}
