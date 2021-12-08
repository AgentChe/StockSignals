//
//  FullUserScreenerMenuViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.12.2021.
//

import UIKit

protocol FullUserScreenerMenuViewControllerDelegate: AnyObject {
    func menuControllerDidSelectEdit()
    func menuControllerDidSelectDelete()
}

final class FullUserScreenerMenuViewController: UIViewController {
    weak var delegate: FullUserScreenerMenuViewControllerDelegate?
    
    lazy var mainView = FullUserScreenerMenuView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.editButton.addTarget(self, action: #selector(tappedEdit), for: .touchUpInside)
        mainView.deleteButton.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
        
        addHideActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.show()
    }
}

// MARK: Make
extension FullUserScreenerMenuViewController {
    static func make() -> FullUserScreenerMenuViewController {
        let vc = FullUserScreenerMenuViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: Private
private extension FullUserScreenerMenuViewController {
    @objc
    func tappedEdit() {
        mainView.hide { [weak self] in
            self?.dismiss(animated: false) {
                self?.delegate?.menuControllerDidSelectEdit()
            }
        }
    }
    
    @objc
    func tappedDelete() {
        mainView.hide { [weak self] in
            self?.dismiss(animated: false) {
                self?.delegate?.menuControllerDidSelectDelete()
            }
        }
    }
    
    func addHideActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        mainView.tappedArea.isUserInteractionEnabled = true
        mainView.tappedArea.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        swipeGesture.direction = .down
        mainView.container.isUserInteractionEnabled = true
        mainView.container.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hide() {
        mainView.hide { [weak self] in
            self?.dismiss(animated: false)
        }
    }
}
