//
//  NewsRepository.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

protocol CoronopeRepositoryProtocol {
    func getNews() -> AnyPublisher<[NewsModel], Error>
    func getStats() -> AnyPublisher<[StatsModel], Error>
}

final class CoronopeRepository {
    typealias CoronopeRepoInstance = (APIInstance, LocaleInstance) -> CoronopeRepository
    private let apiInstance: APIInstance
    private let localeInstance: LocaleInstance
    
    private init(_ apiInstance: APIInstance, _ localeInstance: LocaleInstance){
        self.apiInstance = apiInstance
        self.localeInstance = localeInstance
    }
    
    static let shared: CoronopeRepoInstance = { api, locale in
        return CoronopeRepository(api, locale)
    }
}

extension CoronopeRepository: CoronopeRepositoryProtocol {
    func getNews() -> AnyPublisher<[NewsModel], Error> {
        return self.localeInstance.getNewsList()
            .flatMap { (results) -> AnyPublisher<[NewsModel], Error> in
                if results.count == 0 {
                    return self.apiInstance.getNews()
                        .map{ ObjectMapper.mapNewsResponseToEntities(news: $0) }
                        .flatMap{ self.localeInstance.addNewsList(news: $0) }
                        .filter{ $0 }
                        .flatMap { _ in
                            self.localeInstance.getNewsList().map{ ObjectMapper.mapNewsEntitiesToDomains(news: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return self.localeInstance.getNewsList()
                        .map{ ObjectMapper.mapNewsEntitiesToDomains(news: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getStats() -> AnyPublisher<[StatsModel], Error> {
        return self.apiInstance.getStats()
            .map{ ObjectMapper.mapStatsResponseToDomains(stats: $0) }
            .eraseToAnyPublisher()
    }
}
