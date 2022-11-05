//
//  AppCoordinator.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 05.11.2022.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Private properties
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public methods
    func start() {
        let albumsViewModel = AlbumsViewModel(albumsLocalRepository: AlbumsLocalRepository(),
                                              albumsRemoteRepository: AlbumsRemoteRepository(),
                                              coordinator: self)
        let albumsViewController = AlbumsViewController(viewModel: albumsViewModel)
        self.navigationController.setViewControllers([albumsViewController], animated: true)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showAlbumDetails(for album: AlbumModel) {
        let albumDetailsViewController = AlbumDetailsViewController(albumModel: album)
        self.navigationController.pushViewController(albumDetailsViewController, animated: true)
    }
    
}
