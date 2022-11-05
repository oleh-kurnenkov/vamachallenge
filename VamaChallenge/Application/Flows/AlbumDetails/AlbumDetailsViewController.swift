//
//  AlbumDetailsViewController.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 04.11.2022.
//

import UIKit

final class AlbumDetailsViewController: UIViewController {
    
    // MARK: - Private properties
    private let albumCoverImageView = AsyncImageView()
    private let albumTitleLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let genreLabel = OutlinedLabel()
    private let visitButton = UIButton()
    private let copyrightLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let backButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
    private let paddings = Constants.Paddings.self
    
    private let albumModel: AlbumModel
    
    // MARK: - LifeCycle
    init(albumModel: AlbumModel) {
        self.albumModel = albumModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Actions
    @objc private func onVisitButton() {
        guard let albumURL = URL(string: albumModel.url) else { return }
        
        let application = UIApplication.shared
        if application.canOpenURL(albumURL) {
            application.open(albumURL)
        }
    }
    
    @objc private func onBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.setupAlbumCoverImageView()
        self.setupArtistNameLabel()
        self.setupTitleLabel()
        self.setupGenreLabel()
        self.setupVisitButton()
        self.setupCopyrightLabel()
        self.setupReleaseDateLabel()
        self.setupBackButton()
        self.view.backgroundColor = .white
    }
    
    private func setupAlbumCoverImageView() {
        self.view.addSubview(self.albumCoverImageView)
        self.albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        self.albumCoverImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.albumCoverImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.albumCoverImageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.albumCoverImageView.urlString = albumModel.artworkUrl100
    }
    
    private func setupTitleLabel() {
        self.view.addSubview(albumTitleLabel)
        self.albumTitleLabel.numberOfLines = 0
        self.albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.albumTitleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        self.albumTitleLabel.textColor = #colorLiteral(red: 0.06666666667, green: 0.07058823529, blue: 0.1490196078, alpha: 1)
        self.albumTitleLabel.attachUnder(artistNameLabel,
                                         with: 0,
                                         leading: paddings.bigPadding,
                                         trailing: -paddings.bigPadding)
        self.albumTitleLabel.text = albumModel.name
    }
    
    private func setupArtistNameLabel() {
        self.view.addSubview(artistNameLabel)
        self.artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.artistNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.artistNameLabel.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.artistNameLabel.attachUnder(albumCoverImageView,
                                         with: paddings.mediumPadding,
                                         leading: paddings.bigPadding,
                                         trailing: -paddings.bigPadding)
        self.artistNameLabel.text = albumModel.artistName
        
    }
    
    private func setupGenreLabel() {
        self.view.addSubview(genreLabel)
        self.genreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.genreLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.genreLabel.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor,
                                             constant: paddings.smallPadding).isActive = true
        self.genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: paddings.bigPadding).isActive = true
        self.genreLabel.text = self.albumModel.genres.first?.name
        
    }
    
    private func setupVisitButton() {
        self.view.addSubview(visitButton)
        self.visitButton.translatesAutoresizingMaskIntoConstraints = false
        self.visitButton.setTitle("Visit The Album", for: .normal)
        self.visitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.visitButton.tintColor = .white
        self.visitButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.visitButton.layer.cornerRadius = 10
        self.visitButton.addTarget(self, action: #selector(onVisitButton), for: .touchUpInside)
        
        self.visitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -13).isActive = true
        self.visitButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.visitButton.widthAnchor.constraint(equalToConstant: 155).isActive = true
        self.visitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupCopyrightLabel() {
        self.view.addSubview(copyrightLabel)
        self.copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        self.copyrightLabel.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        self.copyrightLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.copyrightLabel.textAlignment = .center
        self.copyrightLabel.text = "Copyright 2022 Apple Inc. All rights reserved."
        
        let copyrightLabelPadding: CGFloat = -24
        self.copyrightLabel.attachOver(visitButton,
                                       with: copyrightLabelPadding,
                                       leading: paddings.bigPadding,
                                       trailing: -paddings.bigPadding)
    }
    
    private func setupReleaseDateLabel() {
        self.view.addSubview(releaseDateLabel)
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDateLabel.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        self.releaseDateLabel.textAlignment = .center
        self.releaseDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        let releaseDate = DateHelper.parseDate(from: albumModel.releaseDate)
        let dateString = DateHelper.dateString(from: releaseDate ?? Date())
        
        self.releaseDateLabel.text = "Released \(dateString)"
        self.releaseDateLabel.attachOver(copyrightLabel, with: 0,
                                         leading: paddings.bigPadding,
                                         trailing: -paddings.bigPadding)
    }
    
    private func setupBackButton() {
        self.backButton.backgroundColor = .white.withAlphaComponent(0.5)
        self.backButton.setImage(UIImage(systemName: "chevron.left"),
                                 for: .normal)
        self.backButton.layer.cornerRadius = self.backButton.frame.width / 2
        self.backButton.tintColor = #colorLiteral(red: 0.06666666667, green: 0.07058823529, blue: 0.1490196078, alpha: 1)
        self.backButton.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.hidesBackButton = true
    }
}

