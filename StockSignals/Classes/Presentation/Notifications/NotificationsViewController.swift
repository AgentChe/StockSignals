//
//  NotificationsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.10.2021.
//

import UIKit
import RxSwift

final class NotificationsViewController: UIViewController {
    deinit {
        pushNotificationsManager.remove(observer: self)
    }
    
    lazy var mainView = NotificationsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = NotificationsViewModel()
    
    private lazy var pushNotificationsManager = SDKStorage.shared.pushNotificationsManager
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.tableView.setup(sections: sections)
        })
        .disposed(by: disposeBag)
        
        mainView.pushView.button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.tappedEnablePush()
            })
            .disposed(by: disposeBag)
        
        addFilterActions()
        pushNotificationsManager.add(observer: self)
        pushNotificationsManager.retriveAuthorizationStatus(handler: nil)
    }
}

// MARK: Make
extension NotificationsViewController {
    static func make() -> NotificationsViewController {
        let vc = NotificationsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: PushNotificationsManagerDelegate
extension NotificationsViewController: PushNotificationsManagerDelegate {
    func pushNotificationsManagerDidReceive(authorizationStatus: PushNotificationsAuthorizationStatus) {
        mainView.pushView.isHidden = authorizationStatus == .authorized
        
        let inset = UIEdgeInsets(top: 0,
                                 left: 0,
                                 bottom: authorizationStatus == .authorized ? 0 : mainView.pushView.frame.height + 8.scale,
                                 right: 0)
        mainView.tableView.contentInset = inset
    }
    
    func pushNotificationsManagerDidReceive(token: String?) {
        guard let token = token else {
            return
        }
        
        viewModel
            .send(pushToken: token)
            .subscribe()
            .disposed(by: disposeBag)
    }
}

// MARK: Private
private extension NotificationsViewController {
    func addFilterActions() {
        Observable
            .merge(
                mainView.filterView.stockButton
                    .rx.tap
                    .map { _ in NotificationType.stock },
                
                mainView.filterView.optionButton
                    .rx.tap
                    .map { _ in NotificationType.option },
                
                mainView.filterView.cryptoButton
                    .rx.tap
                    .map { _ in NotificationType.crypto }
            )
            .startWith(.stock)
            .subscribe(onNext: { [weak self] type in
                self?.viewModel.type.accept(type)
                self?.mainView.filterView.type = type
            })
            .disposed(by: disposeBag)
    }
    
    func tappedEnablePush() {
        pushNotificationsManager.retriveAuthorizationStatus { [weak self] status in
            guard let self = self else {
                return
            }
            
            switch status {
            case .authorized:
                self.requestToken()
            case .denied:
                self.goToAppSettings()
            case .notDetermined:
                self.requestToken()
            }
        }
    }
    
    func requestToken() {
        pushNotificationsManager.requestAuthorization()
    }
    
    func goToAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
