
//
//  VenueRequest.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 18/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//

import MapKit
import Alamofire

struct VenueRequest {
    let version: String
    let coordinate: CLLocationCoordinate2D
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    // short cut url for this example project
    var url: String {
        return "https://api.foursquare.com/v2/venues/search"
    }
    
    var parameters: [String: Any] {
        return [
            "ll": "\(coordinate.latitude),\(coordinate.longitude)",
            "client_id": AppKeys.FourSquareClientID,
            "client_secret": AppKeys.FourSquareClientSecret,
            "v": version
        ]
    }
}
