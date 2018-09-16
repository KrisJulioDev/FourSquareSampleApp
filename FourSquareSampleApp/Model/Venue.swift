//
//  Venue.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 15/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
// 
import Foundation

struct FourSquareVenues: Codable {
    let meta: Meta
    let response: Response
}

struct Meta: Codable {
    let code: Int
    let requestID: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

struct Response: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let venuePage: VenuePage?
}

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

struct Icon: Codable {
    let iconPrefix: String
    let suffix: String
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

struct Location: Codable {
    let address: String?
    let crossStreet: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int
    let postalCode, cc, city, state: String?
    let country: String?
    let formattedAddress: [String]?
}

struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}

struct VenuePage: Codable {
    let id: String
}
