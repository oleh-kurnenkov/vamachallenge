//
//  AsyncImageView.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 04.11.2022.
//

import UIKit
import Combine

final class AsyncImageView: UIImageView {
    
    // MARK: - Public properties
    var urlString: String? {
        didSet {
            self.loadImage()
        }
    }
    
    // MARK: - Private methods
    private var cancelable: AnyCancellable?
    
    // MARK: - Private methods
    private func loadImage() {
        cancelable?.cancel()
        
        guard let urlString,
              let url = URL(string: urlString) else {
            self.image = nil
            return
        }
        
        cancelable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
}
