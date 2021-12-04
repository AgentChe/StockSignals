//
//  CreateScreenerViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 02.12.2021.
//

import UIKit
import RxSwift

final class CreateScreenerViewController: UIViewController {
    lazy var mainView = CreateScreenerView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = CreateScreenerViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sections.drive(onNext: { [weak self] sections in
            self?.mainView.collectionView.setup(sections: sections)
        })
        .disposed(by: disposeBag)
        
        mainView.collectionView.vc = self
    }
}

// MARK: Make
extension CreateScreenerViewController {
    static func make() -> CreateScreenerViewController {
        let vc = CreateScreenerViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.title = "CreateScreener.Title".localized
        return vc
    }
}
