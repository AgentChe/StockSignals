//
//  OnbStocksView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 28.10.2021.
//

import UIKit
import RxSwift

final class OnbStocksView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var collectionView = makeCollectionView()
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var watchListManager = WatchListManagerCore()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        stocksCollectionDidChangeSelection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: IndustriesCollectionViewDelegate
extension OnbStocksView: OnbStocksCollectionViewDelegate {
    func stocksCollectionDidChangeSelection() {
        let hasSelected = collectionView.elements.contains(where: { $0.isSelected })
        
        button.isEnabled = hasSelected
        button.alpha = hasSelected ? 1 : 0.6
    }
}

// MARK: Private
private extension OnbStocksView {
    func initialize() {
        backgroundColor = UIColor.clear
        
        watchListManager
            .obtainWatchListSignals()
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] signals in
                let elements = signals.map { OnbStocksCollectionElement(signal: $0,
                                                                        isSelected: false) }
                self?.collectionView.setup(elements: elements)

                self?.stocksCollectionDidChangeSelection()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension OnbStocksView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 145.scale : 90.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 12.scale),
            collectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 60.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -57.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OnbStocksView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 32.scale))
            .lineHeight(38.4.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Stocks.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.4))
            .font(Fonts.SFProDisplay.semiBold(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Stocks.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCollectionView() -> OnbStocksCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12.scale
        layout.minimumLineSpacing = 12.scale
        
        let view = OnbStocksCollectionView(frame: .zero, collectionViewLayout: layout)
        view.mainDelegate = self
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(top: 12.scale, left: 24.scale, bottom: 12.scale, right: 24.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.layer.cornerRadius = 16.scale
        view.setAttributedTitle("Onboarding.Next".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
