//
//  API.swift
//  MyWeatherApp
//
//  Created by vladislav on 03.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    typealias CompletionBlock = (_ success: Data) -> Void
    typealias ErrorBlock = (_ error: Any) -> Void
    
    static let sharedManager = API()
    
    func request(for url: String, paramsDict: [String: Any]) -> DataRequest? {
        guard let searchURL = URL(string: url) else {
            return nil
        }
        var parameters: Parameters = [
            APIConstants.apiKey: APIConstants.apiKeyValue,
        ]
        parameters.merge(paramsDict) { (value1, value2) -> Any in
            return value1
        }
        
        return AF.request(searchURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil)
    }
    
    func getWeatherByName(cityToSearch: String, success: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = request(for: APIConstants.baseURL, paramsDict: ["q": cityToSearch, "units": "metric"]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success data city")
                    success(realData)
                } else {
                    failure("No data")
                }
            })
        } else {
            failure("Request create unsuccessfull")
        }
    }
    
    func getDailyForecast(cityToSearch: String, success: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = request(for: APIConstants.dailyForecastURL, paramsDict: ["q": cityToSearch, "units": "metric"]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success forecast city")
                    success(realData)
                } else {
                    failure("No data")
                }
            })
        } else {
            failure("Request create unsuccessfull")
        }
    }
}
