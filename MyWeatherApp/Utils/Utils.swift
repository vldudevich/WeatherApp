//
//  Utils.swift
//  MyWeatherApp
//
//  Created by vladislav on 14.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static var cities = [String]()
    static var indexPage = Int()
    static func load(url: URL, completionHandler: ((UIImage?) -> Void)? = nil) {
        DispatchQueue.global().async { [] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler?(image)
                    }
                }
            }
        }
    }
}
