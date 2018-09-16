//
//  AppKeys.swift
//  MapLocator
//
//  Created by Khristoffer Julio on 14/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import UIKit

class AppKeys: NSObject {
    static var FourSquareClientID: String {
        // Get the file path for keys.plist
        // should be in separate plist, but its ok for this purpose
        guard
            let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: filePath),
            let key = dictionary.object(forKey: "FOURSQUARE_CLIENT_ID") as? String
            else {
                return ""
        }
        return key
    }
    
    static var FourSquareClientSecret: String {
        // Get the file path for keys.plist
        // should be in separate plist, but its ok for this purpose
        guard
            let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: filePath),
            let key = dictionary.object(forKey: "FOURSQUARE_CLIENT_SECRET") as? String
            else {
                return ""
        }
        return key
    }
}
