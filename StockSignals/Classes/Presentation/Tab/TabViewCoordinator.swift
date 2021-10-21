//
//  CourseViewCoordinator.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import UIKit

final class TabViewCoordinator {
    weak var parentVC: TabViewController?
    
    lazy var signalsVC = NavigationController(rootViewController: UIViewController())
    lazy var notificationsVC = NavigationController(rootViewController: UIViewController())
    lazy var watchListVC = NavigationController(rootViewController: WatchListViewController.make())
    
    private var previousVC: UIViewController?
    
    init(parentVC: TabViewController) {
        self.parentVC = parentVC
    }
    
    func change(tab: TabView.Tab) {
        parentVC?.mainView.tabView.selectedTab = tab
        
        switch tab {
        case .signals:
            changeVC(on: signalsVC)
        case .notifications:
            changeVC(on: notificationsVC)
        case .watchList:
            changeVC(on: watchListVC)
        }
    }
}

// MARK: Private
private extension TabViewCoordinator {
    func changeVC(on vc: UIViewController) {
        if let previousVC = self.previousVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
    
        self.previousVC = vc
        
        guard let parentVC = self.parentVC else {
            return
        }
    
        parentVC.addChild(vc)
        vc.view.frame = parentVC.mainView.container.bounds
        parentVC.mainView.container.addSubview(vc.view)
        vc.willMove(toParent: parentVC)
    }
}
