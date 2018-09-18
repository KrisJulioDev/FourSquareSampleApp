//
//  ResponseError.swift
//  FourSquareSampleApp
//
//  Created by Khristoffer Julio on 18/09/2018.
//  Copyright © 2018 Khristoffer Julio. All rights reserved.
//
 
public enum ResponseError: Error {
    case noResult
    case unexpected
    
    var title: String {
        switch self {
        case .noResult:
            return "No result found"
        case .unexpected:
            return "Unexpected error occurred"
        }
    }
    
    var description: String {
        switch self {
        case .noResult:
            return "There's no venues at this location. Please try on other locations"
        case .unexpected:
            return "Please try again later."
        }
    }
}
