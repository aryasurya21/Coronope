//
//  CoronopeModel.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoronopeModel {
    var coronopeIndo: CoronopeIndoModel?
    var coronopeGlobal: CoronopeGlobalModel?
}

struct CoronopeIndoModel {
    var confirmed: Int
    var recovered: Int
    var deaths: Int
}

struct CoronopeGlobalModel {
    var value: Int
}
