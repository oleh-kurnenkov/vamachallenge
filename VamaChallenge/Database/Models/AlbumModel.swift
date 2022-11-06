//
//  AlbumModel.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import Foundation
import RealmSwift

final class AlbumModel: Object, Decodable {
    
    // MARK: - Public properties
    @Persisted var artistName: String
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var artworkUrl100: String
    @Persisted var releaseDate: String
    @Persisted var url: String
    @Persisted var genres: List<GenreModel>
    
    // MARK: - Lifecycle
    override init() {}
    
}
