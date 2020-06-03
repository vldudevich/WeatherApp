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

    static let apiKey = "appid"
    static let apiKeyValue = "d4458b0662163707e0e4df2c0aceecb1"
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    static func request(for url: String, paramsDict: [String: Any]) -> DataRequest? {
        guard let searchURL = URL(string: url) else {
            return nil
        }
        var parameters: Parameters = [
            apiKey: apiKeyValue,
        ]
        parameters.merge(paramsDict) { (value1, value2) -> Any in
            return value1
        }

     return AF.request(searchURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil)
    }
    
    static func getWeatherByName(cityToSearch: String, success: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = self.request(for: baseURL, paramsDict: ["q": cityToSearch]) {
                request.response(completionHandler: { (response) in
                    if let realData = response.data {
                        print("success recieve/search city")
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
