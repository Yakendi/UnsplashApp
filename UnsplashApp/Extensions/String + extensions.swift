//
//  String + extensions.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 02.04.2023.
//

import Foundation

extension String {
    func convertToURL() -> URL {
        return URL(string: self)!
    }
}
