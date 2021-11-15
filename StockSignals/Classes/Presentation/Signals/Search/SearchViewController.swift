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
        
        addHideKeyboardAction()
        mainView.tableView.listDelegate = self
        mainView.tableView.searchDelegate = self
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

// MARK: SearchTableViewDelegate & SignalsTableViewDelegate
extension SearchViewController: SearchTableViewDelegate & SignalsTableViewDelegate {
    func searchTableViewDidTapped(symbol: String) {
        // TODO: open detail
    }
    
    func searchTableViewDidTapped(type: SearchTableTypeElement) {
        let vc: UIViewController
        
        switch type {
        case .stockSignals:
            vc = AllSignalsViewController.make(title: "Search.StockSignals".localized, filter: .stock)
        case .optionSignals:
            vc = AllSignalsViewController.make(title: "Search.OptionSignals".localized, filter: .option)
        case .cryptoSignals:
            vc = AllSignalsViewController.make(title: "Search.CryptoSignals".localized, filter: .crypto)
        case .stockQuotations:
            vc = AllQuotationsViewController.make(title: "Search.StockQuotations".localized)
        case .optionQuotations:
            vc = AllQuotationsViewController.make(title: "Search.OptionQuotations".localized)
        case .cryptoQuotations:
            vc = AllQuotationsViewController.make(title: "Search.CryptoQuotations".localized)
        }
        
        present(vc, animated: true)
    }
    
    func signalsTableDidSelect(stockSignal: StockSignal) {
        // TODO: open detail
    }
    
    func signalsTableDidSelect(optionCryptoSignal: OptionCryptoSignal) {
        // TODO: open detail
    }
    
    // Используется на экране SignalsViewController
    func signalsTableDidSelect(type: SignalType) {}
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
