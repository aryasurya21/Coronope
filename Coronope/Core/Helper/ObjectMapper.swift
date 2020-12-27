//
//  ObjectMapper.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

class ObjectMapper {
    class func mapNewsResponseToEntities(news: [NewsResponse]) -> [NewsEntity] {
        return news.map{ data in
            let entity = NewsEntity()
            entity.title = data.title ?? ""
            entity.newsDescription = data.description ?? ""
            entity.url = data.url ?? ""
            entity.urlToImage = data.urlToImage ?? ""
            return entity
        }
    }
    
    class func mapNewsEntitiesToDomains(news: [NewsEntity]) -> [NewsModel] {
        return news.map{ data in
            let newsModel = NewsModel(
                title: data.title,
                url: data.url,
                urlToImage: data.urlToImage,
                description: data.newsDescription
            )
            return newsModel
        }
    }
    
    class func mapStatsResponseToDomains(stats: [StatsResponseWrapper]) -> [StatsModel] {
        return stats.map{ data in
            return StatsModel(
                positive: data.positive ?? "",
                recovered: data.recovered ?? "",
                death: data.death ?? "",
                treated: data.treated ?? ""
            )
        }
    }
}
