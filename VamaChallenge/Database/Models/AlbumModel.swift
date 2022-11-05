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
    
    enum CodingKeys: CodingKey {
        case artistName
        case id
        case name
        case artworkUrl100
        case releaseDate
        case genres
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._artistName = try container.decode(Persisted<String>.self, forKey: .artistName)
        self._id = try container.decode(Persisted<String>.self, forKey: .id)
        self._name = try container.decode(Persisted<String>.self, forKey: .name)
        self._artworkUrl100 = try container.decode(Persisted<String>.self, forKey: .artworkUrl100)
        self._releaseDate = try container.decode(Persisted<String>.self, forKey: .releaseDate)
        self._genres = try container.decode(Persisted<List<GenreModel>>.self, forKey: .genres)
        self._url = try container.decode(Persisted<String>.self, forKey: .url)
    }
    
}
