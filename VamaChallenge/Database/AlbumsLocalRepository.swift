//
//  AlbumsLocalRepository.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import Combine
import RealmSwift

final class AlbumsLocalRepository: RepositoryProtocol {
    
    // MARK: - Private properties
    private var realm: Realm {
        return try! Realm()
    }
    
    // MARK
    func get() -> AnyPublisher<[AlbumModel], Error> {
        let albums = Array(realm.objects(AlbumModel.self))
        return Just<[AlbumModel]>(albums)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func set(albums: [AlbumModel]) {
        let realm = realm
        try? realm.write {
            realm.add(albums)
        }
    }
    
    func removeAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
