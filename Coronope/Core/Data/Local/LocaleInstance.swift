//
//  LocaleInstance.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

protocol LocaleInstanceCapabililty {
    func getNewsList() -> AnyPublisher<[NewsEntity], Error>
    func addNewsList(news: [NewsEntity]) -> AnyPublisher<Bool, Error>
}

final class LocaleInstance {
    private let realm: Realm?
    
    private init(_ realm: Realm?){
        self.realm = realm
    }
    
    static let shared: (Realm?)->LocaleInstance = { realm in
        return LocaleInstance(realm)
    }
}

extension LocaleInstance: LocaleInstanceCapabililty {
    func getNewsList() -> AnyPublisher<[NewsEntity], Error> {
        return Future<[NewsEntity], Error>{ completion in
            if let realm = self.realm {
                let news: Results<NewsEntity> = {
                    realm.objects(NewsEntity.self)
                }()
                completion(.success(news.toCustomObjects(fromType: NewsEntity.self)))
            } else {
                completion(.failure(CoronopeDBError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addNewsList(news: [NewsEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error>{ completion in
            if let realm = self.realm {
                do {
                    let existingNews = {
                        realm.objects(NewsEntity.self).toCustomObjects(fromType: NewsEntity.self)
                    }()
                    
                    let filteredNews = news.filter{ apiNews in
                        return !existingNews.contains{ $0.title == apiNews.title }
                    }
                    try realm.write {
                        for news in filteredNews {
                            realm.add(news)
                        }
                    }
                    completion(.success(true))

                } catch {
                    completion(.failure(CoronopeDBError.requestFailed))
                }
            } else {
                completion(.failure(CoronopeDBError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
