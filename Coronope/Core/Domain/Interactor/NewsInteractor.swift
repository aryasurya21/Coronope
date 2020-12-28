//
//  NewsInteractor.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

class NewsInteractor: NewsUseCase {
    
    private let repository: CoronopeRepositoryProtocol
    
    init(_ repository: CoronopeRepositoryProtocol){
        self.repository = repository
    }
    
    func getNews() -> AnyPublisher<[NewsModel], Error> {
        self.repository.getNews()
    }
}
