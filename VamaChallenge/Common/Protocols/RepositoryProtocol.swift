//
//  Repository.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import Combine

protocol RepositoryProtocol: AnyObject {
    func get() -> AnyPublisher<[AlbumModel], Error>
    func set(albums: [AlbumModel])
    func removeAll()
}

extension RepositoryProtocol {
    func set(albums: [AlbumModel]) {}
    func removeAll() {}
}
