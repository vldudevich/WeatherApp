//
//  WeatherForecast.swift
//  MyWeatherApp
//
//  Created by vladislav on 16.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

struct WeatherForecast: Codable {
    
    var identifier: Int
    var main: String
    var description: String
    var icon: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.main = try container.decode(String.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
    
    private func getIconURL(bigSize: Bool) -> String {
        return APIConstants.imageURL.rawValue + icon + (bigSize ? ".png" : "@2x.png")
    }
    
    func getImage(bigSize: Bool, succes: @escaping (_ image: UIImage) -> Void)  {
        
        guard let iconURL = URL(string: getIconURL(bigSize: true)) else { succes(UIImage(named: "noImage")!); return }
        Utils.load(url: iconURL) { (data) in
            guard let image = data else { return }
            succes(image)
        }
    }
}
