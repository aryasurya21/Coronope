//
//  CoronopeNewsTarget.swift
//  Coronope
//
//  Created by IT Division on 16/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Alamofire
import Combine

protocol APIInstanceCapability {
    func getNews() -> AnyPublisher<[NewsResponse], Error>
    func getStats() -> AnyPublisher<[StatsResponseWrapper], Error>
}

final class APIInstance {
    private let newsBaseURL = "https://newsapi.org/v2"
    private let statsBaseURL = "https://api.kawalcorona.com"
    private let newsApiKey = "e8b7a2f89b094786ba3ca7334416d7ec"
    static let shared = APIInstance()
    private init(){}
}

extension APIInstance: APIInstanceCapability {
    func getStats() -> AnyPublisher<[StatsResponseWrapper], Error> {
        return Future<[StatsResponseWrapper], Error> { (completion) in
            if let url = URL(string: "\(self.statsBaseURL)/indonesia") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: [StatsResponseWrapper].self) { (response) in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let err):
                            print(err.localizedDescription)
                            completion(.failure(CoronopeAPIError.apiError))
                        }
                    }
            } else {
                completion(.failure(CoronopeAPIError.invalidEndpoint))
            }
        }.eraseToAnyPublisher()
    }
    
    func getNews() -> AnyPublisher<[NewsResponse], Error> {
        let parameters: Parameters = [
            "q": "covid",
            "sortBy": "publishedAt",
            "apiKey": self.newsApiKey,
            "country": "id",
            "category": "health"
        ]
        return Future<[NewsResponse], Error> { (completion) in
            if let url = URL(string: "\(self.newsBaseURL)/top-headlines") {
                AF.request(url, method: .get, parameters: parameters)
                    .validate()
                    .responseDecodable(of: NewsResponseWrapper.self) { (response) in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data.articles ?? []))
                        case .failure:
                            completion(.failure(CoronopeAPIError.apiError))
                        }
                    }
            } else {
                completion(.failure(CoronopeAPIError.invalidEndpoint))
            }
        }.eraseToAnyPublisher()
    }
}
