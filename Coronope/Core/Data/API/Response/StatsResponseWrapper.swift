//
//  CoronopeResponseWrapper.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct StatsResponseWrapper: Decodable {
    let positive: String?
    let recovered: String?
    let death: String?
    let treated : String?
    
    enum CodingKeys: String, CodingKey {
        case positive = "positif"
        case recovered = "sembuh"
        case death = "meninggal"
        case treated = "dirawat"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.positive = try values.decodeIfPresent(String.self, forKey: .positive)
        self.recovered = try values.decodeIfPresent(String.self, forKey: .recovered)
        self.death = try values.decodeIfPresent(String.self, forKey: .death)
        self.treated = try values.decodeIfPresent(String.self, forKey: .treated)
    }
}
