//
//  MarketViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 29.11.2021.
//

import UIKit
import RxSwift

final class MarketViewController: UIViewController {
    lazy var mainView = MarketView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MarketViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        mainView.createButton.rx.tap.subscribe(onNext: { [weak self] in
            let vc = CreateScreenerViewController.make()
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension MarketViewController {
    static func make() -> MarketViewController {
        let vc = MarketViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: MarketTableViewDelegate
extension MarketViewController: MarketTableViewDelegate {
    func marketTableDidSelectAllScreeners() {
        viewModel.elements
            .asObservable()
            .take(1)
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] elements in
            let values = elements
                .compactMap { element -> [MarketQuotationsKeysCollectionElement]? in
                    switch element {
                    case .quotations(let elements):
                        return elements.map { $0.key }
                    default:
                        return nil
                    }
                }
            
            guard let keys = values.first else {
                return
            }
            
            let vc = QuotationsScreenersViewController.make(keys: keys)
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    func marketTableDidSelectAllUserScreeners() {
        let vc = AllUserScreenersViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func marketTableDidSelect(seeAll: UserScreener) {
        let vc = FullUserScreenerViewController.make(userScreener: seeAll)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func marketTableDidSelect(symbol: String) {
        let vc = DetailsViewController.make(symbol: symbol)
        present(vc, animated: true)
    }
}
