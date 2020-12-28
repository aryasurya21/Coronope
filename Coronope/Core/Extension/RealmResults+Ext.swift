//
//  Results+Ext.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toCustomObjects<T: Object>(fromType: T.Type) -> [T] {
        var finalResult = [T]()
        for idx in stride(from: 0, to: count, by: +1) {
            if let obj = self[idx] as? T {
                finalResult.append(obj)
            }
        }
        return finalResult
    }
}
