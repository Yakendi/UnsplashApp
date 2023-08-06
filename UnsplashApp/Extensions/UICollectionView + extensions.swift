//
//  UICollectionView + extensions.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 06.08.2023.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
