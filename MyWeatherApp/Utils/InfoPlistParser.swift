//
//  InfoPlistParser.swift
//  MyWeatherApp
//
//  Created by vladislav on 25.08.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct InfoPlistParser {
    static func getStringValue(forKey key: String) -> String {
        guard let value = Bundle.main.infoDictionary?[key] as? String else {
            fatalError("Could not find value for key \(key) in the Info.plist")
        }
        return value
    }
}
