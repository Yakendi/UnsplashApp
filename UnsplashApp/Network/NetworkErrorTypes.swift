//
//  NetworkErrorTypes.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import Foundation

enum NetworkErrorTypes: Error {
    case invalidURL
    case emptyData
    case error(error: Error)
}

extension NetworkErrorTypes: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Невалидынй url.", comment: "Loading error")
        case .emptyData:
            return NSLocalizedString("Нет данных.", comment: "JSON parse error")
        case .error(let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Error")
        }
    }
}
