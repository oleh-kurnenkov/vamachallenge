//
//  AlbumsViewModel.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import Combine
import Foundation

protocol AlbumsViewModelProtocol: AnyObject {
    var albumsData: CurrentValueSubject<Result<[AlbumModel], Error>, Never> { get }
    var selectedIndex: Int { get set }
    
    func refreshData()
}

final class AlbumsViewModel: ObservableObject {
        
    // MARK: - Private properties
    private(set) var albumsData = CurrentValueSubject<Result<[AlbumModel], Error>, Never>(.success([]))
    private var albumsLocalRepository: RepositoryProtocol
    private var albumsRemoteRepository: RepositoryProtocol
    private var coordinator: AppCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public properties
    var selectedIndex = 0 {
        didSet {
            switch self.albumsData.value {
            case .success(let albums):
                self.coordinator.showAlbumDetails(for: albums[selectedIndex])
            default: return
            }
        }
    }
    
    // MARK: - Lifecycle
    init(albumsLocalRepository: RepositoryProtocol,
         albumsRemoteRepository: RepositoryProtocol,
         coordinator: AppCoordinator)  {
        self.coordinator = coordinator
        self.albumsLocalRepository = albumsLocalRepository
        self.albumsRemoteRepository = albumsRemoteRepository
        self.getAlbumsData()
    }
    
    // MARK: - Private methods
    private func getAlbumsData() {
        self.albumsLocalRepository.get().sink { error in } receiveValue: { albums in
            self.albumsData.send(.success(albums))
        }.store(in: &cancellables)

        self.albumsRemoteRepository.get()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleNetwork(error: error)
                default: return
                }
            } receiveValue: { [weak self] albums in
                self?.albumsData.send(.success(albums))
                self?.albumsLocalRepository.removeAll()
                self?.albumsLocalRepository.set(albums: albums)
            }.store(in: &cancellables)
    }
    
    private func handleNetwork(error: Error) {
        switch self.albumsData.value {
        case .success(let albums):
            if albums.isEmpty { self.albumsData.send(.failure(error)) }
        default:
            return
        }
    }
    
}

extension AlbumsViewModel: AlbumsViewModelProtocol {
    func refreshData() {
        self.getAlbumsData()
    }
}
