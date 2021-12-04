//
//  CSFiltersCollectionFilterCell.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 03.12.2021.
//

final class CSFiltersCollectionFilterCell: UICollectionViewCell {
    var didClearTapped: ((CSFiltersCollectionFilterElement) -> Void)?
    
    lazy var container = makeContainer()
    lazy var titleLabel = makeLabel()
    lazy var valueLabel = makeLabel()
    lazy var clearButton = makeClearButton()
    
    private var element: CSFiltersCollectionFilterElement?
    
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
extension CSFiltersCollectionFilterCell {
    func setup(element: CSFiltersCollectionFilterElement) {
        self.element = element
        
        let isSelected = element.selectedItem != nil
        
        container.backgroundColor = isSelected ? UIColor(integralRed: 62, green: 89, blue: 223) : UIColor(integralRed: 42, green: 46, blue: 57, alpha: 0.7)
        
        clearButton.isHidden = !isSelected
        
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.regular(size: 17.scale))
            .lineHeight(20.4.scale)
        titleLabel.attributedText = element.filter.title.attributed(with: attrs)
        valueLabel.attributedText = element.selectedItem?.value.attributed(with: attrs)
    }
}

// MARK: Private
private extension CSFiltersCollectionFilterCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
    @objc
    func clearTapped() {
        guard let element = element else {
            return
        }
        
        didClearTapped?(element)
    }
}

// MARK: Make constraints
private extension CSFiltersCollectionFilterCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -40.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4.scale)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.widthAnchor.constraint(equalToConstant: 24.scale),
            clearButton.heightAnchor.constraint(equalToConstant: 24.scale),
            clearButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale),
            clearButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CSFiltersCollectionFilterCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeClearButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Screeners.Clear"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
}
