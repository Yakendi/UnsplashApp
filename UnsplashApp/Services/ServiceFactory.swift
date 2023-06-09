//
//  ServiceFactory.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 09.06.2023.
//

import Foundation

final class ServiceFactory {
    
    // MARK: - Singletone
    static let shared = ServiceFactory()
    
    // MARK: - Public
    let networkService: NetworkService
    
    // MARK: - Constructor
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }
    
    // MARK: - Request
    func getImages(completion: @escaping Handler<UnsplashModel>) {
        networkService.makeRequest(to: .getImages(), completion: completion)
    }
}
