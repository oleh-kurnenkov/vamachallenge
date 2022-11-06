//
//  UILabel+shadow.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 05.11.2022.
//

import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: -0.5)
    }
}
