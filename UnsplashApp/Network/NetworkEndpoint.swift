//
//  NetworkEndpoints.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func getImages() -> Self {
        Endpoint(
            path: "/photos/random/",
            queryItems: [
                URLQueryItem(name: "client_id", value: "SR06pjmvFFAczVYEUE0htljhCG34JbLATNtVP5jrXpA"),
                URLQueryItem(name: "count", value: "30")
            ]
        )
    }
    
    static func searchImages(with keyWord: String, page: Int) -> Self {
        Endpoint(
            path: "/search/photos",
            queryItems: [
                URLQueryItem(name: "client_id", value: "SR06pjmvFFAczVYEUE0htljhCG34JbLATNtVP5jrXpA"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "query", value: keyWord)
            ]
        )
    }
}
