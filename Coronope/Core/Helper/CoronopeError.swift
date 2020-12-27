//
//  CoronopeError.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

enum CoronopeAPIError: Error {
    case apiError
    case invalidEndpoint
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data."
        case .invalidEndpoint: return "Invalid endpoint."
        }
    }
}

enum CoronopeDBError: Error {
    case requestFailed
    case invalidInstance
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Failed to access the local database."
        case .invalidInstance: return "Could not instantiate local database."
        }
    }
}

