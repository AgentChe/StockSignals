//
//  SearchViewControlller.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 09.11.2021.
//

import UIKit
import RxSwift

final class SearchViewController: UIViewController {
    lazy var mainView = SearchView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SearchViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        mainView.searchTextField.rx.text
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .map { $0 ?? "" }
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)
        
        view.rx.keyboardFrame
            .subscribe(onNext: { [weak self] keyboardFrame in
                let keyboardHeight = keyboardFrame.height
                let insets = UIEdgeInsets(top: 24.scale,
                                          left: 0,
                                          bottom: keyboardHeight > 0 ? keyboardHeight : 24.scale,
                                          right: 0)
                
                self?.mainView.tableView.contentInset = insets
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedStockSignals.drive(onNext: { [weak self] signals in
            let vc = AllSignalsViewController.make(title: "Search.StockSignals".localized,
                                                   stockSignals: signals,
                                                   optionCryptoSignals: nil)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedStockQuotations.drive(onNext: { [weak self] quotations in
            let vc = AllQuotationsViewController.make(title: "Search.StockQuotations".localized, quotations: quotations)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedOptionSignals.drive(onNext: { [weak self] signals in
            let vc = AllSignalsViewController.make(title: "Search.OptionSignals".localized,
                                                   stockSignals: nil,
                                                   optionCryptoSignals: signals)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedOptionQuotations.drive(onNext: { [weak self] quotations in
            let vc = AllQuotationsViewController.make(title: "Search.OptionQuotations".localized, quotations: quotations)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedCryptoSignals.drive(onNext: { [weak self] signals in
            let vc = AllSignalsViewController.make(title: "Search.CryptoSignals".localized,
                                                   stockSignals: nil,
                                                   optionCryptoSignals: signals)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        viewModel.selectedCryptoQuotations.drive(onNext: { [weak self] quotations in
            let vc = AllQuotationsViewController.make(title: "Search.CryptoQuotations".localized, quotations: quotations)
            self?.present(vc, animated: true)
        })
        .disposed(by: disposeBag)
        
        addHideKeyboardAction()
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension SearchViewController {
    static func make() -> SearchViewController {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: SearchTableViewDelegate
extension SearchViewController: SearchTableViewDelegate {
    func searchTableViewDidTapped(symbol: String) {
        // TODO: open detail
    }
    
    func searchTableViewDidTapped(type: SearchTableTypeElement) {
        viewModel.select.accept(type)
    }
}

// MARK: Private
private extension SearchViewController {
    func addHideKeyboardAction() {
        let gesture = UITapGestureRecognizer()
        gesture.cancelsTouchesInView = false
        mainView.tableView.addGestureRecognizer(gesture)
        mainView.tableView.isUserInteractionEnabled = true

        gesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
