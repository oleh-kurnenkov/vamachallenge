//
//  AlbumsResponse.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 04.11.2022.
//

import Foundation

final class AlbumsResponse: Decodable {
    
    // MARK: - Public properties
    var results: [AlbumModel]
}
