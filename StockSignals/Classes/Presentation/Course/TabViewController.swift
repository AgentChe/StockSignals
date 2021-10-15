//
//  CourseViewController.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit
import RxSwift

final class TabViewController: UIViewController {
    lazy var mainView = TabMainView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var coordinator = TabViewCoordinator(parentVC: self)
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addActionsToTabs()
        
        rx.methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.update(selectedTab: .signals)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension TabViewController {
    static func make() -> TabViewController {
        let vc = TabViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension TabViewController {
    func addActionsToTabs() {
        let signalsGesture = UITapGestureRecognizer()
        mainView.tabView.signalsItem.isUserInteractionEnabled = true
        mainView.tabView.signalsItem.addGestureRecognizer(signalsGesture)
        
        let notificationsGesture = UITapGestureRecognizer()
        mainView.tabView.notificationsItem.isUserInteractionEnabled = true
        mainView.tabView.notificationsItem.addGestureRecognizer(notificationsGesture)
        
        let watchListGesture = UITapGestureRecognizer()
        mainView.tabView.watchListItem.isUserInteractionEnabled = true
        mainView.tabView.watchListItem.addGestureRecognizer(watchListGesture)
        
        Observable
            .merge([
                signalsGesture.rx.event.map { _ in TabView.Tab.signals },
                notificationsGesture.rx.event.map { _ in TabView.Tab.notifications },
                watchListGesture.rx.event.map { _ in TabView.Tab.watchList }
            ])
            .subscribe(onNext: { [weak self] tab in
                self?.update(selectedTab: tab)
            })
            .disposed(by: disposeBag)
    }
    
    func update(selectedTab: TabView.Tab) {
        coordinator.change(tab: selectedTab)
    }
}
