//
//  GenreModel.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 05.11.2022.
//

import Foundation
import RealmSwift

final class GenreModel: Object, Decodable {
    
    // MARK: - Public properties
    @Persisted var name: String
    
    // MARK: - Lifecycle
    override init() {}
}
