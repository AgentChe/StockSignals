//
//  CSFiltersCollectionSignalCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

final class CSFiltersCollectionSignalCell: UICollectionViewCell {
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
extension CSFiltersCollectionSignalCell {
    static func width(at element: CSFiltersCollectionSignalElement) -> CGFloat {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 15.scale))
        let string = element.item.value.attributed(with: attrs)
        let width = string.size().width + 24.scale
        return width
    }
    
    func setup(element: CSFiltersCollectionSignalElement) {
        container.backgroundColor = element.isSelected ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 15.scale))
            .lineHeight(18.scale)
        label.attributedText = element.item.value.attributed(with: attrs)
    }
}

// MARK: Private
private extension CSFiltersCollectionSignalCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension CSFiltersCollectionSignalCell {
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
private extension CSFiltersCollectionSignalCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10.scale
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
