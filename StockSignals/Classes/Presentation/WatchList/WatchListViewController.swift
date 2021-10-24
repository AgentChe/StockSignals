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
        case .group(let group):
            break
        }
    }
}

// MARK: WatchListGroupsCollectionViewDelegate
extension WatchListViewController: CreateWatchListGroupViewDelegate {
    func createWatchListDidCreated(group: WatchListGroup) {
        mainView.groupsView.collectionView.add(group: group)
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
}
