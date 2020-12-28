//
//  NewsUseCase.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import Combine

protocol NewsUseCase {
    func getNews() -> AnyPublisher<[NewsModel], Error>
}
