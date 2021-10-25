//
//  WatchListViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 21.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class WatchListViewController: UIViewController {
    lazy var mainView = WatchListView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var groupsNavItem: WatchListGroupNavItem = {
        let view = WatchListGroupNavItem(title: "WatchList.Groups.Edit".localized, style: .plain, target: self, action: #selector(groupNavItemTapped))
        view.tintColor = UIColor(integralRed: 62, green: 89, blue: 223)
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable
            .merge(
                mainView.modeView.signalsButton.rx.tap
                    .map { WatchListSelectModeView.Mode.signals },
                
                mainView.modeView.groupsButton.rx.tap
                    .map { WatchListSelectModeView.Mode.groups }
            )
            .subscribe(onNext: { [weak self] mode in
                self?.mainView.modeView.mode = mode
                self?.mainView.updateVisible()
                self?.changeGroupNavItemVisible()
            })
            .disposed(by: disposeBag)
        
        mainView.groupsView.collectionView.mainDelegate = self
        mainView.createGroupView.vc = self
        mainView.createGroupView.delegate = self
        
        mainView.signalsView.viewDidLoad()
        mainView.groupsView.viewDidLoad()
        
        addDismissCreateGroupViewAction()
    }
}

// MARK: Make
extension WatchListViewController {
    static func make() -> WatchListViewController {
        let vc = WatchListViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: WatchListGroupsCollectionViewDelegate
extension WatchListViewController: WatchListGroupsCollectionViewDelegate {
    func watchListGroupDidTapped(element: WatchListGroupsCollectionElement) {
        switch element {
        case .create:
            mainView.createGroupView.present()
        case .group(let element):
            let vc = FavoritesWatchListViewController.make(group: element.group)
            present(vc, animated: true)
        }
    }
    
    func watchListGroupDidRemoveTapped(element: WatchListGroupsCollectionGroupElement) {
        mainView.groupsView.remove(group: element.group)
    }
}

// MARK: WatchListGroupsCollectionViewDelegate
extension WatchListViewController: CreateWatchListGroupViewDelegate {
    func createWatchListDidCreated(group: WatchListGroup) {
        let element = WatchListGroupsCollectionGroupElement(group: group,
                                                            isEditable: groupsNavItem.state == .edit)
        mainView.groupsView.collectionView.add(element: .group(element))
    }
}

// MARK: Private
private extension WatchListViewController {
    func addDismissCreateGroupViewAction() {
        let tapGesture = UITapGestureRecognizer()
        mainView.createGroupView.tappedAreaView.isUserInteractionEnabled = true
        mainView.createGroupView.tappedAreaView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.subscribe(onNext: { [weak self] _ in
            self?.mainView.createGroupView.dismiss()
        })
        .disposed(by: disposeBag)
    }
    
    func changeGroupNavItemVisible() {
        switch mainView.modeView.mode {
        case .signals:
            navigationItem.rightBarButtonItem = nil
        case .groups:
            navigationItem.rightBarButtonItem = groupsNavItem
        }
    }
    
    @objc
    func groupNavItemTapped() {
        mainView.groupsView.collectionView.change(isEditable: groupsNavItem.state == .edit)
        
        groupsNavItem.inverted()
    }
}
