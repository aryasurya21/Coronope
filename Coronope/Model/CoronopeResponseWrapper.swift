//
//  CoronopeResponseWrapper.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoronopeResponseWrapper: Decodable {
    let features: [Feature]
}

struct Feature: Decodable {
    let attributes: AttributeDetail
}

struct AttributeDetail : Decodable {
    let Confirmed: Int?
    let Recovered: Int?
    let Deaths: Int?
    let value: Int?
}
