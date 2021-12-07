//
//  AllUserScreenersViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 07.12.2021.
//

import UIKit
import RxSwift

final class AllUserScreenersViewController: UIViewController {
    lazy var mainView = AllUserScreenersView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = AllUserScreenersViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.tableView.setup(elements: sections)
        })
        .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension AllUserScreenersViewController {
    static func make() -> AllUserScreenersViewController {
        let vc = AllUserScreenersViewController()
        vc.navigationItem.title = "AllUserScreeners.Title".localized
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: AllUserScreenersTableViewDelegate
extension AllUserScreenersViewController: AllUserScreenersTableViewDelegate {
    func allUserScreenersDidSelect(symbol: String) {
        let vc = DetailsViewController.make(symbol: symbol)
        present(vc, animated: true)
    }
    
    func allUserScreenersDidSelect(seeAll: UserScreener) {
        let vc = FullUserScreenerViewController.make(userScreener: seeAll)
        navigationController?.pushViewController(vc, animated: true)
    }
}
