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
    
    func request(for path: String, paramsDict: [String: Any]) -> DataRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIConstants.baseURL.rawValue
        urlComponents.path = path
        urlComponents.setQueryItems(with: paramsDict)
        urlComponents.queryItems?.append(URLQueryItem(name: APIConstants.apiKey.rawValue, value: APIConstants.apiKeyValue.rawValue))
    
        guard let resultUrl = urlComponents.url else { return nil }
        return AF.request(resultUrl, method: .get, encoding: URLEncoding(destination: .queryString), headers: nil)
    }
    
    func parseResponse<T: Codable>(responseData: Data, completionHandler: (T) -> Void) {
        let decoder = JSONDecoder()
        do {
            let weatherResponse = try decoder.decode(T.self, from: responseData)
            print(weatherResponse)
            completionHandler(weatherResponse)
        } catch {
            print(error)
        }
    }
    
    func getWeatherByName(cityToSearch: String, success: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = request(for: APIConstants.weatherURL.rawValue, paramsDict: ["q": cityToSearch, "units": "metric"]) {
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
        if let request = request(for: APIConstants.dailyForecastURL.rawValue, paramsDict: ["q": cityToSearch, "units": "metric"]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success forecast city by name")
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
