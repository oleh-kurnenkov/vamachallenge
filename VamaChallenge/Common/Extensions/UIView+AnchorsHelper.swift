//
//  UIView+AnchorsHelper.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 04.11.2022.
//

import UIKit

extension UIView {
    func attachUnder(_ view: UIView,
                        with padding: CGFloat,
                        leading: CGFloat,
                        trailing: CGFloat) {
        self.topAnchor.constraint(equalTo: view.bottomAnchor,
                                  constant: padding).isActive = true
        self.add(leading: leading, trailing: trailing, to: view)

    }
    
    func attachToBottom(of view: UIView,
                        with padding: CGFloat,
                        leading: CGFloat,
                        trailing: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                     constant: -padding).isActive = true
        self.add(leading: leading, trailing: trailing, to: view)

    }

    func attachTo(view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func attachOver(_ view: UIView,
                     with padding: CGFloat,
                     leading: CGFloat,
                     trailing: CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.topAnchor,
                                     constant: padding).isActive = true
        self.add(leading: leading, trailing: trailing, to: view)
    }
    
    func add(leading: CGFloat,
             trailing: CGFloat,
             to view: UIView? = nil) {
        let levelingView = superview ?? view
        guard let levelingView else { return }
        self.leadingAnchor.constraint(equalTo: levelingView.leadingAnchor,
                                                      constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: levelingView.trailingAnchor,
                                                       constant: trailing).isActive = true
    }
    
}
