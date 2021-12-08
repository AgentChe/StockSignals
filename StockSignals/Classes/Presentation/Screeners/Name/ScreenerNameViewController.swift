//
//  ScreenerNameViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 04.12.2021.
//

import UIKit
import RxSwift

final class ScreenerNameViewController: UIViewController {
    lazy var mainView = ScreenerNameView()
    
    private lazy var disposeBag = DisposeBag()
    
    private let initialName: String?
    private let confirm: ((String) -> Void)
    
    private init(name: String?, confirm: @escaping ((String) -> Void)) {
        self.initialName = name
        self.confirm = confirm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.rx.keyboardFrame.subscribe(onNext: { [weak self] keyboardFrame in
            guard let self = self else {
                return
            }
            
            self.mainView.update(keyboardFrame: keyboardFrame)
        })
        .disposed(by: disposeBag)
        
        mainView.createButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let name = self.mainView.textField.text else {
                return
            }
            
            self.dismiss(animated: true) { [weak self] in
                self?.confirm(name)
            }
        })
        .disposed(by: disposeBag)
        
        mainView.setup(name: initialName)
        
        addDismissAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.textField.becomeFirstResponder()
    }
}

// MARK: Make
extension ScreenerNameViewController {
    static func make(name: String? = nil, confirm: @escaping ((String) -> Void)) -> ScreenerNameViewController {
        let vc = ScreenerNameViewController(name: name, confirm: confirm)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: Private
private extension ScreenerNameViewController {
    func addDismissAction() {
        let tapGesture = UITapGestureRecognizer()
        mainView.tappedAreaView.isUserInteractionEnabled = true
        mainView.tappedAreaView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
    }
}
