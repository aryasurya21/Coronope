//
//  CoronopeService.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

struct CoronopeService {
    
    internal let baseURL = CoronopeTarget.baseURL
    internal var endPoint : String = ""
    
    internal func parseJson(coronaData : Data) -> CoronopeResponseWrapper? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoronopeResponseWrapper
                .self, from: coronaData)
            print(decodedData.features[0].attributes.value)
            return nil
            
        } catch {
            print(error)
            return nil
        }
    }
        
    internal func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let browser = URLSession(configuration: .default)
            let task = browser.dataTask(with: url) { (data, response, error) in
                if ( error != nil ){
                    return
                }

                if let safeData = data {
                    if let realData = self.parseJson(coronaData: safeData){
                        print(realData)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    public mutating func fetchConfirmedCases(){
        endPoint = "\(baseURL)\(CoronopeTarget.confirmedCases)"
        performRequest(with: endPoint)
    }
      
    public mutating func fetchTotalRecovered(){
        endPoint = "\(baseURL)\(CoronopeTarget.totalRecovered)"
        performRequest(with: endPoint)
    }
      
    public mutating func fetchTotalDeaths(){
        endPoint = "\(baseURL)\(CoronopeTarget.totalDeaths)"
        performRequest(with: endPoint)
    }
      
}
