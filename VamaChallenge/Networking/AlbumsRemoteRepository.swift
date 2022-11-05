//
//  AlbumsRepository.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import Combine
import Foundation

enum NetworkError: Error {
    case networkError
}

final class AlbumsRemoteRepository: RepositoryProtocol {
    
    // MARK: - Public methods
    func get() -> AnyPublisher<[AlbumModel], Error> {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json") else {
            return Fail(error: NetworkError.networkError).eraseToAnyPublisher()
        }

        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: FeedResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map { $0.feed.results }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
