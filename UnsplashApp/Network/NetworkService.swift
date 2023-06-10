//
//  NetworkManager.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import Foundation

typealias Handler<T: Codable> = (Result<T, NetworkErrorTypes>) -> Void

class NetworkService {
    
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Private
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Constructor
    init(
        configuration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = .init()
    ) {
        self.session = URLSession(configuration: configuration)
        self.decoder = decoder
    }
    
    // MARK: - Main request
    func makeRequest<Model: Codable>(to endpoint: Endpoint, completion: @escaping Handler<Model>) {
         
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let handler: Completion = { data, response, error in
            do {
                let data = try self.httpResponse(data: data, response: response)
                let response = try self.decoder.decode(Model.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.error(error: error)))
            }
        }
        session.dataTask(with: url, completionHandler: handler).resume()
    }
    
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrorTypes.nonHTTPResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data ?? Data()
        case 400...499:
            throw NetworkErrorTypes.nonHTTPResponse
        case 500...599:
            throw NetworkErrorTypes.nonHTTPResponse
        default:
            fatalError("Unhandled HTTP Response Status code: \(httpResponse.statusCode)")
        }
    }
}
