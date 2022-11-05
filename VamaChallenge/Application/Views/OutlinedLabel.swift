//
//  OutlinedLabel.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 05.11.2022.
//

import UIKit

final class OutlinedLabel: UILabel {
    
    // MARK: - Private properties
    private let verticalInset: CGFloat = 3
    private let horizontalInset: CGFloat = 8
    
    // MARK: - Public properties
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalInset * 2,
                      height: size.height + verticalInset * 2)
    }
    
    // MARK: - LIfecycle
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset - 1,
                                  left: horizontalInset,
                                  bottom: verticalInset,
                                  right: horizontalInset)
        let finalRect = rect.inset(by: insets)
        super.drawText(in: finalRect)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = rect.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = self.textColor.cgColor
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - horizontalInset * 2
        }
    }
    
}
