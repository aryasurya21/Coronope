//
//  CoronopeNewsService.swift
//  Coronope
//
//  Created by IT Division on 16/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import Foundation

protocol CoronopeNewsServiceDelegate {
    func didGetData(articleList: [CoronopeNewsModel])
    func didFailWithError(error: Error)
}

class CoronopeNewsService {
    let baseUrl: String
    var endPoint: String
    var articleList: [CoronopeNewsModel]
    var delegate: CoronopeNewsServiceDelegate?
    
    init() {
        baseUrl = CoronopeNewsTarget.baseURL
        endPoint = ""
        articleList = []
    }
    
    func parseJson(coronaData: Data) -> [CoronopeNewsModel]? {
        let decoder = JSONDecoder()
        do{
     
            let decodedData = try decoder.decode(CoronopeNewsResponseWrapper.self, from: coronaData)
            for article in decodedData.articles! {
                articleList.append(CoronopeNewsModel(
                    title: article.title!,
                    newsUrl: article.url!,
                    imgUrl: article.urlToImage ?? "-",
                    description: article.description ?? "No description available.."
                ))
            }
            return articleList
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let browser = URLSession(configuration: .default)
            let task = browser.dataTask(with: url) { (data, response, error) in
                if ( error != nil ){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let parsedData = self.parseJson(coronaData: safeData){
                        self.delegate?.didGetData(articleList: parsedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseNews(){
        endPoint = "\(baseUrl)\(CoronopeNewsTarget.healthNews)"
        performRequest(with: endPoint)
    }
}
