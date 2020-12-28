//
//  StatsInteractor.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

class StatsInteractor: StatsUseCase {
    
    private let repository: CoronopeRepositoryProtocol
    
    init(_ repository: CoronopeRepositoryProtocol) {
        self.repository = repository
    }

    func getStats() -> AnyPublisher<[StatsModel], Error> {
        self.repository.getStats()
    }
}
