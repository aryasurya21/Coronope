//
//  NewsPresenter.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

class NewsPresenter: ObservableObject {
    
    private let usecase: NewsUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var news: [NewsModel]?
    @Published var error: Error?
    @Published var isLoading = false
    
    init(usecase: NewsUseCase){
        self.usecase = usecase
    }
    
    func getNews(){
        self.isLoading = true
        self.usecase.getNews()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { (news) in
                self.news = news
            }.store(in: &self.cancellables)
    }
}

