//
//  IndustriesCollectionCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

final class IndustriesCollectionCell: UICollectionViewCell {
    lazy var container = makeContainer()
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
extension IndustriesCollectionCell {
    static func size(for element: IndustriesCollectionElement) -> CGSize {
        let attrs = TextAttributes()
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.4.scale)
        let string = element.industry.name.attributed(with: attrs)
        
        var size = string.size()
        size.width += 32.scale
        size.height += 16.scale
        
        return size
    }
    
    func setup(element: IndustriesCollectionElement) {
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 112, green: 226, blue: 248) : UIColor(integralRed: 42, green: 46, blue: 57)
        
        let textColor = element.isSelected ? UIColor.white : UIColor.white.withAlphaComponent(0.4)
        let attrs = TextAttributes()
            .textColor(textColor)
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(20.4.scale)
        label.attributedText = element.industry.name.attributed(with: attrs)
    }
}

// MARK: Private
private extension IndustriesCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension IndustriesCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension IndustriesCollectionCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 18.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
