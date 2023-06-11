//
//  UIView + extensions.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func zoomIn(duration: TimeInterval = 0.12) {
        self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        UIView.animate(withDuration: duration,
                       delay: 0.08,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.transform = .identity
        }
    }
}
