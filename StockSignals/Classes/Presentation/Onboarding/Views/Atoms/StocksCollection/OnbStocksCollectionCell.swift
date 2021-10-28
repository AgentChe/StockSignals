//
//  OnbStocksCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

final class OnbStocksCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var label = makeLabel()
    
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
extension OnbStocksCollectionCell {
    func setup(element: OnbStocksCollectionElement) {
        iconView.kf.cancelDownloadTask()
        iconView.image = nil
        
        if let url = URL(string: element.signal.imageUrl) {
            iconView.kf.setImage(with: url)
        }
        
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor(integralRed: 42, green: 46, blue: 57)
        
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.4.scale)
            .textAlignment(.center)
        let string = String(format: "%@\n%@", element.signal.company, element.signal.symbol)
        label.attributedText = string.attributed(with: attrs)
    }
}

// MARK: Private
private extension OnbStocksCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension OnbStocksCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 40.scale),
            iconView.heightAnchor.constraint(equalToConstant: 40.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 34.scale),
            iconView.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8.scale),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnbStocksCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 12.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
