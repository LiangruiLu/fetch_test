//
//  createURL.swift
//  Fetch_Liangrui_Lu
//
//  Created by Larry Lu on 2023/7/2.
//

import Foundation

let api = "https://themealdb.com/api/json/v1/1"

func createURL(with path: String, queryParameters: [String: String]) -> URL? {
    guard var urlComponents = URLComponents(string: api+path) else {
        return nil
    }
    
    urlComponents.queryItems = queryParameters.map { key, value in
        URLQueryItem(name: key, value: value)
    }
    
    return urlComponents.url
}

