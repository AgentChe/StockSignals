//
//  QuotationsScreenersViewController.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 01.12.2021.
//

import UIKit
import RxSwift

final class QuotationsScreenersViewController: UIViewController {
    lazy var mainView = QuotationsScreenersView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = QuotationsScreenersViewModel(keys: keys)
    
    private let keys: [MarketQuotationsKeysCollectionElement]
    
    private init(keys: [MarketQuotationsKeysCollectionElement]) {
        self.keys = keys
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.keys.drive(onNext: { [weak self] keys in
            self?.mainView.keysCollectionView.setup(elements: keys)
        })
        .disposed(by: disposeBag)
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        mainView.keysCollectionView.didSelect = { [weak self] element in
            self?.viewModel.didSelect.accept(element.key)
        }
        
        mainView.titlesView.scrollDelegate = self
        mainView.titlesView.mainDelegate = self
        mainView.tableView.scrollDelegate = self
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension QuotationsScreenersViewController {
    static func make(keys: [MarketQuotationsKeysCollectionElement]) -> QuotationsScreenersViewController {
        let vc = QuotationsScreenersViewController(keys: keys)
        vc.navigationItem.backButtonTitle = " "
        vc.title = "QuotationsScreeners.Title".localized
        return vc
    }
}

// MARK: WatchListSignalsScrollDelegate
extension QuotationsScreenersViewController: WatchListSignalsScrollDelegate {
    func watchListSignalsDidScroll(_ scrollView: UIScrollView) {
        mainView.titlesView.scroll(as: scrollView)
        mainView.tableView.scroll(as: scrollView)
    }
}

// MARK: WatchListSignalsTitlesViewDelegate
extension QuotationsScreenersViewController: WatchListSignalsTitlesViewDelegate {
    func watchListDidSelect(sort: WatchListSignalsSortElement) {
        viewModel.sort.accept(sort)
    }
}

// MARK: WatchListSignalsTableViewDelegate
extension QuotationsScreenersViewController: WatchListSignalsTableViewDelegate {
    func watchListSignalsDidSelect(quotation: Quotation) {
        let vc = DetailsViewController.make(symbol: quotation.symbol)
        present(vc, animated: true)
    }
}
