//
//  SettingsViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 08.11.2021.
//

import UIKit
import RxSwift
import StoreKit

final class SettingsViewController: UIViewController {
    deinit {
        pushNotificationsManager.remove(observer: self)
    }
    
    lazy var mainView = SettingsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SettingsViewModel()
    
    private lazy var pushNotificationsManager = SDKStorage.shared.pushNotificationsManager
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
        
        pushNotificationsManager.add(observer: self)
        pushNotificationsManager.retriveAuthorizationStatus(handler: nil)
    }
}

// MARK: Make
extension SettingsViewController {
    static func make() -> SettingsViewController {
        let vc = SettingsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: PushNotificationsManagerDelegate
extension SettingsViewController: PushNotificationsManagerDelegate {
    func pushNotificationsManagerDidReceive(authorizationStatus: PushNotificationsAuthorizationStatus) {
        viewModel.pushEnabled.accept(authorizationStatus == .authorized)
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

// MARK: SettingsTableViewDelegate
extension SettingsViewController: SettingsTableViewDelegate {
    func settingsTableDidSelect(element: SettingsTableElement) {
        switch element {
        case .notifications:
            tappedEnablePush()
        case .rateApp:
            SKStoreReviewController.requestReview()
        case .privacyPolicy:
            open(path: GlobalDefinitions.privacyPolicyUrl)
        case .terms:
            open(path: GlobalDefinitions.termsOfServiceUrl)
        case .contactUs:
            open(path: GlobalDefinitions.contactUsUrl)
        default:
            break
        }
    }
    
    func open(path: String) {
        guard let url = URL(string: path) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:])
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
