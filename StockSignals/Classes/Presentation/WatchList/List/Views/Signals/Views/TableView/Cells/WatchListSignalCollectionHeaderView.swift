//
//  WatchListSignalCollectionHeaderView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 22.10.2021.
//

import UIKit
import Kingfisher

final class WatchListSignalCollectionHeaderView: UICollectionReusableView {
    lazy var imageView = makeImageView()
    lazy var symbolLabel = makeLabel()
    lazy var companyLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WatchListSignalCollectionHeaderView {
    func setup(header: WatchListSignalCollectionHeader) {
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        
        if let path = header.imageUrl, let url = URL(string: path) {
            imageView.kf.setImage(with: url)
        }
        
        symbolLabel.attributedText = header.symbol
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.SFProDisplay.bold(size: 13.scale))
                            .lineHeight(15.6.scale))
        
        companyLabel.attributedText = header.company
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white.withAlphaComponent(0.4))
                            .font(Fonts.SFProDisplay.regular(size: 13.scale))
                            .lineHeight(15.6.scale))
    }
}

// MARK: Private
private extension WatchListSignalCollectionHeaderView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 24, green: 26, blue: 36)
    }
}

// MARK: Make constraints
private extension WatchListSignalCollectionHeaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 36.scale),
            imageView.heightAnchor.constraint(equalToConstant: 36.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56.scale),
            symbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            symbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56.scale),
            companyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension WatchListSignalCollectionHeaderView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 18.scale
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
