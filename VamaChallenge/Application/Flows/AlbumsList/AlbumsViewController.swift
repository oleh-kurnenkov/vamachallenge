//
//  AlbumsViewController.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import UIKit
import Combine

final class AlbumsViewController: UIViewController {
    
    // MARK: - Section enum
    private enum Section {
        case main
    }
    
    // MARK: - Private properties
    private lazy var  collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds,
                                              collectionViewLayout: createLayout())
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    private let albumsCellIdentifier = "AlbumCollectionViewCell"
    private let viewModel: AlbumsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var data: UICollectionViewDiffableDataSource<Section, AlbumModel>?
    
    
    // MARK: - Lifecycle
    init(viewModel: AlbumsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.configureSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - Actions
    @objc private func refreshControlTriggered() {
        viewModel.refreshData()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.setupCollectionView()
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        self.title = "Top 100 Albums"
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.attachTo(view: view)
        
        collectionView.delegate = self
        collectionView.register(AlbumCollectionViewCell.self,
                                forCellWithReuseIdentifier: albumsCellIdentifier)
        
        configureDataSource()
        
    }
    
    private func configureSnapshot() {
        self.viewModel.albumsData.receive(on: DispatchQueue.main)
            .map { result in
                var items = [AlbumModel]()
                switch result {
                case .failure(let error):
                    self.show(error: error)
                case.success(let albums):
                    items = albums
                }
                
                var newSnapshot = NSDiffableDataSourceSnapshot<Section, AlbumModel>()
                newSnapshot.appendSections([.main])
                newSnapshot.appendItems(items)
                return newSnapshot
            }
            .sink (receiveValue: { newSnapshot in
                self.data?.apply(newSnapshot, animatingDifferences: true) {
                    self.collectionView.refreshControl?.endRefreshing()
                }
            }).store(in: &cancellables)
    }
    
    private func configureDataSource() {
        data = UICollectionViewDiffableDataSource<Section, AlbumModel>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, album in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.albumsCellIdentifier,
                                                                for: indexPath) as? AlbumCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: album)
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let fraction: CGFloat = 1 / 2
            let inset: CGFloat = 6
            let groupInset: CGFloat = Constants.Paddings.bigPadding
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                         bottom: inset, trailing: inset)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: groupInset,
                                                            bottom: inset, trailing: groupInset)
            
            return section
        }
        
        return layout
    }
    
    private func show(error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        self.collectionView.refreshControl?.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(alertController, animated: true)
        }
    }
}

// MARK: - UICollectionView delegate
extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectedIndex = indexPath.row
    }
}
