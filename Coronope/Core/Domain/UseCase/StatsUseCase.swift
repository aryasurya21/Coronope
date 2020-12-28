//
//  StatsUseCase.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

protocol StatsUseCase {
    func getStats() -> AnyPublisher<[StatsModel], Error>
}
