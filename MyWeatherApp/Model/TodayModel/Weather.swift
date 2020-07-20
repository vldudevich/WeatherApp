//
//  Weather.swift
//  MyWeatherApp
//
//  Created by vladislav on 04.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

struct Weather: Codable  {
    var indentifier: Int
    var main: String
    var descript: String
    var icon: String?

    
    private enum CodingKeys: String, CodingKey {
        case indentifier = "id"
        case main = "main"
        case descript = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.indentifier = try container.decode(Int.self, forKey: .indentifier)
        self.main = try container.decode(String.self, forKey: .main)
        self.descript = try container.decode(String.self, forKey: .descript)
        self.icon = try container.decodeIfPresent(String.self, forKey: .icon)
    }
    
    private func getIconURL(bigSize: Bool) -> String {
        return APIConstants.imageURL + (self.icon ?? "") + (bigSize ? ".png" : "@2x.png")
    }
    
    func getImage(bigSize: Bool, succes: @escaping (_ image: UIImage) -> Void)  {
        
        guard icon != nil else { return }
        guard let iconURL = URL(string: getIconURL(bigSize: true)) else { succes(UIImage(named: "noImage")!); return }
        Utils.load(url: iconURL) { (data) in
            guard let image = data else { return }
            succes(image)
        }
    }
}
