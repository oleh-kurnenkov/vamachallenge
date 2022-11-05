//
//  FeedResponse.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 04.11.2022.
//

import Foundation

final class FeedResponse: Decodable {
    
    // MARK: - Public properties
    var feed: AlbumsResponse
}
