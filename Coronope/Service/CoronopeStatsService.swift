//
//  CoronopeService.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

protocol CoronopeStatsServiceDelegate {
    func didGetGlobalData(coronopeModel: CoronopeModel)
    func didGetLocalData(coronopeModel : CoronopeModel)
    func didFailWithError(error: Error)
}

class CoronopeStatsService {
    let baseURL: String
    var endPoint: String
    var delegate: CoronopeStatsServiceDelegate?
    
    init() {
        baseURL = CoronopeStatsTarget.baseURL
        endPoint = ""
    }
    
    func parseJson(coronaData: Data, apiType: Int) -> CoronopeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoronopeStatsResponseWrapper
                .self, from: coronaData)
            var coronopeModel = CoronopeModel()
            
            switch apiType {
                case CoronopeConstants.indoAPI:
                    var coronopeIndoModel = CoronopeIndoModel(confirmed: 0, recovered: 0, deaths: 0)
                    let datas = decodedData
                    for data in datas.features {
                        if(data.attributes.Country_Region!.elementsEqual(CoronopeConstants.countryName)){
                            coronopeIndoModel.confirmed = data.attributes.Confirmed!
                            coronopeIndoModel.deaths = data.attributes.Deaths!
                            coronopeIndoModel.recovered = data.attributes.Recovered!
                            break
                        }
                    }
                    coronopeModel.coronopeIndo = coronopeIndoModel
                    return coronopeModel
                
                case CoronopeConstants.globalAPI:
                    var coronopeGlobalModel = CoronopeGlobalModel(value: 0)
                    let data = decodedData.features[0].attributes
                    
                    coronopeGlobalModel.value = data.value!
                
                    coronopeModel.coronopeGlobal = coronopeGlobalModel
                    return coronopeModel
            default:
                return nil
            }
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func performRequest(with urlString : String, with apiType: Int){
        if let url = URL(string: urlString){
            let browser = URLSession(configuration: .default)
            let task = browser.dataTask(with: url) { (data, response, error) in
                if ( error != nil ){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let parsedData = self.parseJson(coronaData: safeData,apiType: apiType){
                        switch apiType {
                        case CoronopeConstants.globalAPI:
                            self.delegate?.didGetGlobalData(coronopeModel: parsedData)
                        case CoronopeConstants.indoAPI:
                            self.delegate?.didGetLocalData(coronopeModel: parsedData)
                        default:
                            print("error API type hehe")
                        }
                    }
                }
            }
            
            task.resume()
        }
    }

    public func fetchLocalCases(){
        endPoint = "\(baseURL)\(CoronopeStatsTarget.localAllCases)"
        performRequest(with: endPoint, with: CoronopeConstants.indoAPI)
    }
    
    public func fetchGlobalConfirmedCases(){
        endPoint = "\(baseURL)\(CoronopeStatsTarget.globalTotalConfirmedCases)"
        performRequest(with: endPoint, with: CoronopeConstants.globalAPI)
    }
      
    public func fetchGlobalTotalRecovered(){
        endPoint = "\(baseURL)\(CoronopeStatsTarget.globalTotalRecovered)"
        performRequest(with: endPoint, with: CoronopeConstants.globalAPI)
    }
      
    public func fetchGlobalTotalDeaths(){
        endPoint = "\(baseURL)\(CoronopeStatsTarget.globalTotalDeaths)"
        performRequest(with: endPoint, with: CoronopeConstants.globalAPI)
    }
}

