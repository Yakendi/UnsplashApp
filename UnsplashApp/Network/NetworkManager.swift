//
//  NetworkManager.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import Foundation

class NetworkManager {
    
    // MARK: - Base url
    let baseURL = "https://api.unsplash.com/photos/random/?client_id=SR06pjmvFFAczVYEUE0htljhCG34JbLATNtVP5jrXpA&count=30"
    
    // MARK: - Main request
    func mainRequest<T: Codable>(_ url: URL, completion: @escaping (Result<T, NetworkErrorTypes>) -> Void) {
         
        URLSession.shared.dataTask(with: url) { data, responce, error in
            
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let unsplashData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(unsplashData))
            } catch let error {
                completion(.failure(.error(error: error)))
            }
        }
    }
    
    // MARK: - Get images
    func getImages(completion: @escaping (Result<[UnsplashModel], NetworkErrorTypes>) -> Void) {
        let url = baseURL
        let convertedURL = url.convertToURL()
        mainRequest(convertedURL, completion: completion)
    }
}
