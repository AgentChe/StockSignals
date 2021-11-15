//
//  AllSignalsSortView.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.11.2021.
//

import UIKit
import RxSwift

protocol AllSignalsSortViewDelegate: AnyObject {
    func allSignalsDidChange(sort: AllSignalsSort)
}

final class AllSignalsSortView: UIButton {
    weak var delegate: AllSignalsSortViewDelegate?
    
    lazy var container = makeContainer()
    lazy var separator = makeSeparator()
    lazy var label = makeTitleLabel()
    lazy var openDateButton = makeOpenDateButton()
    lazy var openDateUpButton = makeOpenDateUpButton()
    lazy var openDateDownButton = makeOpenDateDownButton()
    lazy var maxGainButton = makeMaxGainButton()
    lazy var nameButton = makeNameButton()
    lazy var applyButton = makeApplyButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private var selectedSort = AllSignalsSort.maxGain
    
    private lazy var containerBottomConstraint = NSLayoutConstraint()
    
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
extension AllSignalsSortView {
    func show(selectedSort: AllSignalsSort) {
        self.selectedSort = selectedSort
        
        update()
        
        isHidden = false
        alpha = 0
        
        containerBottomConstraint.isActive = false
        
        containerBottomConstraint.constant = 0
        
        containerBottomConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 1
            self?.layoutIfNeeded()
        })
    }
    
    @objc
    func hide() {
        containerBottomConstraint.isActive = false
        
        containerBottomConstraint.constant = 375.scale
        
        containerBottomConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.alpha = 0
            self?.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.isHidden = true
        })
    }
}

// MARK: Private
private extension AllSignalsSortView {
    func initialize() {
        applyButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.delegate?.allSignalsDidChange(sort: self.selectedSort)
            
            self.hide()
        })
        .disposed(by: disposeBag)
        
        Observable
            .merge(
                openDateButton.rx.tap
                    .map { _ in AllSignalsSort.createdUp },
                
                openDateUpButton.rx.tap
                    .map { _ in AllSignalsSort.createdUp },
                
                openDateDownButton.rx.tap
                    .map { _ in AllSignalsSort.createdDown },
                
                maxGainButton.rx.tap
                    .map { _ in AllSignalsSort.maxGain },
                
                nameButton.rx.tap
                    .map { _ in AllSignalsSort.name }
            )
            .subscribe(onNext: { [weak self] sort in
                self?.selectedSort = sort
                self?.update()
            })
            .disposed(by: disposeBag)
    }
    
    func update() {
        let selectedColor = UIColor(integralRed: 62, green: 89, blue: 223)
        
        openDateUpButton.imageView?.image = openDateUpButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        openDateDownButton.imageView?.image = openDateDownButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        
        openDateButton.setTitleColor(selectedSort == .createdDown || selectedSort == .createdUp ? selectedColor : UIColor.white, for: .normal)
        openDateUpButton.tintColor = selectedSort == .createdUp ? selectedColor : UIColor.white.withAlphaComponent(0.1)
        openDateDownButton.tintColor = selectedSort == .createdDown ? selectedColor : UIColor.white.withAlphaComponent(0.1)
        maxGainButton.setTitleColor(selectedSort == .maxGain ? selectedColor : UIColor.white, for: .normal)
        nameButton.setTitleColor(selectedSort == .name ? selectedColor : UIColor.white, for: .normal)
    }
}

// MARK: Make constraints
private extension AllSignalsSortView {
    func makeConstraints() {
        containerBottomConstraint = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 375.scale)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerBottomConstraint,
            container.heightAnchor.constraint(equalToConstant: 375.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            separator.heightAnchor.constraint(equalToConstant: 4.scale),
            separator.widthAnchor.constraint(equalToConstant: 50.scale),
            separator.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 36.scale)
        ])
        
        NSLayoutConstraint.activate([
            openDateButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            openDateButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -80.scale),
            openDateButton.heightAnchor.constraint(equalToConstant: 24.scale),
            openDateButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            openDateUpButton.widthAnchor.constraint(equalToConstant: 24.scale),
            openDateUpButton.heightAnchor.constraint(equalToConstant: 24.scale),
            openDateUpButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -52.scale),
            openDateUpButton.centerYAnchor.constraint(equalTo: openDateButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            openDateDownButton.widthAnchor.constraint(equalToConstant: 24.scale),
            openDateDownButton.heightAnchor.constraint(equalToConstant: 24.scale),
            openDateDownButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            openDateDownButton.centerYAnchor.constraint(equalTo: openDateButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxGainButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            maxGainButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            maxGainButton.heightAnchor.constraint(equalToConstant: 24.scale),
            maxGainButton.topAnchor.constraint(equalTo: openDateButton.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            nameButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            nameButton.heightAnchor.constraint(equalToConstant: 24.scale),
            nameButton.topAnchor.constraint(equalTo: maxGainButton.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            applyButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            applyButton.heightAnchor.constraint(equalToConstant: 60.scale),
            applyButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -58.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension AllSignalsSortView {
    func makeContainer() -> UIView {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        gesture.direction = .down
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor(integralRed: 42, green: 46, blue: 57)
        view.layer.cornerRadius = 16.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 2.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        
        let view = UILabel()
        view.attributedText = "Signals.Sort.SortBy".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeOpenDateButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.titleLabel?.font = Fonts.SFProDisplay.regular(size: 17.scale)
        view.contentHorizontalAlignment = .left
        view.setTitle("Signals.Sort.OpenDate".localized, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeOpenDateUpButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Signals.ArrowUp"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeOpenDateDownButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Signals.ArrowDown"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeMaxGainButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.titleLabel?.font = Fonts.SFProDisplay.regular(size: 17.scale)
        view.contentHorizontalAlignment = .left
        view.setTitle("Signals.Sort.MaxGain".localized, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeNameButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.titleLabel?.font = Fonts.SFProDisplay.regular(size: 17.scale)
        view.contentHorizontalAlignment = .left
        view.setTitle("Signals.Sort.Name".localized, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeApplyButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.SFProDisplay.bold(size: 19.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 62, green: 89, blue: 223)
        view.layer.cornerRadius = 12.scale
        view.setAttributedTitle("Signals.Sort.Apply".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
