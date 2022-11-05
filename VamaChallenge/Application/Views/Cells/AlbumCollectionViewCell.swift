//
//  AlbumCollectionViewCell.swift
//  VamaChallenge
//
//  Created by Oleh Kurnenkov on 03.11.2022.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties
    private var albumCoverImageView = AsyncImageView()
    private var albumTitleLabel = UILabel()
    private var artistNameLabel = UILabel()
    private let padding = Constants.Paddings.mediumPadding

    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentView.layer.cornerRadius = 16
        self.contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with album: AlbumModel) {
        self.albumTitleLabel.text = album.name
        self.artistNameLabel.text = album.artistName
        self.albumCoverImageView.urlString = album.artworkUrl100
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.setupAlbumCoverImageView()
        self.setupArtistNameLabel()
        self.setupTitleLabel()
    }
    
    private func setupAlbumCoverImageView() {
        self.contentView.addSubview(self.albumCoverImageView)
        self.albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        self.albumCoverImageView.attachTo(view: contentView)
    }
    
    private func setupTitleLabel() {
        self.contentView.addSubview(albumTitleLabel)
        self.albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.albumTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.albumTitleLabel.textColor = .white
        self.albumTitleLabel.numberOfLines = 3
        self.albumTitleLabel.textDropShadow()
        self.albumTitleLabel.attachOver(artistNameLabel,
                                         with: 0,
                                         leading: padding,
                                         trailing: -padding)
    }
    
    private func setupArtistNameLabel() {
        self.contentView.addSubview(artistNameLabel)
        self.artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.artistNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.artistNameLabel.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        self.artistNameLabel.numberOfLines = 3
        self.artistNameLabel.textDropShadow()
        self.artistNameLabel.attachToBottom(of: contentView,
                                            with: padding,
                                            leading: padding,
                                            trailing: -padding)
    }
}
