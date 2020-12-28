//
//  Injector.swift
//  Coronope
//
//  Created by IT Division on 28/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import RealmSwift

final class Injector {
    
    private init(){}
    static let shared = Injector()

    private func injectRepository() -> CoronopeRepositoryProtocol {
        let realm = try? Realm()
        let locale = LocaleInstance.shared(realm)
        let api = APIInstance.shared
        
        return CoronopeRepository.shared(api, locale)
    }
    
    public func injectStatsInteractor() -> StatsUseCase {
        return StatsInteractor(self.injectRepository())
    }
    
    public func injectNewsInteractor() -> NewsUseCase {
        return NewsInteractor(self.injectRepository())
    }
}
