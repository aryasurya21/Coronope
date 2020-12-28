//
//  StatsPresenter.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

class StatsPresenter: ObservableObject {
    
    private let usecase: StatsUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var stats: StatsModel?
    @Published var error: Error?
    @Published var isLoading = false
    
    init(usecase: StatsUseCase){
        self.usecase = usecase
    }
    
    func getStats(){
        self.isLoading = true
        self.usecase.getStats()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.error = error
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { (stats) in
                self.stats = stats[0]
            }.store(in: &self.cancellables)
    }
}
